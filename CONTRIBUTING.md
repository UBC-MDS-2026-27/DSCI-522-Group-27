# Contributing to the project

This outlines how to propose a change to the project.

### Fixing typos

Small typos or grammatical errors in documentation may be edited directly using
the GitHub web interface, so long as the changes are made in the _source_ file.

*  YES: you edit the Quarto source file `reports/predictor_report.qmd`.
*  NO: you edit the rendered `reports/predictor_report.html` or `.pdf`.

### Prerequisites

Before you make a substantial pull request, you should always file an issue and
make sure someone from the team agrees that it's a problem. If you've found a
bug, create an associated issue and illustrate the bug with a minimal
[reprex](https://www.tidyverse.org/help/#reprex).

### Setting up the project

Install [uv](https://docs.astral.sh/uv/getting-started/installation/), [Quarto](https://quarto.org/docs/get-started/), and [R](https://cran.r-project.org/). Then clone the repository and create the Python virtual environment from the root of the repository:

```bash
git clone https://github.com/UBC-MDS-2026-27/DSCI-522-Group-27.git
cd DSCI-522-Group-27
uv sync
```

**Python dependencies**

Python dependencies are managed using `uv`. If your changes require a new Python package, add it using:

```bash
uv add <package>
```

This adds the dependency to `pyproject.toml` and updates `uv.lock` with the resolved package versions. Commit both files so that other contributors can recreate the same Python environment using `uv sync`.

**R dependencies**

R dependencies are managed using [`renv`](https://rstudio.github.io/renv/), which records package dependencies and their versions in an `renv.lock` file.

If this is your first time setting up the R environment, open an R session from the project root and run:

```r
install.packages("renv")
renv::restore()
```

This installs the R packages specified in `renv.lock`, recreating the project's R environment.

If your changes require a new R package, install it using:

```r
renv::install("<package>")
```

Then update the lockfile:

```r
renv::snapshot()
```

This records the new dependency and its version in `renv.lock`. Commit the updated `renv.lock` file so that other contributors can install the same R dependencies using `renv::restore()`.

**Running the analysis**

To re-run the analysis and render the Quarto report from the project root:

```bash
uv run quarto render
```

Ensure that both `uv.lock` and `renv.lock` are committed whenever their respective dependencies change. This allows contributors to reproduce the Python and R environments used by the project.

### Pull request process

*  Create a new Git branch for each pull request (PR), starting from an
   up-to-date `main`. Do not commit directly to `main`.
*  Give the branch a short name that describes the work,
   for example `fix-readme-typo` or `add-eda-figure`.
*  Keep each branch small: one independent piece of work per branch.
*  Before opening the PR, render the report (`uv run quarto render`)
   to check that the analysis still runs from start to finish.
*  Open a PR into `main` and describe what changed and why.
   Link the related issue (e.g., "Closes #12").
*  At least one other team member must review and approve the PR before it is merged.
   The reviewer, not the author, merges it.
*  New code should follow the PEP8 [style guide](https://peps.python.org/pep-0008/).

### Code of Conduct

Please note that this project is released with a [Contributor Code of
Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree to
abide by its terms.

### Attribution

These contributing guidelines were adapted from the [dplyr contributing guidelines](https://github.com/tidyverse/dplyr/blob/master/.github/CONTRIBUTING.md).