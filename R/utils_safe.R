#' Safe Evaluation Wrapper
#'
#' @description
#' Executes an expression safely, catching errors and returning `NA_real_` with a warning.
#'
#' @param expr Expression to evaluate.
#' @param msg Character. Message prefix for warnings.
#' @return The evaluated result or `NA_real_` if an error occurs.
#' @keywords internal
safe_eval <- function(expr, msg = "Evaluation failed") {
  tryCatch(
    expr,
    error = function(e) {
      warning(glue::glue("{msg}: {e$message}"))
      return(NA_real_)
    }
  )
}
