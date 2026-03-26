# Git Workflow Guide — PSID Project
Sarah Sullivan

Created: March 25, 2026 

Last Updated: March 25, 2026

Made with: Github Copilot / Claude Sonnet 4.6

This file summarizes the command line statements to push a commit out to github. 



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
### 4) Edit `.gitignore'

Open `.gitignore' and edit to exclude files and folders from the repository. Currently, 
I am only uploading do files to the repository.


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