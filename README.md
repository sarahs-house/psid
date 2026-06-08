# PSID Family Structures

**Sarah Sullivan** 

University of Michigan  
Created: March 26, 2026

Last Updated: June 7, 2026

---

## Overview

This repository contains code for the project Cohort Family Instability in the United States, 1968-2023. This project is being conducted by Sarah Sullivan and Pamela Smock, PhD at the University of Michigan, Department of Sociology. Funding for this project is provided by the National Institute of Child Health and Human Development (NICHD) and the University of Michigan. 

This repository uses data from the **Panel Study of Income Dynamics (PSID)**, a longitudinal household survey collected annually (1968–1997) and biennially (1999–2023) by the University of Michigan.

---

## Software

| Program | Use |
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
| `_documentation` | PSID documentation |
| `_meetings | Some meeting documentation |
| `_scripts | Scripts |
| `README.md` | README (markdown) |
| `README.pdf` | README (LaTeX/PDF) |
| `__globals.do` | Global macros and paths |


Raw PSID family-year data folders (`fam1968/` through `fam2023er/`) and individual-level data (`ind2023er/`) are stored locally but excluded from the repository via `.gitignore`. For details on downloading PSID data, see [psid.org](https://psidonline.isr.umich.edu/)


---

## _scripts

| File | Description |
|------|-------------|
| `_fims_gpars.do` | FIMS grandparents & parents linking |
| `_fims_sib.do` | FIMS siblings linking |
| `_graveyard.do` | Some old written but currently unused code|
| `_hhr.ipynb` | Script to track changes in household rosters |
| `_psid.do` | MAIN PSID CLEANING AND ANALYSIS FILE |
| `_renaming.do` | Intermediate script to harmonize variables across 1968-2023 waves |


---

## Git Tips & Reminders

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
## Workflow

(under construction)

