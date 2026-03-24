# AGENTS.md

Guidance for coding agents working in this dotfiles repository.

## Project overview

- This repo manages personal shell/editor/terminal configuration files.
- Most installation logic is in `Makefile` and `initial.sh`.
- Many targets create symlinks from repo files into `$HOME`.

## Important paths

- `Makefile`: main install/link automation.
- `zshrc`, `zshenv`, `zsh-custom/`: shell setup.
- `git/`: git config and helper scripts.
- `jj/`: `jj` configuration.
- `vimfiles/`, `vscode/`, `k9s/`, `i3/`, `macos/`, `linux`: tool/OS-specific config.
- `secret-aliases`: local secrets placeholder; do not commit real secrets.

## Working rules

- Prefer small, targeted edits that preserve existing style.
- Do not rewrite unrelated dotfiles or normalize formatting globally.
- Avoid destructive operations on user machine paths outside this repo.
- If a change affects symlink targets in `$HOME`, update `Makefile` targets consistently.

## Validation

- For install logic changes, run the narrowest relevant `make` target when possible.
- For script changes, run shell syntax checks where practical (for example: `bash -n <script>`).
- Do not run broad system-setup targets unless explicitly requested.

## Commit guidance

- Use Conventional Commits.
- Keep commit messages concise and focused on intent.
- Do not include a scope in the commit type (for example: `fix: ...`, not `fix(shell): ...`).
