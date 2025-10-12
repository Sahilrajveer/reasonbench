test_that("evaluate_model runs without error", {
  set.seed(1)
  df <- tibble::tibble(
    target = rpois(100, 1.5),
    pred = runif(100, 0.5, 2.5)
  )
  
  res <- evaluate_model(df, "target", "pred", dist = "poisson", n_sim = 5)
  expect_true(all(c("MAE", "MSE", "R2") %in% names(res)))
  expect_equal(nrow(res), 3)
})
