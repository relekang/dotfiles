---
name: fix-pr-comments
description: Workflow to follow when asked to fix pr comments
---

Fix the linked comments. If no comments are specified, ASK if all comments on
the PR should be fixed.

Workflow:
1. Fix one comment at a time.
2. After each fix, put the change into the correct jj commit before you start the
   next fix.
   - Do not read this as "always run `jj absorb`".
   - First inspect the stack and the diff. Decide which commit should contain the
     fix.
   - Use the smallest safe jj operation for that case, such as `jj squash`,
     `jj restore`, or `jj absorb`.
   - Only use `jj absorb` when it clearly targets the correct commit. If it is
     unclear, do not run it. Ask or use a safer explicit operation.
   - After any jj mutation, run `jj st` and check that no extra changes moved.
3. Push after all fixes are done.
4. React with thumbs up if it is fully fixed and I did not make the comment.
5. Resolve the thread after pushing.
6. Do not comment on the thread.
7. Flag anything that must be looked into.
