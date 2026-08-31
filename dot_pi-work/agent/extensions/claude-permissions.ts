import * as fs from "node:fs";
import * as path from "node:path";
import type { ExtensionAPI } from "@mariozechner/pi-coding-agent";

type PermissionLists = {
	allow: string[];
	ask: string[];
	deny: string[];
};

type PermissionState = {
	claudeDir?: string;
	files: string[];
	permissions: PermissionLists;
};

function isRecord(value: unknown): value is Record<string, unknown> {
	return typeof value === "object" && value !== null;
}

function asStringArray(value: unknown): string[] {
	if (!Array.isArray(value)) return [];
	return value.filter((item): item is string => typeof item === "string");
}

function findClaudeDir(startCwd: string): string | undefined {
	let current = path.resolve(startCwd);

	while (true) {
		const candidate = path.join(current, ".claude");
		if (fs.existsSync(candidate) && fs.statSync(candidate).isDirectory()) {
			return candidate;
		}

		const parent = path.dirname(current);
		if (parent === current) return undefined;
		current = parent;
	}
}

function readPermissionFile(filePath: string): PermissionLists {
	if (!fs.existsSync(filePath)) {
		return { allow: [], ask: [], deny: [] };
	}

	try {
		const parsed = JSON.parse(fs.readFileSync(filePath, "utf8")) as unknown;
		const permissions = isRecord(parsed) && isRecord(parsed.permissions) ? parsed.permissions : {};
		return {
			allow: asStringArray(permissions.allow),
			ask: asStringArray(permissions.ask),
			deny: asStringArray(permissions.deny),
		};
	} catch {
		return { allow: [], ask: [], deny: [] };
	}
}

function loadPermissionState(startCwd: string): PermissionState {
	const claudeDir = findClaudeDir(startCwd);
	if (!claudeDir) {
		return {
			claudeDir: undefined,
			files: [],
			permissions: { allow: [], ask: [], deny: [] },
		};
	}

	const settingsPath = path.join(claudeDir, "settings.json");
	const localSettingsPath = path.join(claudeDir, "settings.local.json");
	const settings = readPermissionFile(settingsPath);
	const localSettings = readPermissionFile(localSettingsPath);

	return {
		claudeDir,
		files: [settingsPath, localSettingsPath].filter((filePath) => fs.existsSync(filePath)),
		permissions: {
			allow: [...settings.allow, ...localSettings.allow],
			ask: [...settings.ask, ...localSettings.ask],
			deny: [...settings.deny, ...localSettings.deny],
		},
	};
}

function escapeRegex(text: string): string {
	return text.replace(/[|\\{}()[\]^$+?.]/g, "\\$&");
}

function globToRegex(pattern: string): RegExp {
	const escaped = escapeRegex(pattern).replace(/\*/g, ".*");
	return new RegExp(`^${escaped}$`);
}

function normalizePathArg(value: unknown): string {
	if (typeof value !== "string") return "";
	return value.startsWith("@") ? value.slice(1) : value;
}

function getCandidates(event: { toolName: string; input: any }): string[] {
	switch (event.toolName) {
		case "bash": {
			const command = typeof event.input.command === "string" ? event.input.command : "";
			return ["bash", `Bash(${command})`];
		}
		case "read": {
			const targetPath = normalizePathArg(event.input.path);
			return ["read", `Read(${targetPath})`];
		}
		case "write": {
			const targetPath = normalizePathArg(event.input.path);
			return ["write", `Write(${targetPath})`];
		}
		case "edit": {
			const targetPath = normalizePathArg(event.input.path);
			return ["edit", `Edit(${targetPath})`];
		}
		default:
			return [event.toolName];
	}
}

function matchesPermission(pattern: string, candidate: string): boolean {
	const patternMatch = pattern.match(/^([^()]+)\((.*)\)$/);
	const candidateMatch = candidate.match(/^([^()]+)\((.*)\)$/);

	if (patternMatch) {
		if (!candidateMatch) return false;
		const [, patternTool, patternBody] = patternMatch;
		const [, candidateTool, candidateBody] = candidateMatch;
		if (patternTool !== candidateTool) return false;
		return globToRegex(patternBody).test(candidateBody);
	}

	return globToRegex(pattern).test(candidate);
}

function firstMatch(patterns: string[], candidates: string[]): string | undefined {
	for (const pattern of patterns) {
		if (candidates.some((candidate) => matchesPermission(pattern, candidate))) {
			return pattern;
		}
	}
	return undefined;
}

export default function claudePermissionsExtension(pi: ExtensionAPI) {
	pi.on("session_start", async (_event, ctx) => {
		const state = loadPermissionState(ctx.cwd);
		if (!state.claudeDir || state.files.length === 0) return;

		ctx.ui.notify(
			`Loaded Claude permissions from ${path.relative(ctx.cwd, state.claudeDir) || ".claude"} (${state.permissions.deny.length} deny, ${state.permissions.ask.length} ask, ${state.permissions.allow.length} allow)` ,
			"info",
		);
	});

	pi.on("tool_call", async (event, ctx) => {
		const state = loadPermissionState(ctx.cwd);
		if (state.files.length === 0) return undefined;

		const candidates = getCandidates(event);
		const denyMatch = firstMatch(state.permissions.deny, candidates);
		if (denyMatch) {
			return { block: true, reason: `Blocked by Claude permissions deny rule: ${denyMatch}` };
		}

		const allowMatch = firstMatch(state.permissions.allow, candidates);
		if (allowMatch) {
			return undefined;
		}

		const askMatch = firstMatch(state.permissions.ask, candidates);
		if (askMatch) {
			if (!ctx.hasUI) {
				return { block: true, reason: `Claude permissions require confirmation: ${askMatch}` };
			}

			const detail = candidates.find((candidate) => candidate.includes("(")) ?? event.toolName;
			const allowed = await ctx.ui.confirm(
				"Claude permission check",
				`Rule matched: ${askMatch}\n\nTool call: ${detail}\n\nAllow this tool call?`,
			);

			if (!allowed) {
				return { block: true, reason: `Blocked by user via Claude ask rule: ${askMatch}` };
			}
		}

		return undefined;
	});

	pi.registerCommand("claude-permissions", {
		description: "Show active Claude permissions from .claude/settings*.json",
		handler: async (_args, ctx) => {
			const state = loadPermissionState(ctx.cwd);
			if (state.files.length === 0) {
				ctx.ui.notify("No .claude/settings.json or .claude/settings.local.json found", "info");
				return;
			}

			const lines = [
				`Claude dir: ${state.claudeDir}`,
				`Files: ${state.files.join(", ")}`,
				`deny (${state.permissions.deny.length}): ${state.permissions.deny.join(", ") || "-"}`,
				`ask (${state.permissions.ask.length}): ${state.permissions.ask.join(", ") || "-"}`,
				`allow (${state.permissions.allow.length}): ${state.permissions.allow.join(", ") || "-"}`,
			];
			ctx.ui.notify(lines.join("\n"), "info");
		},
	});
}
