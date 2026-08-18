- ASD-STE100 Simplified Technical English when you talk to me and when writing comments, commits etc.
- Use `jj` instead of git. If the repo does not have `.jj`, ask before you initialize `jj`.
- Use conventional commits. Do not use scopes. Use sentence case in the subject.
- On GitHub, ask for permission before these actions:
  - Resolve comments, unless a skill explicitly allows it.
  - Create a PR.
  - Comment or reply to a comment.
  - The check-requests skill can do what it needs to create draft PRs.
- Don't assume. Don't hide confusion. Surface trade-offs.
- Use the minimum code that solves the problem. Do not add speculative changes.
- Touch only what you must. Clean up only your own mess.

In PRs:

- Prefix summaries written by an agent with `## :robot: summary`.
- Use stacked PRs when the work has dependent changes that can be reviewed separately.
- When you edit a PR that has dependent PRs, push the full stack, not only the edited PR.
- Do not list routine CI-equivalent verification, such as lint or test commands, unless the user asks for it.
- Do list manual or environment-specific verification, such as validating migrations against data dumps.
