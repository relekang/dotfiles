# AGENTS.md

Guidance for coding agents working in this dotfiles repository.

## Project overview

- This repo is a `chezmoi` source directory for personal shell/editor/terminal configuration files.
- Bootstrap entrypoints are `initial.sh` and direct `chezmoi init --apply`.
- `.chezmoiroot` sets `home/` as the source root for managed files.
- Most managed files use `chezmoi` naming such as `dot_*`, `private_*`, and `run_onchange_*`.

## Important paths

- `home/dot_zshrc`, `home/dot_zshenv`, `home/dot_config/zsh/`: shell setup.
- `home/dot_gitconfig`, `home/dot_config/git/`: git config and helper data.
- `home/dot_config/jj/`: `jj` configuration.
- `home/dot_tmux.conf`, `home/dot_local/share/tmux-templates/`: tmux setup.
- `home/dot_local/bin/`: installed helper scripts.
- `home/dot_config/i3/`, `home/dot_i3status.conf.tmpl`: tagged Linux/i3 config.
- `home/private_dot_config/zsh/private-aliases.zsh`: private aliases; do not commit real secrets.
- `home/chezmoi_scripts/run_onchange_*`: provisioning hooks for default and tagged setup.

## Working rules

- Prefer small, targeted edits that preserve existing style.
- Do not rewrite unrelated dotfiles or normalize formatting globally.
- Avoid destructive operations on user machine paths outside this repo.
- If a change affects installed destinations in `$HOME`, keep the corresponding `chezmoi` source files and scripts consistent.

## Validation

- For install logic changes, run the narrowest relevant `chezmoi` or script validation step when possible.
- For script changes, run shell syntax checks where practical (for example: `bash -n <script>`).
- Do not run broad system-setup targets unless explicitly requested.

## Commit guidance

- Use Conventional Commits.
- Keep commit messages concise and focused on intent.
- Do not include a scope in the commit type (for example: `fix: ...`, not `fix(shell): ...`).
