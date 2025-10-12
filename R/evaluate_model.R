#' Evaluate Model Against Realistic Benchmarks
#'
#' Compares a model’s predictive performance against three reference points:
#' 1. No-skill model (predicting the mean),
#' 2. Reasonably-perfect model (simulated stochastic baseline),
#' 3. The model itself.
#'
#' @param df Data frame containing target and prediction columns.
#' @param target_col Character. Target variable name.
#' @param pred_col Character. Model predictions column name.
#' @param dist Character. Distribution family for the simulation.
#' @param extra_params List. Extra distribution parameters.
#' @param n_sim Integer. Number of simulations.
#' @param seed Integer. Random seed.
#'
#' @return Tibble summarizing MAE, MSE, and R² for each benchmark.
#'
#' @importFrom glue glue
#' @importFrom purrr map_dbl
#' @importFrom tibble tibble
#' @export
evaluate_model <- function(
    df,
    target_col,
    pred_col,
    dist = "poisson",
    extra_params = list(),
    n_sim = 20L,
    seed = 123L) {

  check_dataframe(df)
  
  if (!target_col %in% names(df))
    stop(glue("Target column `{target_col}` not found."), call. = FALSE)
  if (!pred_col %in% names(df))
    stop(glue("Prediction column `{pred_col}` not found."), call. = FALSE)
  
  y_true <- df[[target_col]]
  y_pred <- df[[pred_col]]
  check_numeric_vector(y_true, "y_true")
  check_numeric_vector(y_pred, "y_pred")
  
  # --- Compute baselines -----------------------------------------------------
  y_mean <- mean(y_true)
  pred_no_skill <- rep(y_mean, length(y_true))
  
  sims <- simulate_reasonably_perfect_target(
    preds = y_pred,
    dist = dist,
    extra_params = extra_params,
    n_draws = n_sim,
    seed = seed
  )
  
  mae_sim <- map_dbl(sims, ~ safe_eval(Metrics::mae(y_true, .x)))
  mse_sim <- map_dbl(sims, ~ safe_eval(Metrics::mse(y_true, .x)))
  r2_sim  <- map_dbl(sims, ~ safe_eval(R2_Score(y_true, .x)))
  
  tibble(
    model = c("No-skill", "Reasonably-perfect", "Your Model"),
    MAE   = c(Metrics::mae(y_true, pred_no_skill),
              mean(mae_sim, na.rm = TRUE),
              Metrics::mae(y_true, y_pred)),
    MSE   = c(Metrics::mse(y_true, pred_no_skill),
              mean(mse_sim, na.rm = TRUE),
              Metrics::mse(y_true, y_pred)),
    R2    = c(R2_Score(y_true, pred_no_skill),
              mean(r2_sim, na.rm = TRUE),
              R2_Score(y_true, y_pred))
  )
}
