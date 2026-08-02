#!/usr/bin/env bash
# gen-index.sh
{
  echo "# Repo Index"
  echo
  echo "_Generated $(date -u '+%Y-%m-%d')_"
  echo
  gh repo list AarushX --limit 1000 \
    --json name,description,visibility,isArchived,pushedAt,repositoryTopics,primaryLanguage \
    --jq 'sort_by(.pushedAt) | reverse | .[] |
      "- **\(.name)**\(if .isArchived then " `archived`" else "" end) — \(.description // "_no description_")  \n  `\(.primaryLanguage.name // "?")` · \(.pushedAt[:10]) · \([.repositoryTopics[]?.name] | join(", "))"'
} > INDEX.md
