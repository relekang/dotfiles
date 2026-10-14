---
name: comments
description: Guidance for working with code comments and review comments. Use when asked to add, edit, remove comments in code.
---

# Comments

Go through the code in the current working set, e.g. checked out branch, set of
PRs working on or uncommitted code. This skill can be invoked with a reference
to code or code changes like a PR reference as well.

Evaluate each introduced or edited comment and consider:

- In production code, keep a comment only when it adds information that the
  code cannot state clearly.
- In tests, use a lower threshold for comments. Keep or add concise comments
  that identify the scenario, separate test phases, explain non-obvious setup,
  or state why an assertion is important. A test comment can improve scanning
  and maintenance even when the test code shows the mechanics.
- Do not keep comments that only repeat the code.
- Make sure it uses ASD-STE100 Simplified Technical English
- Remove special analogies
- Make sure the comment does not describe transitive behaviour that might
  change without touching the code it describes.
