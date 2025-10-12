#' Type Checking Utilities
#' @keywords internal

check_numeric_vector <- function(x, name) {
  if (!is.numeric(x) || !is.vector(x))
    stop(glue::glue("`{name}` must be a numeric vector."), call. = FALSE)
}

check_dataframe <- function(df) {
  if (!is.data.frame(df))
    stop("Input `df` must be a data frame.", call. = FALSE)
}

check_positive_integer <- function(x, name) {
  if (!is.numeric(x) || length(x) != 1 || x <= 0 || x != floor(x))
    stop(glue::glue("`{name}` must be a positive integer."), call. = FALSE)
}
