#!/usr/bin/env bash
set -euo pipefail

if [ $# -lt 1 ]; then
  echo "Usage: ./create-project.sh <ProjectName> [Destination]"
  exit 1
fi

PROJECT_NAME="$1"
DESTINATION="${2:-..}"
TEMPLATE_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET="$DESTINATION/$PROJECT_NAME"

if [ -e "$TARGET" ]; then
  echo "Target already exists: $TARGET"
  exit 1
fi

mkdir -p "$TARGET"
rsync -a --exclude '.git' "$TEMPLATE_ROOT/" "$TARGET/"

echo "Created project from template: $TARGET"
echo "Next: open PROJECT_BRIEF.md and fill in the project details."
