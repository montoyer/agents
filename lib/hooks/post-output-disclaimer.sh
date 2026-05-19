#!/usr/bin/env bash
# Post-output hook: appends the mandatory draft disclaimer to every skill output.
#
# Triggered after any tool call that produces a substantive text output.
# Ensures no output from this plugin reaches a user without the review notice.
#
# Claude Code hook event: PostToolUse
# Applies to: all skill outputs across all domain packages

DISCLAIMER="
---
DRAFT — For review by an EU official before use. Not an official Commission position.
"

# The hook receives the tool output on stdin.
# It appends the disclaimer and passes the result to stdout.
#
# If the output already ends with the disclaimer (e.g., because a template
# includes it), the hook skips the append to avoid duplication.

input=$(cat)

if echo "$input" | grep -q "Not an official Commission position"; then
  echo "$input"
else
  printf '%s\n%s\n' "$input" "$DISCLAIMER"
fi
