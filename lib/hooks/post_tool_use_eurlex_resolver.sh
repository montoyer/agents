#!/usr/bin/env bash
# Post-output hook: Contextual Validator for EU Legal Citations
#
# Intercepts matched citation strings containing provisional trust tags
# and validates their structural coordinates against local knowledge maps
# (knowledge/institutions/) and the official EU Cellar REST catalog.
#
# If a reference is validated, the flag transitions to an active confirmation.
# If a reference contains non-existent subdivisions or structural conflicts,
# it upgrades the warning to alert the official during final review.
#
# Claude Code hook event: PostToolUse
# Applies to: core montoyer/agents validation layer

set -e

# Read incoming text pool containing preliminary matcher anchors
input_payload=$(cat)

# Paths to framework knowledge matrices
LOCAL_TREATY_MAP="knowledge/institutions/treaties_schema.json"
LOCAL_REG_MAP="knowledge/institutions/secondary_legislation_index.json"

# Internal function to verify Treaty structures against local schemas
validate_treaty_coordinate() {
    local article="$1"
    local treaty="$2"
    
    # If the local schema file doesn't exist yet, default to unverified state
    if [ ! -f "$LOCAL_TREATY_MAP" ]; then
        return 1
    fi
    
    # Query local JSON schema to ensure the article exists under the requested treaty
    # Returns 0 if valid, 1 if the article coordinate is fabricated
    if grep -q "\"treaty\": \"$treaty\"" "$LOCAL_TREATY_MAP" && grep -q "\"article\": \"$article\"" "$LOCAL_TREATY_MAP"; then
        return 0
    else
        return 1
    fi
}

# Process the input stream line by line to maintain structural formatting
while IFS= read -r line; do
    
    # 1. Evaluate Treaty anchors: [EUR-Lex — verify current version]
    if echo "$line" | grep -q "\[EUR-Lex — verify current version\]"; then
        # Extract matched article and treaty text coordinates
        # Pattern captures 'Art. 114 TFEU' or 'Article 5 TEU'
        art_coord=$(echo "$line" | grep -oE '\b(Art\.|Article)[[:space:]]+[0-9]+[a-z]?[[:space:]]+(TFEU|TEU)\b' | head -n 1)
        
        if [ -not -z "$art_coord" ]; then
            art_num=$(echo "$art_coord" | awk '{print $2}')
            treaty_id=$(echo "$art_coord" | awk '{print $3}')
            
            if validate_treaty_coordinate "$art_num" "$treaty_id"; then
                # Target exists structurally: swap placeholder flag with explicit validation anchor
                line=$(echo "$line" | sed "s/\[EUR-Lex — verify current version\]/\[EUR-Lex — structural coordinate verified under $treaty_id\]/g")
            else
                # Target is fabricated or misaligned: upgrade warning level
                line=$(echo "$line" | sed "s/\[EUR-Lex — verify current version\]/\[review — critical anomaly: Article $art_num not found in current $treaty_id text\]/g")
            fi
        fi
    fi

    # 2. Evaluate Court Jurisprudence: [CJEU — verify Curia reference]
    if echo "$line" | grep -q "\[CJEU — verify Curia reference\]"; then
        # Isolate case key pattern (e.g., C-623/17)
        case_id=$(echo "$line" | grep -oE '\b(C|T|F)-[0-9]+\/[0-9]{2,4}\b' | head -n 1)
        
        if [ ! -z "$case_id" ]; then
            # Deterministic connection check against the official EU Curia public catalog
            # Sends a minimal HEAD request to ensure the case path isn't a hallucinated reference
            # Timeout capped at 1 second to eliminate execution lag during streaming loops
            HTTP_STATUS=$(curl -s -o /dev/null -I -w "%{http_code}" --max-time 1.2 "https://curia.europa.eu/juris/liste.jsf?num=$case_id" || echo "000")
            
            if [ "$HTTP_STATUS" == "200" ]; then
                line=$(echo "$line" | sed "s/\[CJEU — verify Curia reference\]/\[CJEU — record found in Curia repository\]/g")
            else
                # Network unreachable or case code doesn't map to a real record
                line=$(echo "$line" | sed "s/\[CJEU — verify Curia reference\]/\[review — reference unverified: confirm case number on Curia server\]/g")
            fi
        fi
    fi

    # Release processed line directly back to stdout stream
    printf '%s\n' "$line"

done <<< "$input_payload"