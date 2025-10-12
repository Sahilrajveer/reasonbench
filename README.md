# reasonbench

[![R-CMD-check](https://github.com/DiogoRibeiro7/reasonbench/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/DiogoRibeiro7/reasonbench/actions/workflows/R-CMD-check.yaml) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE) [![made-with-R](https://img.shields.io/badge/Made%20with-R-276DC3.svg)](https://cran.r-project.org/) [![Codecov](https://codecov.io/gh/DiogoRibeiro7/reasonbench/branch/main/graph/badge.svg)](https://app.codecov.io/gh/DiogoRibeiro7/reasonbench)
[![Monthly Reminder](https://github.com/DiogoRibeiro7/reasonbench/actions/workflows/monthly-reminder.yaml/badge.svg)](https://github.com/DiogoRibeiro7/reasonbench/actions/workflows/monthly-reminder.yaml)


> **Realistic Benchmarks for Predictive Models**

`reasonbench` provides tools to evaluate machine learning models against _realistic_ stochastic baselines. Instead of comparing your model only to a _no-skill_ or _perfect_ predictor, it estimates a **reasonably-perfect benchmark**--the lowest achievable error given the inherent randomness of your data.

--------------------------------------------------------------------------------

## 🧭 Motivation

In many ML problems (e.g., ad-click prediction, counts, probabilities, continuous regression), there's irreducible noise: even an ideal model cannot make perfect predictions. Traditional benchmarking that compares models to a perfect zero-error predictor misrepresents reality.

`reasonbench` bridges this gap by simulating outcomes from the **data-generating process** (e.g., Poisson, Normal, Binomial). It computes what a "reasonably perfect" model would look like statistically--allowing fair, domain-aware evaluation.

--------------------------------------------------------------------------------

## ⚙️ Installation

```r
# From GitHub
if (!require("devtools")) install.packages("devtools")
devtools::install_github("DiogoRibeiro7/reasonbench")
```

--------------------------------------------------------------------------------

## 🚀 Quick Start

```r
library(reasonbench)
set.seed(42)

# Example: Ad click prediction (Poisson counts)
df <- tibble::tibble(
  target = rpois(5000, lambda = runif(5000, 0.5, 3)),
  pred   = runif(5000, 0.5, 3)
)

evaluate_model(df, "target", "pred", dist = "poisson", n_sim = 30)
```

Example output:

```
# A tibble: 3 × 4
  model               MAE   MSE    R2
  <chr>             <dbl> <dbl> <dbl>
1 No-skill           1.38  4.10 -0.02
2 Reasonably-perfect 0.83  1.21  0.57
3 Your Model         0.89  1.34  0.52
```

--------------------------------------------------------------------------------

## 🧩 Supported Distributions

Type              | Distribution         | Suitable for               | Function
----------------- | -------------------- | -------------------------- | ---------
Poisson           | Count data           | event counts               | `rpois`
Negative Binomial | Overdispersed counts | social metrics             | `rnbinom`
Binomial          | Binary targets       | classification             | `rbinom`
Normal            | Continuous data      | regression                 | `rnorm`
Beta              | Bounded (0–1) data   | rates, probabilities       | `rbeta`
Student-t         | Heavy-tailed         | finance, noise-robust data | `rt`

Each distribution represents a plausible **data-generating process**. The reasonably-perfect model samples synthetic targets under that process, establishing the **best achievable performance**.

--------------------------------------------------------------------------------

## 📊 Example: Binary Classification

```r
df_bin <- tibble::tibble(
  target = rbinom(4000, 1, 0.35),
  pred   = runif(4000, 0.1, 0.9)
)

evaluate_model(df_bin, "target", "pred", dist = "binomial", n_sim = 50)
```

--------------------------------------------------------------------------------

## 🧠 Interpretation

- **No-skill model:** predicts the overall mean.
- **Reasonably-perfect model:** the best expected performance given the stochastic process.
- **Your model:** the actual model under evaluation.

If your model's MAE or MSE lies close to the "reasonably-perfect" benchmark, you are approaching the limit of what is statistically possible given data noise.

--------------------------------------------------------------------------------

## 📄 Citation

If you use this package in research or production, please cite it as:

```
Ribeiro, D. (2025). reasonbench: Realistic Benchmarks for Predictive Models.
https://github.com/DiogoRibeiro7/reasonbench
```

A formal `CITATION.cff` file is included in the repository.

--------------------------------------------------------------------------------

## 🤝 Contributing

Contributions are welcome:

1. Fork the repository and create a new branch.
2. Run `devtools::check()` before submitting.
3. Add tests in `tests/testthat/`.

Follow the tidyverse style guide: <https://style.tidyverse.org>

--------------------------------------------------------------------------------

## 📰 Changelog / News

You can follow version history and planned releases here:

- 📘 [NEWS.md](NEWS.md) — detailed release notes (CRAN-style)  
- 📗 [ROADMAP.md](ROADMAP.md) — planned features and development directions  
- 📙 [CHANGELOG.md](CHANGELOG.md) *(optional GitHub-friendly version)*

--------------------------------------------------------------------------------

## 🧾 License

Licensed under the [MIT License](LICENSE).

--------------------------------------------------------------------------------

## 🧩 See Also

- `simulate_reasonably_perfect_target()` -- stochastic simulation of plausible outcomes.
- `evaluate_model()` -- benchmark your model's performance realistically.

--------------------------------------------------------------------------------

**Maintained by [Diogo Ribeiro](https://diogoribeiro7.github.io/)** © 2025 -- Released under MIT License
