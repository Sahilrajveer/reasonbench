#' Compute Coefficient of Determination (R²)
#'
#' @param y Numeric vector of true values.
#' @param yhat Numeric vector of predicted values.
#' @return Numeric scalar R² score.
#' @export
R2_Score <- function(y, yhat) {
  check_numeric_vector(y, "y")
  check_numeric_vector(yhat, "yhat")
  ss_res <- sum((y - yhat)^2)
  ss_tot <- sum((y - mean(y))^2)
  1 - ss_res / ss_tot
}
