# Contributing to the Term Deposit Predictor project

This outlines how to propose a change to the project.

### Fixing typos

Small typos or grammatical errors in documentation may be edited directly using the GitHub web interface, so long as the changes are made in the *source* file.

- YES: you edit the Quarto source file `analysis/bank-term-deposit-prediction.qmd`.
- NO: you edit the rendered `analysis/bank-term-deposit-prediction.html`.

### Prerequisites

Before you make a substantial pull request, you should always file an issue and make sure someone from the team agrees that it's a problem. If you've found a bug, create an associated issue and illustrate the bug with a minimal [reprex](https://www.tidyverse.org/help/#reprex).

### Setting up the project

Follow the [Usage section of the README](README.md#usage) to install and start Docker, clone the repository, set up an SSH key, and pull the project's image. Run the Docker Compose commands below from the repository root on your computer.

### Working in the container

Before your first session, install [Positron](https://positron.posit.co/download.html). Check your Git name and email on your computer:

``` bash
git config --global user.name
git config --global user.email
```
If either value is missing, run the corresponding command below on your computer. Replace the example name and email with your own details. Use an email address associated with your GitHub account.

```bash
git config --global user.name "Your Name"
git config --global user.email "you@example.com"
```
Docker Compose shares your Git configuration with the container so that commits you make there use your name and email.

1.  Start the container from the repository root:

    ``` bash
    docker compose up -d
    docker compose ps
    ```

2.  Open a new Positron window without opening a local folder. Open the Command Palette in Positron. Select **Remote SSH: Show Remote Menu**, choose **Connect to Host**, and enter `root@localhost:2222`. If prompted for the remote platform, select **Linux**.

3.  In the remote Positron window, choose **Open Folder** and open `/workspace`. This folder is shared with your local clone. If Positron shows **Restricted Mode**, confirm this is your project clone, then select **Trust this folder** to enable the R console.

4.   Select **Start Session** and choose the container's **R** interpreter. In the R console, run `getwd()` to confirm the working directory is `/workspace`, then run `library(tidymodels)` to check that the package loads.

5.  When you finish, close the remote Positron window and stop the container from a terminal on your computer:

    ``` bash
    docker compose down
    ```

#### Troubleshooting the connection

- If the connection is refused, run `docker compose ps` to check that the container is running and confirm the host port in `docker-compose.yml`.
- If SSH asks for a password, check that `~/.ssh/id_ed25519.pub` exists as a file on your computer and that Compose mounts it into the container. If Docker created a directory at that path, stop the container, remove the empty directory, and follow the SSH key steps in the README.
- If SSH reports that the host key changed after an image update, confirm that the port belongs to your local project container, then run `ssh-keygen -R "[localhost]:2222"` on your computer and reconnect. Use the configured host port if it differs from `2222`.

### Running the analysis

To check that the report renders, follow the render step in [README.md](README.md#usage). You can run it from your computer's terminal without opening Positron.

### Adding or updating an R package

Create a branch for the dependency change. In an R session in the container, install the required version with `renv`. For example, use `renv::install("package@x.y.z")`, replacing `package` and `x.y.z` with the package name and version. For a direct dependency, add or update its exact version in `DESCRIPTION` using `package (== x.y.z)`. Then record the package versions:

``` r
renv::snapshot()
```

Review and commit the changes to `DESCRIPTION` and `renv.lock`, then push your branch. When GitHub Actions finishes publishing the new image and updating the image tag in `docker-compose.yml`, pull the changes and download the updated image:

``` bash
git pull
docker compose pull
```

Render the report using the updated image before asking for a review.

### Publishing the report

Follow the [render step in the README](README.md#usage) to generate the self-contained HTML report. From the repository root, run the following commands in Git Bash on Windows or Terminal on macOS:

``` bash
mkdir -p docs
cp analysis/bank-term-deposit-prediction.html docs/index.html
```

For the first publication, add an empty `docs/.nojekyll` file and include it in the pull request. Once the files are on `main`, configure GitHub Pages to deploy from the `main` branch and the `/docs` folder.

Each time you update the published report, render it again and repeat the copy step. Commit and push the updated `docs/index.html` on your branch. After the pull request is merged and GitHub Pages deploys, open the report link in the README and check that the report and its figures display.

### Pull request process

- Create a new Git branch for each pull request (PR), starting from an up-to-date `main`. Do not commit directly to `main`.
- Give the branch a short name that describes the work, for example `fix-readme-typo` or `add-eda-figure`.
- Keep each branch small: one independent piece of work per branch.
- Before opening the PR, follow the [render step in the README](README.md#usage) to check that the report renders from start to finish in Docker.
- Open a PR into `main` and describe what changed and why. Link the related issue (e.g., "Closes #12" to close it when merged, or "Relates to #12" to link it without closing).
- At least one other team member must review and approve the PR before it is merged. The reviewer, not the author, merges it.
- New code should follow the [tidyverse style guide](https://style.tidyverse.org/).

### Use of generative AI

Contributors may use generative AI tools (for example, coding assistants or chatbots) to help write code, text or documentation, under these conditions:

- **Disclose it.** State in your PR description which AI tools you used and what you used them for. If you used an instruction file for an AI tool (for example, `CLAUDE.md`), commit it to the repository.
- **Review and test it.** Read and understand all AI-generated content before you submit it. Run the analysis to check that the code works, and check that any numbers in the text match the output.
- **Check facts and references.** AI tools can invent facts and citations. Every reference must be a real, reputable source that you have checked.
- **Humans open and merge.** Issues and pull requests must be opened, reviewed and merged by people, not by AI agents. AI tools may help double-check code before a merge, but a human reviewer makes the final decision.
- **You are responsible.** The contributor who submits AI-assisted work is responsible for its correctness, its originality and its licensing.

### Code of Conduct

Please note that this project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree to abide by its terms.

### Attribution

These contributing guidelines were adapted from the [dplyr contributing guidelines](https://github.com/tidyverse/dplyr/blob/master/.github/CONTRIBUTING.md).
