#!/usr/bin/env bash
# Post-output hook: intercepts agent generation output to match EU legal citations
# and dynamically append inline validation trust tags.
#
# Triggered after any policy-officer, legislative-drafter, or legal specialist
# skill outputs draft text. It scans for Treaties (TFEU/TEU), Secondary Legislation
# (Regulations/Directives), and CJEU case files.
#
# Claude Code hook event: PostToolUse
# Applies to: core montoyer/agents domain layer

# Read incoming generation substrate from standard input
input=$(cat)

# 1. Isolate and tag Treaty References (e.g., Art. 114 TFEU, Article 5 TEU)
# Matches "Art. X TFEU" or "Article Y TEU" and injects the EUR-Lex validation anchor.
processed_output=$(echo "$input" | sed -E 's/\b(Art\.|Article)[[:space:]]+([0-9]+[a-z]?)[[:space:]]+(TFEU|TEU)\b/\0 [EUR-Lex — verify current version]/g')

# 2. Isolate and tag Secondary Legislation (e.g., Regulation (EU) 2016/679, Directive (EC) 2026/112)
# Matches type, jurisdiction identifier, year, and sequence number.
processed_output=$(echo "$processed_output" | sed -E 's/\b(Regulation|Directive|Decision)[[:space:]]+\((EU|EC|Euratom)\)[[:space:]]+([0-9]{4})\/([0-9]+)\b/\0 [EUR-Lex — verify current version]/g')

# 3. Isolate and tag Court of Justice Case Law (e.g., Case C-623/17, T-12/22)
# Matches CJEU, General Court, and Civil Service Tribunal jurisdictional formats.
processed_output=$(echo "$processed_output" | sed -E 's/\b(Case[[:space:]]+)?(C|T|F)-([0-9]+)\/([0-9]{2,4})\b/\0 [CJEU — verify Curia reference]/g')

# 4. Inject structural warning if complex processing phrases exist without explicit legal boundaries
# Checks for automated profile matching or triage blocks that demand strict EUDPR scrutiny.
if echo "$processed_output" | grep -qEi "automated processing|triage module|profiling algorithm"; then
    if ! echo "$processed_output" | grep -qEi "2018/1725|EUDPR"; then
        WARNING_TAG=" [review — legal uncertainty regarding automated triage exceptions under EUDPR 2018/1725]"
        # Append the warning to the line containing the risky processing phrase
        processed_output=$(echo "$processed_output" | sed -E "s/(.*(automated processing|triage module|profiling algorithm).*)/\1$WARNING_TAG/Ig")
    fi
fi

# Release verified stream payload back to the main terminal context
printf '%s\n' "$processed_output"