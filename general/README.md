# Git Into - git init locally repository, Git Structure, Four Areas and Lifecycle
- Linus Torvalds - if founder of GIT and Linux as well
- On Local Area

```
mkdir course-0325
cd course-0325 
ls -la
git init
ls -la                # you can see the ./git folder
ls -la ./git
cat ./git/config                                       - see the diff with remote server
cat ../devops-git-hungry-to-healthy/.git/config
Gitignore - go to gitignore.io site​
from site choose vsc and python - create file to add to .gitignore​
Paralell on .git folder
```
# Local Area - untracked, unmodifed, modifed, staged 	
  
```
		# untracked
vi README.md
git status
cat README.md
		# tracked, unmodifed, modifed
git add README.md
git status
vi README.md             		# updated the file
git status
cat README.md
git restore --staged README.md    		# To bring back 
cat README.md
git status
git rm --cached README.md 	# To bring back to untracked, out of git 
git staus
ls				

```

## Stage Area
- The staged area in Git is also called the index or cache
- It holds changes that you’ve marked to be included in the next 
  commit — but haven’t committed yet

- For Example
```
git status
git diff --cached
echo "stage area example 01" >> README.md
git diff --cached
git status
git add .
git diff --cached
cat README.md
git status
git commit -m "nnn"
git diff --cached
git status

```
- Git log, rm, mv commands
```
git commit -m "new file"
git status
git log						# See the SHA1
git log --oneline README.md
git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --all
		# add as alias
git config --global alias.lg "log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --all"

cat ~/.gitconfig
gitk
git rm -f README.md      		# for force removal 
git status
ls -la
git restore --staged README.md
git status
git diff <SHA 12345>  <SHA67899>
git mv <old name file> <new name file>
```



##  Stash  Areas
- Step-by-step example of using git stash while editing README.md,
  temporarily switching to work on index.html, and then 
  returning to your original work
- You're on main branch working on README.md,
  but suddenly you need to fix something in index.html first
- stash Area

```
ls -ltra
git status
cat README.md
echo "stash example" >> README.md
cat README.md
git status
git stash list
git stash push -m "contact switch to other task"
git stash list
git status
cat index.html 			# make sure that the content of index.html file already exist and commited
echo "<h1>Fixing index.html</h1>" >> index.html
cat index.html
git stash list
git add index.html
git commit -m "fix index file"
git status
git stash pop		# Now we can bask to work on README.md task
git status
git add README.md
git commit -m "END task of readme file"
git stash list
git stash clear				# clear if needed

# not use below example
                   - git stash list
		   - git stash
		   - vi index.html
						<!DOCTYPE html>
						<html>
						<body>
						<h1>My First Heading</h1>
						<p>My first paragraph.</p>
						</body>
		  				</html>
		  - git stash
                  - git stash list
		  - git status
		  - cat index.html
		  - vi index.html              # Edit the file
		  - git status                 # on modifed mode
		  - git stash list
		  - git stash pop              # To apply the latest stash, Restores changes and removes them from stash
		  - git stash apply stash@{0}  # To apply a specific stash (without removing it)              
		  - cat index.html
		  - git add .
		  - git commit -m "stash"
		  - git status
		  - cat index.html
```

## Branches - workfolw via visualizing-git 
- Make sure you are not lossing the head

- Go to http://git-school.github.io/visualizing-git
  
```
git commit "01"
git commit "02"
git commit "03"
git checkout -b "new-branch"
git commit "new-branch-01"
git commit "new-branch-02"
git checkout head~3
git checkout -b "feature-01"	
git commit "feature-01"
git commit "feature-02"
git commit "feature-03"
git checkout master 
git checkout -b "feature-02"
git commit "feature-02-01"
git commit "feature-02-02"
git commit "feature-02-03"
git commit "feature-02-04"

	# lossing the head				
git checkout head~6 
git commit "lossing the head"
git commit "lossing the head 02"
git checkout -b "loss-head-br"           # fix lossing the head
git branch
git checkout master
git branch -d "loss-head-br"             # delete branch
git branch
```

## Branches - workfolw via Visual Studio Code  or Git bash

```
git status
git branch
git branch --all
git branch -r
git checkout -b feature01
git branch
git branch --all
ls
ls -la
cat .gitignore
vi README.md
cat README.md
git add .
git commit -m "first commit in feature br"
echo "add second line in feature br" >> README.md
git diff --cached
git add .
git diff --cached
git commit -m "second commit in feature br"
git status
git branch
git branch --all
git pull
git push 					# the message is since we need to sync the branches
git push --set-upstream origin feature01
git push
```
## Git merge

- git merge (Git command)
- Combines one branch into another (e.g., merge feature into main)
- No reviews, no checks — it just merges changes directly
- Used when working alone or when you want full manual control

