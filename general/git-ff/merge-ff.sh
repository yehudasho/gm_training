#!/bin/bash

# Exit immediately if a command fails
set -e

pause() {
  read -p "Press [Enter] to continue..."
}

# Step 1: Create and switch to new branch
echo "🔀 Creating branch 'branch-ff-01'..."
git checkout -b branch-ff-01 && echo "✅ Switched to 'branch-ff-01'"
pause

# Step 2: Add first line and commit
echo "📝 Writing ff-line 01..."
echo "ff-line 01" >> ff-file.txt
git add ff-file.txt
git commit -m "ff-line 01" && echo "✅ Committed 'ff-line 01'"
pause

# Step 3: Add second line and commit
echo "📝 Writing ff-line 02..."
echo "ff-line 02" >> ff-file.txt
git add ff-file.txt
git commit -m "ff-line 02" && echo "✅ Committed 'ff-line 02'"
pause

# Step 4: Add third line and commit
echo "📝 Writing ff-line 03..."
echo "ff-line 03" >> ff-file.txt
git commit -am "ff-line 03" && echo "✅ Committed 'ff-line 03'"
pause

# Step 5: Show log
echo "📜 Git log for ff-file.txt:"
git log --oneline ff-file.txt
pause

# Step 6: Switch to main and merge
echo "↩️ Switching to 'main' branch..."
git checkout main && echo "✅ Switched to 'main'"
pause

echo "🔗 Merging 'branch-ff-01' into 'main'..."
git merge branch-ff-01 && echo "✅ Merge complete"
