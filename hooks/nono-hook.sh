#!/bin/bash
# nono-hook.sh - Claude Code hook for nono sandbox diagnostics
# Package variant based on the built-in nono Claude Code hook.

if [ -z "${NONO_CAP_FILE:-}" ] || [ ! -f "$NONO_CAP_FILE" ]; then
    exit 0
fi

if ! command -v jq >/dev/null 2>&1; then
    exit 0
fi

CAPS=$(jq -r '.fs[] | "  " + (.resolved // .path) + " (" + .access + ")"' "$NONO_CAP_FILE" 2>/dev/null)
NET=$(jq -r 'if .net_blocked then "blocked" else "allowed" end' "$NONO_CAP_FILE" 2>/dev/null)

CONTEXT="[NONO SANDBOX - PERMISSION DENIED]

STOP. Do not try alternative approaches. This is a hard security boundary.

You are running inside the nono security sandbox. The operation you just attempted is permanently blocked for this session.

ALLOWED PATHS (everything else is blocked):
$CAPS
Network: $NET

FORBIDDEN ACTIONS - DO NOT ATTEMPT:
- Trying alternative file paths
- Copying files to allowed locations
- Using sudo or changing permissions
- Suggesting the user run commands manually
- Any other workaround

REQUIRED ACTION:
Tell the user they must exit this Claude session and restart with the needed path, for example:

  nono run --allow /path/to/needed -- claude

This is the only solution. The sandbox cannot be modified from within."

jq -n --arg ctx "$CONTEXT" '{
  "hookSpecificOutput": {
    "hookEventName": "PostToolUseFailure",
    "additionalContext": $ctx
  }
}'
