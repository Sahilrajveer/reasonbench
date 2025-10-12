# 🗺️ reasonbench Development Roadmap

## 🧭 1. Documentation & Presentation

| Enhancement                | Description                                                                          | Benefit                                                                                                                     |
| -------------------------- | ------------------------------------------------------------------------------------ | --------------------------------------------------------------------------------------------------------------------------- |
| `_pkgdown.yml`             | Configure site sections (Reference, Articles, News, Citation).                       | Builds an elegant documentation site at [diogoribeiro7.github.io/reasonbench](https://diogoribeiro7.github.io/reasonbench). |
| **Badges**                 | Add badges in `README.md` for R CMD check, coverage, CRAN status, DOI.               | Communicates maturity instantly.                                                                                            |
| **NEWS.md / CHANGELOG.md** | Track package updates per version.                                                   | Required for CRAN updates, helps readers follow progress.                                                                   |
| **Logo & hex sticker**     | Place at `man/figures/logo.png`.                                                     | Visual identity for the package.                                                                                            |
| **Extra vignettes**        | E.g., `vignettes/case_study_poisson.Rmd`, `vignettes/distributional_benchmarks.Rmd`. | Shows realistic case studies.                                                                                               |

---

## ⚙️ 2. DevOps & Automation

| Enhancement                  | Description                                    | Tooling                                         |
| ---------------------------- | ---------------------------------------------- | ----------------------------------------------- |
| **pkgdown CI deploy**        | Auto-build docs on each push (`pkgdown.yaml`). | GitHub Actions.                                 |
| **Test coverage thresholds** | Fail build if coverage < e.g., 90%.            | Codecov settings or `covr::report()`.           |
| **Code quality linting**     | Run `lintr::lint_package()` in CI.             | Add `.github/workflows/lint.yaml`.              |
| **Dependabot**               | Auto-update GitHub Actions and dependencies.   | Add `.github/dependabot.yml`.                   |
| **semantic-release for R**   | Automate versioning based on commit messages.  | Using `semantic-release` or a custom R wrapper. |

---

## 📦 3. Functionality Extensions

### 🧮 (a) More Distributions

Add support for:

* Gamma (continuous, skewed)
* Log-normal
* Zero-inflated Poisson / Negative Binomial
* Mixtures (Normal + Poisson)

Each gets its own simulation wrapper inside `simulate_reasonably_perfect_target()`.

### 🧠 (b) Bayesian Reasonable Benchmarks

Integrate simple Bayesian predictive intervals:

```r
posterior_predictive_mae <- function(y_true, y_pred, sigma, draws = 1000)
```

Helps quantify expected performance under posterior uncertainty.

### 🧩 (c) Distribution Diagnostics

Add:

```r
goodness_of_fit(df, target_col, pred_col, dist)
```

Computes dispersion index, overdispersion, and likelihood-ratio tests (LRTs).

### 📈 (d) Visualization Tools

Create a plotting submodule:

```r
plot_reasonable_vs_model(df_benchmark)
plot_distribution_overlay(target, simulated)
```

Use **ggplot2** to visualize performance gaps and stochastic spread.

### 📊 (e) Reporting

Generate Markdown / HTML reports summarizing metrics, plots, and diagnostics:

```r
report_reasonbench(df, target_col, pred_col, output = "report.html")
```

---

## 🧪 4. Testing & Quality

| Enhancement            | Purpose                                                               |
| ---------------------- | --------------------------------------------------------------------- |
| **Snapshot tests**     | Verify output tables stay consistent (`testthat::expect_snapshot()`). |
| **Parametrized tests** | Check `evaluate_model()` across all distributions.                    |
| **Stress tests**       | Validate scalability on 1e6 rows using simulated data.                |
| **Benchmark tests**    | Time simulation performance using `bench::mark()`.                    |

---

## 🎓 5. Academic Credibility

| Enhancement                 | Purpose                                                                                                         |
| --------------------------- | --------------------------------------------------------------------------------------------------------------- |
| **CITATION.bib**            | Add BibTeX reference for research citations.                                                                    |
| **Paper.md (JOSS)**         | Write a 2-page scientific summary for JOSS publication.                                                         |
| **Dataset examples**        | Include synthetic datasets (Poisson click data, binary conversion data).                                        |
| **Methodological vignette** | Explain “reasonable benchmarks” theory — link to Poisson noise, irreducible error, bias-variance decomposition. |

---

## 🧱 6. Repository Infrastructure

| Component                            | Description                                         |
| ------------------------------------ | --------------------------------------------------- |
| **.Rproj file**                      | Helps users open it in RStudio.                     |
| **.pre-commit-config.yaml**          | Run checks and formatting before committing.        |
| **.github/ISSUE_TEMPLATE/**          | Add templates for bug reports and feature requests. |
| **.github/PULL_REQUEST_TEMPLATE.md** | Standardize contributions.                          |
| **.github/FUNDING.yml**              | Add sponsor link or Ko-fi/BuyMeACoffee.             |
| **.github/CODEOWNERS**               | Assign default reviewers.                           |

---

## 🧠 7. Long-Term Features (for 2.0+)

* **Streaming benchmarking** → integrate with data frames updated in real time (via Arrow or DuckDB).
* **Integration with yardstick** → export `tibble` of metrics compatible with tidyverse ML pipelines.
* **Web dashboard** → using **Shiny** or **flexdashboard** to interactively visualize benchmark performance.
* **Python bridge** → expose simulation logic via **reticulate** to evaluate scikit-learn models.

---

## 🚀 Suggested Next Step

Let’s choose one concrete improvement track next:

* **Docs & pkgdown** → complete `_pkgdown.yml` + CI to publish docs.
* **Plots & Visuals** → implement `plot_reasonable_vs_model()`.
* **Extended distributions** → Gamma & Log-normal support.
* **Automated reporting** → HTML summary generator.
