---
name: comments
description: Guidance for working with code comments and review comments. Use when asked to add, edit, remove comments in code.
---

# Comments

Go through the code in the current working set, e.g. checked out branch, set of
PRs working on or uncommitted code. This skill can be invoked with a reference
to code or code changes like a PR reference as well.

Evaluate each introduced or edited comment and consider:

- Is this comment absolutely necessary? If not, remove it. Unsure, ask, but
  that should probably be rare.
- Make sure it uses ASD-STE100 Simplified Technical English
- Remove special analogies
- Make sure the comment does not describe transitive behaviour that might
  change without touching the code it describes.
