#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

badge_sql="![SQL](https://img.shields.io/badge/sql-SQL-blue)"
total=50
count="$(ls -d [0-9][0-9][0-9][0-9]-* 2>/dev/null | wc -l | tr -d ' ')"
badge_progress="![Progress](https://img.shields.io/badge/progress-${count}%2F${total}-brightgreen)"

{
  printf '%s\n\n' "# LeetCode SQL 50"
  printf '%s\n' "$badge_sql"
  printf '%s\n\n' "$badge_progress"
  printf '%s\n\n' "Curated SQL solutions for the LeetCode SQL 50 study plan. Each folder contains the original problem statement and a single \`.sql\` solution file."
  printf '%s\n\n' "## Repository structure"
  printf '%s\n' "- \`####-problem-slug/README.md\`: LeetCode problem statement"
  printf '%s\n\n' "- \`####-problem-slug/####-problem-slug.sql\`: SQL solution"
  printf '%s\n\n' "## Problems"
  printf '%s\n' "| ID | Title | Difficulty | Solution |"
  printf '%s\n' "| --- | --- | --- | --- |"
  for dir in [0-9][0-9][0-9][0-9]-*; do
    readme="$dir/README.md"
    sql="$dir/$dir.sql"
    if [[ -f "$readme" && -f "$sql" ]]; then
      header="$(head -n 1 "$readme")"
      id="$(printf '%s' "$header" | sed -n 's/.*>\([0-9]\+\)\. .*/\1/p')"
      title="$(printf '%s' "$header" | sed -n 's/.*>\([0-9]\+\)\. \(.*\)<\/a>.*/\2/p')"
      url="$(printf '%s' "$header" | sed -n 's/.*href="\(.*\)">.*/\1/p')"
      difficulty="$(printf '%s' "$header" | sed -n 's/.*<h3>\(.*\)<\/h3>.*/\1/p')"
      if [[ -n "$id" && -n "$title" && -n "$url" && -n "$difficulty" ]]; then
        printf '| %s | [%s](%s) | %s | `%s` |\n' "$id" "$title" "$url" "$difficulty" "$sql"
      fi
    fi
  done
  printf '\n%s\n\n' "## Notes"
  printf '%s\n' "- Solutions are written to match LeetCode's SQL dialect expectations."
  printf '%s\n\n' "- Folder names follow \`####-problem-slug\` for quick lookup."
  printf '%s\n\n' "## Maintenance"
  printf '%s\n\n' "Regenerate this README after adding new problems:"
  printf '%s\n' '```bash'
  printf '%s\n' './scripts/generate-readme.sh'
  printf '%s\n' '```'
} > README.md
