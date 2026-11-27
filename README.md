# Term Deposit Predictor

## Authors
- Anh Nguyen
- Takura Nyamayaro
- Yingzhu Pan
- Jonah Sider-Echenberg

## Summary

Only a small share of bank clients contacted through phone sales agree to subscribe to a term deposit. In our data, about 12% of contacted clients subscribed, and every unsuccessful call costs the bank money and staff time. In this project we ask whether information that is known before a call (a client's demographic characteristics, financial health and the outcome of the previous campaign) can predict whether the client will subscribe, so that the bank can target likely subscribers instead of mass calling.

We trained a logistic regression model on the UCI Bank Marketing dataset (Moro et al., 2014) and tuned its classification threshold with five-fold cross-validation. At the chosen threshold of 0.15, the model correctly identified 472 of the 1,058 actual subscribers in the test set (44.61% recall, 28.89% precision, F1 score of 35.07%). This suggests that pre-call information carries some useful signal, but the model still misses more than half of the subscribers, so further work is needed before it could guide real campaigns.


The data comes from phone-based direct marketing campaigns run by a Portuguese bank between May 2008 and November 2010 (Moro et al., 2011). We use the full version of the data, which has 45,211 rows. Each row is one client, with 16 explanatory variables and a binary target recording whether the client subscribed to a term deposit. The data is available from the [UCI Machine Learning Repository](https://archive.ics.uci.edu/dataset/222/bank+marketing)
under a CC BY 4.0 license.

## Report

The final report is available here:
<https://ubc-mds-2026-27.github.io/DSCI-522-Group-27/analysis/bank-term-deposit-prediction.html>

The source is [`analysis/bank-term-deposit-prediction.qmd`](analysis/bank-term-deposit-prediction.qmd).

## Usage

Run the analysis in Docker to use the same versions of R, Quarto, and the
required R packages as the project team.
The project's Docker image is published on
[Docker Hub](https://hub.docker.com/r/jse30/dsci-522-group-27).

### Set up the project

Install [Docker Desktop](https://www.docker.com/products/docker-desktop/) and start it before running the commands below. In a terminal, clone the repository and move into it.

```bash
git clone https://github.com/UBC-MDS-2026-27/DSCI-522-Group-27.git
cd DSCI-522-Group-27
```
Run the remaining commands from the repository root.

### 1. Set up an SSH key

If you already have a public key at `~/.ssh/id_ed25519.pub`, skip this step. Otherwise, run the following command and press Enter when prompted for the save location to accept the default path.

```bash
ssh-keygen -t ed25519
```
Docker Compose uses the public key to let contributors connect to the container over SSH. Without this key, Docker creates a folder named `~/.ssh/id_ed25519.pub`, and connecting to the container fails until you delete that folder and create the key.

### 2. Download the Docker image

In a terminal, run:

```bash
docker compose pull
```

### 3. Run the analysis and render the report

In a terminal, run:

```bash
docker compose run --rm analysis-env quarto render analysis/bank-term-deposit-prediction.qmd
```

Open `analysis/bank-term-deposit-prediction.html` in a web browser to view the report. The `--rm` option removes the container when the command finishes. The HTML report stays in your local repository.

To make changes to the project, see [CONTRIBUTING.md](CONTRIBUTING.md).


## Dependencies

The Docker image includes R, Quarto, and the R packages needed to render the report. Direct R dependencies are declared in [`DESCRIPTION`](DESCRIPTION), and package versions for the full R environment are recorded in [`renv.lock`](renv.lock).

## AI use statement

We used Claude Code Opus 5.5, Chat GPT-5.6 Sol, generative AI coding assistants, during this project. We
used it to:

- checking the R syntax for logistic regression model,
- the references in APA 7 style,
- improve wording and format in the analysis report,
- help with git stash command.

Example prompts we used:

- "How can we update my branch with the latest change in main without committing any new changes."
- "How can I design a clear outline for my current analysis."
- "Give me the APA 7 citation format for these documents."

All AI-generated text and code was reviewed, tested and edited by the team.
We take full responsibility for the content of this repository. Pull requests
and issues were opened, reviewed and merged by team members, not by AI tools.

## License

The analysis report is licensed under the
[Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)](https://creativecommons.org/licenses/by-nc-sa/4.0/)
license. The software code in this repository is licensed under the
[MIT License](https://opensource.org/license/mit). See [`LICENSE.md`](LICENSE.md)
for the full text. If you reuse or adapt this work, please give attribution and
link to this repository.

## References

Moro, S., Laureano, R., & Cortez, P. (2011). Using data mining for bank direct
marketing: An application of the CRISP-DM methodology. In P. Novais et al.
(Eds.), *Proceedings of the European Simulation and Modelling Conference
(ESM'2011)* (pp. 117–121). EUROSIS. http://hdl.handle.net/1822/14838

Moro, S., Rita, P., & Cortez, P. (2014). *Bank marketing* [Data set]. UCI
Machine Learning Repository. https://doi.org/10.24432/C5K306
