## Git Merge Fast Forward from main to feature-ff

### Fast-Forward Merge - see the steps below:
  - Create and checkout a new branch (branch-ff)
  - Create ff-file.txt
  - Create three commits in the branch-ff branch
  - Move to the main branch
  - Merge the branch-ff branch into the main branch
    - You can run below commands via the merge-ff.sh or merge-ff-arg.sh bash script
 
    
```
git checkout -b branch-ff
echo "ff-line 01" >> ff-file.txt
git add ff-file.txt
git commit -m "ff-line 01"
echo "ff-line 02" >> ff-file.txt
git add ff-file.txt
git commit -m "ff-line 02"
echo "ff-line 03" >> ff-file.txt
git commit -am "ff-line 03"
git log --oneline ff-file.txt

git checkout main
git merge branch-ff
git log --oneline ff-file.txt
gitk
```
- Output
  
![Alt text](pic-gh-ff-merge.png) 


### Merge with --no-ff
- Create and checkout a new branch (branch-no-ff):
- Create no-ff-file.txt
- Create three commits in the branch-no-ff branch
- Move to the main branch:
- Merge the branch-ff branch into the main branch

```
git checkout -b branch-no-ff
echo "ff-line 01" >> no-ff-file.txt
git add no-ff-file.txt
git commit -m "no-ff-line 01"
echo "no-ff-line 02" >> no-ff-file.txt
git add no-ff-file.txt
git commit -m "no-ff-line 02"
echo "no-ff-line 03" >> no-ff-file.txt
git commit -am "no-ff-line 03"
git log --oneline no-ff-file.txt

git checkout main
git merge branch-no-ff --no-ff
git log --oneline no-ff-file.txt
gitk

```

- Output
  
![Alt text](pic-gh-no-ff-merge.png) 

