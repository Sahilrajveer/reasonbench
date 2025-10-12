# Contributing to reasonbench

Thank you for your interest in contributing to **reasonbench** — a package for realistic model benchmarking in R.

---

## 🧭 Guidelines

1. **Fork** the repository and create your feature branch:

   ```bash
   git checkout -b feature/my-improvement
   ```
2. **Document** your functions using `roxygen2` and include clear examples.
3. **Test** all changes locally before committing:

   ```r
   devtools::check()
   ```
4. **Commit** changes with meaningful messages following conventional commits:

   ```bash
   feat(evaluation): add Bayesian predictive intervals
   ```
5. **Submit a Pull Request** using the provided template. Ensure the PR references any related issue.

---

## 🧪 Testing

All new functionality should include automated tests under `tests/testthat/`. Tests should verify both correctness and robustness.

Run all tests locally:

```r
devtools::test()
```

If you add new statistical methods or distributions, include reproducible examples and expected benchmark values.

---

## 🧱 Coding Standards

* Follow **tidyverse style** conventions.
* Include **type checks**, **error handling**, and **informative messages**.
* Each exported function must include:

  * roxygen2 documentation (`#'` syntax)
  * parameter validation examples
  * at least one test case in `tests/testthat`

Use `lintr::lint_package()` before committing to maintain code quality.

---

## 🧩 Documentation

Update or create relevant vignettes under `vignettes/` when new features affect behavior or methodology.

After updates, rebuild documentation:

```r
Rscript -e "devtools::document(); devtools::build_vignettes()"
```

---

## 💡 Communication

For questions, conceptual discussions, or feature ideas, use the repository's **Discussions** section:
👉 [GitHub Discussions](https://github.com/DiogoRibeiro7/reasonbench/discussions)

For bug reports, open an issue using the appropriate template.

---

## 🪪 License

By contributing, you agree that your code will be released under the MIT License.

Copyright © 2025 Diogo Ribeiro.
