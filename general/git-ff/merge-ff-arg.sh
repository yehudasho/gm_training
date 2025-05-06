#!/bin/bash

# Exit on errors
set -e

# Check for required arguments
if [ $# -ne 2 ]; then
  echo "Usage: $0 <file-name> <branch-name>"
  exit 1
fi

FILE="$1"
BRANCH="$2"

pause() {
  read -p "Press [Enter] to continue..."
}

# Step 1: Create and switch to new branch
echo "🔀 Creating and switching to branch '$BRANCH'..."
git checkout -b "$BRANCH" && echo "✅ Switched to '$BRANCH'"
pause

# Step 2: Line 1
echo "📝 Adding line 01..."
echo "ff-line 01" >> "$FILE"
git add "$FILE"
git commit -m "ff-line 01" && echo "✅ Committed line 01"
pause

# Step 3: Line 2
echo "📝 Adding line 02..."
echo "ff-line 02" >> "$FILE"
git add "$FILE"
git commit -m "ff-line 02" && echo "✅ Committed line 02"
pause

# Step 4: Line 3
echo "📝 Adding line 03..."
echo "ff-line 03" >> "$FILE"
git commit -am "ff-line 03" && echo "✅ Committed line 03"
pause

# Step 5: Show log
echo "📜 Git log for $FILE:"
git log --oneline "$FILE"
pause

# Step 6: Switch to main and merge
echo "↩️ Switching to 'main'..."
git checkout main && echo "✅ Switched to 'main'"
pause

echo "🔗 Merging '$BRANCH' into 'main'..."
git merge "$BRANCH" && echo "✅ Merge complete"
