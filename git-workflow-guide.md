# Git Workflow Guide — PSID Project
Sarah Sullivan

Created: March 25, 2026 

Last Updated: March 25, 2026

Made with: Github Copilot / Claude Sonnet 4.6

This file summarizes the command line statements to push a commit out to github. 

> **VS Code setting:** `settings.json` is configured with `latex-workshop.latex.autoClean.run: "onBuilt"` — auxiliary `.tex` files (`.aux`, `.log`, `.toc`, etc.) are automatically deleted after every compilation.



---
## everyday, push vs code to github
```bash
git pull                        # get latest changes
git add .                       # stage changes
git commit -m "comment changes"
git push                        # upload to GitHub
```

## collaborating, push github changes to vs code 
```bash
git pull origin main
git pull
```

---
### 1) login
```bash
git config --global user.name "Your Name"
git config --global user.email "sbsullivan19@gmail.com"
```

---
### 2) Navigate to repo folder

```bash
cd "/Users/sarsul/Library/CloudStorage/Dropbox-UniversityofMichigan/Sarah Sullivan/SARAH-SOFT/research/psid"
```

---

### 3) Initialize

```bash
git init
git branch -M main
```

---
### 4) Edit `.gitignore`

Open `.gitignore` in VS Code:

```bash
code .gitignore
```

Add files and folders to exclude from the repository. Currently, 
I am only uploading do files to the repository.

After editing, stage and commit `.gitignore`:

```bash
git add .gitignore
git commit -m "update gitignore"
```

If files were **already tracked** by Git before you added them to `.gitignore`,
Git will keep tracking them. Untrack a specific file without deleting it:

```bash
git rm --cached filename.dta
```

Untrack everything and re-add (nuclear option — use carefully):

```bash
git rm --cached -r .
git add .
git commit -m "remove tracked files now in gitignore"
```


---
### 5) Stage and commit

```bash
git add .
git status            # check what will be committed
git commit -m "COMMIT MESSAGE"
```

---

### 6) Connect to remote (first time only)

```bash
git remote add origin https://github.com/sarahs-house/psid.git
```

Check it worked:

```bash
git remote -v
```

---

### 7) Push to GitHub

```bash
git push -u origin main
```

After the first push, you can just use:

```bash
git push
```

---

### 8) If push is rejected (histories don't match)

```bash
git fetch origin
git rebase origin/main
```

Or if you need to force-merge unrelated histories:

```bash
git pull origin main --allow-unrelated-histories
git push -u origin main
```

---

### 9) Daily workflow

```bash
git pull                        # get latest changes
git add .                       # stage changes
git commit -m "describe changes"
git push                        # upload to GitHub
```

---

### 10) Troubleshooting

#### Lock file error

```
fatal: Unable to create '.git/index.lock': File exists.
```

Fix:

```bash
rm -f .git/index.lock
```

#### Unstage a file

```bash
git restore --staged filename.do
```

### Check status / history / remotes

```bash
git status
git log --oneline
git remote -v
```

#### See what changed

```bash
git diff
```

---

### After updating `.gitignore`: untrack already-tracked files

If you add a file type to `.gitignore` but Git was already tracking those files (i.e., they were previously committed), Git will keep tracking them. You need to explicitly untrack them.

Untrack specific files (they stay on your computer, just removed from GitHub):

```bash
git rm --cached filename.dta
```

Untrack everything matching your current `.gitignore` in one go:

```bash
git ls-files | grep -E "\.(aux|log|toc|out|fls|synctex\.gz|fdb_latexmk)$"
```
This lists what's currently tracked that matches those extensions. Then untrack them:

```bash
git rm --cached file1.aux file2.log   # list each file
```

Then commit and push the removal:

```bash
git add .gitignore
git commit -m "remove tracked files now in gitignore"
git push
```

---

### If push is rejected because GitHub has newer changes (stash workflow)

This happens when someone (or you from another machine) pushed to GitHub after your last pull. Your local commit exists but Git won't push because the histories have diverged.

**Step 1:** Stash any uncommitted local changes so they don't block the pull:
```bash
git stash
```
**Step 2:** Pull and rebase (replays your commit on top of the remote changes):
```bash
git pull --rebase origin main
```
**Step 3:** Restore your stashed changes:
```bash
git stash pop
```
**Step 4:** Push:
```bash
git push
```

Or as one line:
```bash
git stash && git pull --rebase origin main && git stash pop && git push
```

---

## VS Code Command Line

### Open files & folders

```bash
code .                          # open current folder in VS Code
code filename.do                # open a specific file in VS Code
open filename.pdf               # open file in default app (e.g. PDF viewer)
open -a "TeXShop" file.tex      # open file in a specific app
```

### Navigate directories

```bash
pwd                             # print current directory
ls                              # list files in current directory
ls -la                         # list files with details and hidden files
cd foldername                  # go into a folder
cd ..                           # go up one level
cd -                            # go back to previous directory
```

### Compile LaTeX

```bash
pdflatex filename.tex           # compile .tex to PDF (run twice for TOC)
```

### File operations

```bash
mv oldname.do newname.do        # rename a file
cp file.do copy_of_file.do      # copy a file
rm filename                     # delete a file (careful — no undo!)
mkdir foldername                # create a new folder
```