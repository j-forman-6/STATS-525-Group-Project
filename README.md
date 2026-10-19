# STATS-525-Group-Project

**Group members:** _Ismael Mendez_, _Jack Forman_, _Natalia Giordano_
 
This repo is our shared workspace: data, R code, results, and a log of who did what.
 
---
 
## 📅 Timeline & Checklist
  
### Step 1: Group formation & proposal (due **Sept 29**)
- [x] Register group in Canvas (People → Project Groups)
- [x] Choose dataset (at least one **continuous response**; some but not all predictors categorical)
- [x] Write proposal (max **2 pages**, submitted once per group):
  - [x] Names of group members
  - [x] Project goals and research question(s)
  - [x] Data source and brief dataset description
  - [x] Response and predictor variables, with their types
  - [x] Why the question is interesting
- [x] Submit proposal
- [ ] *(Optional)* Meet with TA/instructor for feedback
### Step 2: Progress report (due **Nov 12**, max 8 pages)
- [ ] *(Optional)* Meet with TA/instructor before the deadline
**Part A: Data exploration & initial modeling (≤ 4 pages)**
- [ ] Distributions of $Y$ and each predictor (histograms / boxplots)
- [ ] Scatterplots of $Y$ vs. quantitative predictors
- [ ] Visual summaries for categorical predictors
- [ ] Discussion of outliers / extreme values
- [ ] Assess need for transformations (of $Y$, predictors, or terms like $X^2$)
- [ ] Correlation analysis among quantitative predictors and multicollinearity discussion
- [ ] Simple linear regressions of $Y$ on meaningful predictors
- [ ] Check key assumptions; propose remedies if issues are found
**Part B: Deeper analysis & preliminary conclusions (≤ 4 pages)**
- [ ] Candidate multiple regression models
- [ ] Key statistical findings (tables / figures)
- [ ] Subject-matter interpretation
- [ ] Submit progress report
### Step 3: Group presentation (last week of classes)
- [ ] *(Optional)* Meet with TA/instructor before presenting
- [ ] Build slides (15 min total, including Q&A):
  - [ ] ~3 min: data context, collection, research question
  - [ ] ~5 min: exploratory analysis, model development, modeling choices
  - [ ] ~5 min: key results, interpretation, conclusions
  - [ ] ~2 min: Q&A
- [ ] Address the relevant items: confounders, interactions, assumptions and checks, limitations, interpretability
- [ ] Rehearse together and time it
- [ ] Submit peer evaluations for other groups
### Step 4: Individual final report (due **Dec 23**, each person submits their own)
- [ ] Title and group member names on page 1
- [ ] ≤ 12 pages (excluding references/appendix), 10–12 pt font, page numbers
- [ ] Sections: Introduction, Methods & Results, Conclusion (readable by a non-statistician)
- [ ] Figures/tables numbered with self-contained captions
- [ ] Key inference results stated in text (e.g. $\hat\beta = 12.35,\ t = 2.78,\ p = 0.032$)
- [ ] No raw software output; no code in the main body
- [ ] R code submitted as an attachment/appendix
- [ ] AI/LLM use disclosed
- [ ] File size under 5 MB
- [ ] Address any issues raised during the presentation
---
 
## 📁 Repo layout
 
```
project/
├── README.md        # this file
├── log.md           # running log: date, who, what was done, open questions
├── report.qmd       # shared results write-up (text + math + R output)
├── R/               # any .r files
├── data/            # raw data (never edit by hand)
├── output/          # rendered reports and saved figures
```
 
**Logging your work:** add an entry to `log.md` every time you work on the project. The guidelines recommend keeping notes on individual contributions, and this file is ours.
 
```markdown
## 2026-10-19: Maria
- Made histograms of Y and all predictors (R/02_eda.R)
- Y is right-skewed, so a log transform may be needed: $\log(Y)$
- Open question: drop observation #47 (possible outlier)?
```
 
**Writing math:** use LaTeX between dollar signs. Write `$\hat\beta_1$` inline, or wrap it in `$$ ... $$` to get its own line. GitHub renders math in `.md` files, and Quarto renders it in `.qmd` files.
 
---
 
## 🛠️ Setting up RStudio (once per computer)
 
### 1. Install the software
- **R:** https://cran.r-project.org
- **RStudio:** https://posit.co/download/rstudio-desktop
- **Git:** https://git-scm.com/downloads (restart RStudio after installing)
- **GitHub account:** https://github.com (send your username to the repo owner to get added)
### 2. Check that RStudio sees Git
**Tools → Global Options → Git/SVN** and make sure the "Git executable" box has a path in it.
 
### 3. Connect R to your GitHub account
Run this in the RStudio **Console**, using your own name and the email on your GitHub account:
 
```r
install.packages(c("usethis", "gitcreds", "quarto"))
usethis::use_git_config(user.name = "Your Name", user.email = "you@email.com")
usethis::create_github_token()   # opens GitHub in your browser; click Generate, then copy the token
gitcreds::gitcreds_set()         # paste the token when asked (type 2)
```
 
> GitHub does **not** accept your account password for pushing. The token is what lets you push.
 
### 4. Download (clone) the project
1. On this repo's GitHub page, click the green **Code** button and copy the **HTTPS** link.
2. In RStudio: **File → New Project → Version Control → Git**.
3. Paste the link, choose where to save it, and click **Create Project**.
RStudio reopens inside the project. You should now see a **Git** tab in the top-right pane, next to Environment and History.
 
> Always open the project by double-clicking the `.Rproj` file. That way file paths work the same on everyone's computer.
 
---
 
## 🔄 How to use Git (the 4 buttons)
 
Think of GitHub as a **shared folder in the cloud**. Each of us has our own copy on our laptop, and Git keeps the copies in sync, but only when we tell it to. Everything happens in the **Git tab** (top-right pane of RStudio).
 
### 1. Pull ⬇️ (blue down arrow)
**"Give me everyone else's latest work."**
This downloads the changes teammates have uploaded.
👉 **Always pull before you start working.**
 
### 2. Stage ☑️ (the checkboxes)
**"These are the files I want to save."**
Tick the **Staged** box next to each file you changed. The status letters mean:
- **M**: modified
- **?**: new file
- **D**: deleted
### 3. Commit 💾 (Commit button)
**"Save a snapshot with a note."**
Click **Commit**, write a short message about what you did (e.g. *"Added scatterplots for Part A"*), then click **Commit** in that window.
⚠️ A commit is saved **only on your computer**. Nobody else can see it yet.
 
### 4. Push ⬆️ (green up arrow)
**"Upload my snapshots to GitHub."**
If the push fails, someone else pushed first. **Pull**, then **Push** again.
 
### The routine, every time
 
> **Pull → work → Stage → Commit → Push**
 
### Golden rules
- Pull when you sit down, and push when you get up.
- Commit often, with clear messages.
- Coordinate so two people aren't editing the **same lines of the same file** at the same time.
- Never edit files in `data/` by hand. Do all cleaning in R scripts.
- If something looks confusing, **stop and ask the group** before clicking anything. Almost everything in Git can be undone.
### If you get a "merge conflict"
It means two people changed the same lines. Git marks the clash in the file like this:
 
```
<<<<<<< HEAD
your version
=======
their version
>>>>>>> abc123
```
 
Keep the version you want, delete the marker lines (`<<<<<<<`, `=======`, `>>>>>>>`), save the file, then **Stage → Commit → Push**. If you're unsure which version to keep, ask the person who wrote the other one.
