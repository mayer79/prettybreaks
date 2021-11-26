context("Unit tests for pretty2")

test_that("default arguments lead to expected output", {
  expect_equal(pretty2(0:100), c(0, 20, 40, 60, 80, 100))
})

test_that("the first argument should not be constant", {
  expect_error(pretty2(c(0, 0, 0)))
})

# Add many additional tests. For a small package, one test file is sufficient.
# For larger packages, more test scripts are recommended.
