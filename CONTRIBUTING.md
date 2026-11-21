# Contributing to the Term Deposit Predictor project

This outlines how to propose a change to the project.

### Fixing typos

Small typos or grammatical errors in documentation may be edited directly using
the GitHub web interface, so long as the changes are made in the _source_ file.

*  YES: you edit the Quarto source file `analysis/bank-term-deposit-prediction.qmd`.
*  NO: you edit the rendered `analysis/bank-term-deposit-prediction.html`.

### Prerequisites

Before you make a substantial pull request, you should always file an issue and
make sure someone from the team agrees that it's a problem. If you've found a
bug, create an associated issue and illustrate the bug with a minimal
[reprex](https://www.tidyverse.org/help/#reprex).

### Setting up the project

Install [Git](https://git-scm.com/downloads), [R](https://cran.r-project.org/)
(version 4.6.1) and [Quarto](https://quarto.org/docs/get-started/) (version 1.10
or higher). Then clone the repository:

```bash
git clone https://github.com/UBC-MDS-2026-27/DSCI-522-Group-27.git
cd DSCI-522-Group-27
```

**R dependencies**

R dependencies are managed using [`renv`](https://rstudio.github.io/renv/),
which records package dependencies and their versions in an `renv.lock` file.
The project's `.Rprofile` activates renv automatically when you start R from the
project root.

If this is your first time setting up the R environment, open an R session from
the project root and run:

```r
renv::restore()
```

This installs the R packages specified in `renv.lock`, recreating the project's
R environment.

If your changes require a new R package, install it using:

```r
renv::install("<package>")
```

Then update the lockfile:

```r
renv::snapshot()
```

This records the new dependency and its version in `renv.lock`. Commit the
updated `renv.lock` file so that other contributors can install the same R
dependencies using `renv::restore()`.

**Running the analysis**

To re-run the analysis, render the Quarto report from the project root:

```bash
quarto render analysis/bank-term-deposit-prediction.qmd
```

If you are already in the `analysis/` directory, run:

```bash
quarto render bank-term-deposit-prediction.qmd
```

This downloads and cleans the data (if it is not already in `data/raw/`) and
runs the full analysis.


### Pull request process

*  Create a new Git branch for each pull request (PR), starting from an
   up-to-date `main`. Do not commit directly to `main`.
*  Give the branch a short name that describes the work,
   for example `fix-readme-typo` or `add-eda-figure`.
*  Keep each branch small: one independent piece of work per branch.
*  Before opening the PR, render the report to check that the analysis still
   runs from start to finish.
*  Open a PR into `main` and describe what changed and why.
   Link the related issue (e.g., "Closes #12" to close it when merged, or
   "Relates to #12" to link it without closing).
*  At least one other team member must review and approve the PR before it is merged.
   The reviewer, not the author, merges it.
*  New code should follow the [tidyverse style guide](https://style.tidyverse.org/).

### Use of generative AI

Contributors may use generative AI tools (for example, coding assistants or
chatbots) to help write code, text or documentation, under these conditions:

*  **Disclose it.** State in your PR description which AI tools you used and
   what you used them for. If you used an instruction file for an AI tool (for
   example, `CLAUDE.md`), commit it to the repository.
*  **Review and test it.** Read and understand all AI-generated content before
   you submit it. Run the analysis to check that the code works, and check that
   any numbers in the text match the output.
*  **Check facts and references.** AI tools can invent facts and citations.
   Every reference must be a real, reputable source that you have checked.
*  **Humans open and merge.** Issues and pull requests must be opened, reviewed
   and merged by people, not by AI agents. AI tools may help double-check code
   before a merge, but a human reviewer makes the final decision.
*  **You are responsible.** The contributor who submits AI-assisted work is
   responsible for its correctness, its originality and its licensing.

### Code of Conduct

Please note that this project is released with a [Contributor Code of
Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree to
abide by its terms.

### Attribution

These contributing guidelines were adapted from the [dplyr contributing guidelines](https://github.com/tidyverse/dplyr/blob/master/.github/CONTRIBUTING.md).