**Use it when:**
- You're working solo
- You’re ready to combine changes yourself
- You want to test or fast-forward locally

```
git checkout main
git pull
git branch
git branch --all
echo "merge-01 in main!" > file.txt
git add file.txt
git commit -m "merge-01 in main"
git checkout -b feature-branch
echo "merge-01 in Feature branch" > file.txt
git commit -am "Updated file.txt in feature-branch"
git push --set-upstream origin feature-branch
				
	# you will see the pull request in github dashboard
	# Do it with git command
	# Bonus - create additinal file-02.txt and merge via GitHub Pull Request (PR)
git checkout main
echo "merge-02 in main!" > file.txt  
git commit -am "Updated file.txt in main"
git push
git merge feature-branch

	# Fix the conflict or you can abort of fix it
git merge --abort
git log                   # gitk with all options
vi file.txt
git status
git commit -am "merged file.txt  main"
git merge feature-branch
git status
cat file.txt

```

### Pull Request

- Not a Git command — it's a feature of Git hosting services
- Used to collaborate: you ask others to review and merge your code
- Tracks discussion, reviews, comments, approvals
- Supports automated checks (CI/CD, tests)

**Use it when:**
- You're collaborating with a team
- You want a review or feedback before merging
- You work on a shared repository hosted on GitHub/GitLab/etc

## Git Merge Fast Forward from main to feature-ff

- Merge - Fast Forward

```
git checkout main
git pull
echo "Line 1" > ff-new.txt
git add ff-new.txt
git commit -m "line 1"
git pull
git push
git log --oneline ff-new.txt

git checkout -b feature-ff
echo "Line 2" > ff-new.txt
git add ff-new.txt
git commit -m "line 2"
echo "Line 3" > ff-new.txt
git commit -am "line 3"			# it is do git add rebase-demo.txt as well
git pull
git push
git push --set-upstream origin feature-ff
git push
git pull
git log --oneline ff-new.txt
git checkout main
git branch --all
git merge feature-ff
git log --oneline ff-new.txt
```

## Git Rebase 

```
git checkout main
echo "Line 1" >> rebase-001.txt
git add rebase-001.txt
git commit -m "line 1"
git log --oneline rebase-001.txt
git pull
git push

git checkout -b feature-rebase-001
echo "Line 2" >> rebase-001.txt
git add rebase-001.txt
git commit -m "line 2"
echo "Line 3" >> rebase-001.txt
git commit -am "line 3"
cat rebase-001.txt
git log --oneline rebase-001.txt
git push
git push --set-upstream origin feature-rebase-001
git push
git pull

git checkout main
ls
git pull
git push
ls
cat rebase-001.txt
		# adds a new line at the top of the file rebase-01.txt
echo "Line 0" | cat - rebase-001.txt > temp && mv temp rebase-001.txt
		# now there are teo lines

cat rebase-001.txt
git commit -am "add line 0 and line 1"

git checkout feature-rebase-001
ls
git pull
git push
git log --oneline rebase-001.txt
cat rebase-001.txt             # Output Before Rebase
				Line 1
				Line 2
				Line 3

git rebase main			# Successfully rebased, output after rebase

				Line 0
				Line 1
				Line 2
				Line 3

git log --oneline rebase-001.txt
gitk
git checkout main
cat rebase-001.txt
git log --oneline rebase-001.txt
gitk


# fix the conflict if needed

git rebase --continue
git rebase --abort       		# you can abort
vi rebase-001.txt			# fix the conflict
git rebase --continue
git status

```
## Rebase Interactive & Squashing

Interactive rebase is a Git tool that allows you to:
- Squashing is one operation you can do during interactive rebase

- Squash commits
- Reword commit messages
- Reorder commits
- Drop commits
- Split commits
- Edit commits

```
echo "Line 1" >> rebase-interactive.txt
git add rebase-interactive.txt
git commit -m "line 1"
echo "Line 2" >> rebase-interactive.txt
git commit -am "line 2"
echo "Line 3" >> rebase-interactive.txt
git commit -am "line 3"
git log --oneline rebase-interactive.txt
git rebase -i HEAD~3
git log --oneline rebase-interactive.txt

```

## Git hook

- Hooks live in the .git/hooks/ directory of every Git repository.
When you initialize a repo, Git puts sample scripts there (e.g., pre-commit.sample).

```
cd .git/hooks/
cp pre-commit.sample pre-commit
```

- **vi pre-commit** and add below contant
  
```
#!/bin/sh
echo "Running pre-commit checks..."

# Example: Block commit if TODOs are present
if grep -r "TODO" .; then
  echo "Remove TODO comments before committing."
  exit 1
fi
chmod +x pre-commit
```

vi index.html
git add index.html
git commit index.html 		# you should get a message


