context("Unit tests for pretty2")

test_that("default arguments lead to expected output", {
  x = 0:100
  expect_equal(pretty2(0:100), c(0, 20, 40, 60, 80, 100))
})
