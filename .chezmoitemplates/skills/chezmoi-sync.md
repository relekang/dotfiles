---
name: chezmoi-sync
description: Use when a managed file was changed directly in $HOME and the chezmoi source repo must be updated to match it. Also use when the user asks to inspect `chezmoi diff` or `chezmoi apply` changes and incorporate them in this repo.
---

# Chezmoi sync

Use this process when a file that chezmoi manages was changed outside the source repo.

1. Use the `jujutsu` skill first for all VCS steps.
2. Run `jj st`. If the working copy already has changes, ask before you mix work or create a new change with `jj new`.
3. Set the commit message before edits with `jj desc -m "..."`.
4. Run `chezmoi diff`. Treat this as the change that `chezmoi apply` would make to `$HOME`.
5. For each changed target file, find its source file with `chezmoi source-path <target-path>`.
6. Inspect the target file and the source file. Do not assume that all diff hunks are wanted.
7. Update only the necessary source files so they match the accepted target changes.
   - Prefer small edits to the source files.
   - Preserve chezmoi templates and private file rules.
   - Do not run broad setup scripts.
8. Run `chezmoi diff` again. The expected result is no output for the accepted changes.
9. Run the narrowest validation that applies, such as `zsh -n` for shell files or JSON parsing for JSON files.
10. If the accepted changes are unrelated, split them into separate jj changes and give each change a conventional commit message.
11. Finish with `jj new` when the final change has content, then run `jj st`.

Never run `chezmoi apply` to solve this task unless the user asks for it. `apply` writes to `$HOME`; this workflow updates the source repo instead.
