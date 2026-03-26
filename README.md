# PSID Family Structures

**Sarah Sullivan** 

University of Michigan  

Last Updated: March 26, 2026

---

## Overview

This repository contains code for the 2026 family structure project using the **Panel Study of Income Dynamics (PSID)**, a longitudinal household survey collected annually (1968–1997) and biennially (1999–2023) by the University of Michigan.

---

## Software

| Tool | Purpose |
|------|---------|
| **Stata** | Data cleaning, construction, and regression analysis (`.do` files) |
| **Python** | Data wrangling and exploratory analysis (`.ipynb` notebooks) |
| **LaTeX** | Tables and documents (`.tex` / `.pdf`) |
| **Git / GitHub** | Version control |

> Auxiliary LaTeX files (`.aux`, `.log`, `.toc`, etc.) are automatically cleaned after each compilation via the VS Code LaTeX Workshop setting `latex-workshop.latex.autoClean.run: "onBuilt"`. They are also excluded from the repository via `.gitignore`.

---

## Repository Structure

```
psid/
├── 00_globals.do               # global macros and paths
├── 00_fims_*.do / .dta         # family interview member data
├── 00_RENAMING_v1.do           # variable renaming script
├── _psid                       # main data wrangling file
├── A1_vs                       # fOLDer
├── git-workflow-guide.md       # Git command reference (Markdown)
├── git-workflow-guide.tex      # Git command reference (LaTeX/PDF)
├── .gitignore                  # excluded file types
└── _archive/                   # older script versions
```

Raw PSID family-year data folders (`fam1968/` through `fam2023er/`) and individual-level data (`ind2023er/`) are stored locally but excluded from the repository via `.gitignore`.

---

## Key Scripts

| File | Description |
|------|-------------|
| `00_globals.do` | Sets global paths and macros used across all scripts |
| `00_fims_pars.do` | Cleans PSID parent file |
| `00_fims_gpars.do` | Cleans PSID grandparent file |
| `00_fims_sib.do` | Cleans PSID sibling file |
| `_psid` | Constructs the complete analysis panel |

---

## Git Workflow

See [`git-workflow-guide.md`](git-workflow-guide.md) (or the compiled [`git-workflow-guide.pdf`](git-workflow-guide.pdf)) for a full reference of Git commands used in this project, including:

- Everyday push workflow
- First-time repository setup
- `.gitignore` management
- Troubleshooting rejected pushes

**Quick reference — everyday push:**

```bash
git pull                         # get latest changes from GitHub
git add .                        # stage all changes
git commit -m "describe changes"
git push                         # upload to GitHub
```

---

## Data Source

Panel Study of Income Dynamics (PSID), University of Michigan Survey Research Center.  
Data available at: [https://psidonline.isr.umich.edu](https://psidonline.isr.umich.edu)
