# PSID Family Structures

**Sarah Sullivan** 

University of Michigan  
Created: March 26, 2026
Last Updated: March 30, 2026

---

## Overview

This repository contains code for the 2026 family structure project using the **Panel Study of Income Dynamics (PSID)**, a longitudinal household survey collected annually (1968–1997) and biennially (1999–2023) by the University of Michigan.

---

## Softwaret

| Tool | Purpose |
|------|---------|
| **Stata** | Data cleaning, construction, and regression analysis (`.do` files) |
| **Python** | Data wrangling and exploratory analysis (`.ipynb` notebooks) |
| **LaTeX** | Tables and documents (`.tex` / `.pdf`) |
| **Git / GitHub** | Version control |

> Auxiliary LaTeX files (`.aux`, `.log`, `.toc`, etc.) are automatically cleaned after each compilation via the VS Code LaTeX Workshop setting `latex-workshop.latex.autoClean.run: "onBuilt"`. They are also excluded from the repository via `.gitignore`.

---

## Repository Structure

| File / Folder | Description |
|---------------|-------------|
| `00_globals.do` | Global macros and paths |
| `00_fims_*.do` / `.dta` | Family matching |
| `00_RENAMING_v1.do` | Variable renaming script |
| `_psid` | Main data wrangling file |
| `A1_vs/` | Archive Folder |
| `git-workflow-guide.md` | Git command reference (Markdown) |
| `git-workflow-guide.tex` | Git command reference (LaTeX/PDF) |
| `.gitignore` | Excluded file types |
| `_archive/` | Older script versions |

Raw PSID family-year data folders (`fam1968/` through `fam2023er/`) and individual-level data (`ind2023er/`) are stored locally but excluded from the repository via `.gitignore`.
For details on downloading raw PSID data, see [psid.org](https://psidonline.isr.umich.edu/)


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

See [`git-workflow-guide.md`](git-workflow-guide.md) (or the compiled [`git-workflow-guide.pdf`](git-workflow-guide.pdf), also available in LaTeX) for a full reference of Git commands used in this project, including:

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

<div style="padding-left: 2em; text-indent: -2em;">
Panel Study of Income Dynamics, public use dataset. Produced and distributed by the Survey Research Center, Institute for Social Research, University of Michigan, Ann Arbor, MI (2025).
</div>

--

# 00_RENAMING_v1.do
The file 00_RENAMING_v1.do inputs each PSID year file, retains only variables of interest, and standardizes these variable names across different waves. 

Comparable variables between years are identified using psid.xlsx and yearly codebooks, all available for download at [psid.org](https://psidonline.isr.umich.edu/). 






--



# _psid documentation



## 00. Program Set Up


## PART I

1. For survey years, 1968-2023
   1. Import year data file ("famYYYY.dta" or "famYYYYer.dta")
   2. Rename family ID variable "fam"
   3. Generate variable for year
   4. Pass through "00_RENAMING_V1.do"

2. Merge together all cleaned surveys for survey years 1968-2023.


## PART 2

## PART 3
