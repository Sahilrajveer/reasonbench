#' Simulate a Reasonably-Perfect Target Distribution
#'
#' Generates a stochastic realization of a target variable consistent with
#' the model’s predicted expected values and a specified probabilistic family.
#'
#' @param preds Numeric vector of model predictions.
#' @param dist Character. Distribution name: one of
#'   `"poisson"`, `"nbinom"`, `"binomial"`, `"normal"`, `"beta"`, `"student"`.
#' @param extra_params List. Additional distribution parameters (`size`, `sigma`, `phi`, `nu`, etc.).
#' @param n_draws Integer. Number of Monte Carlo draws.
#' @param seed Integer (optional). Random seed.
#'
#' @return Tibble with `n_draws` simulated columns.
#'
#' @importFrom glue glue
#' @importFrom tibble as_tibble
#' @importFrom purrr map_dbl
#' @importFrom stats rpois rnbinom rbinom rnorm sd rbeta rt
#' @export
simulate_reasonably_perfect_target <- function(
    preds,
    dist = "poisson",
    extra_params = list(),
    n_draws = 1L,
    seed = NULL) {

  check_numeric_vector(preds, "preds")
  check_positive_integer(n_draws, "n_draws")
  
  if (!is.null(seed)) set.seed(seed)
  if (!dist %in% c("poisson", "nbinom", "binomial", "normal", "beta", "student"))
    stop(glue::glue("Unsupported distribution: `{dist}`"), call. = FALSE)
  
  n <- length(preds)
  sims <- matrix(NA_real_, nrow = n, ncol = n_draws)
  
  for (i in seq_len(n_draws)) {
    sims[, i] <- safe_eval(
      switch(
        dist,
        "poisson" = rpois(n, lambda = preds),
        "nbinom"  = rnbinom(n, mu = preds, size = extra_params$size %||% 1),
        "binomial" = rbinom(n, 1, preds),
        "normal"  = rnorm(n, mean = preds, sd = extra_params$sigma %||% sd(preds - round(preds))),
        "beta"    = {
          phi <- extra_params$phi %||% 10
          alpha <- pmax(preds * phi, .Machine$double.eps)
          beta  <- pmax((1 - preds) * phi, .Machine$double.eps)
          rbeta(n, alpha, beta)
        },
        "student" = preds + (extra_params$sigma %||% 1) * rt(n, df = extra_params$nu %||% 5)
      ),
      msg = glue("Simulation failed at draw {i}")
    )
  }
  as_tibble(sims, .name_repair = ~ paste0("sim_", seq_len(n_draws)))
}
