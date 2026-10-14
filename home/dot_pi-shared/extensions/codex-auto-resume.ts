import type {
	ExtensionAPI,
	ExtensionContext,
} from "@earendil-works/pi-coding-agent";

const RETRY_DELAY_MS = 15 * 60 * 1000;
const LIMIT_ERROR = /the usage limit has been reached/i;
const STATUS_KEY = "codex-auto-resume";

export default function (pi: ExtensionAPI) {
	let limitReached = false;
	let retryAt = 0;
	let retryTimer: ReturnType<typeof setTimeout> | undefined;
	let statusTimer: ReturnType<typeof setInterval> | undefined;
	let activeContext: ExtensionContext | undefined;

	function clearWait(): void {
		if (retryTimer) clearTimeout(retryTimer);
		if (statusTimer) clearInterval(statusTimer);
		retryTimer = undefined;
		statusTimer = undefined;
		retryAt = 0;
		activeContext?.ui.setStatus(STATUS_KEY, undefined);
	}

	function updateStatus(): void {
		if (!activeContext || retryAt === 0) return;
		const minutes = Math.max(1, Math.ceil((retryAt - Date.now()) / 60_000));
		activeContext.ui.setStatus(STATUS_KEY, `Codex retry in ${minutes}m`);
	}

	pi.on("message_end", (event) => {
		if (event.message.role !== "assistant") return;

		const isCodex = event.message.provider === "openai-codex";
		limitReached =
			isCodex &&
			event.message.stopReason === "error" &&
			LIMIT_ERROR.test(event.message.errorMessage ?? "");
	});

	pi.on("agent_start", () => {
		limitReached = false;
		clearWait();
	});

	pi.on("agent_settled", (_event, ctx) => {
		if (!limitReached || retryTimer) return;

		activeContext = ctx;
		retryAt = Date.now() + RETRY_DELAY_MS;
		updateStatus();
		statusTimer = setInterval(updateStatus, 60_000);
		retryTimer = setTimeout(() => {
			clearWait();
			ctx.ui.notify("Retrying the task after the Codex usage limit.", "info");
			pi.sendUserMessage("Continue the previous task.");
		}, RETRY_DELAY_MS);
	});

	pi.on("session_shutdown", () => {
		clearWait();
		activeContext = undefined;
	});
}
