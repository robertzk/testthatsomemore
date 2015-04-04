context("with_optionss")

test_that("it can mock an options", {
  with_options(foo = 1, expect_identical(getOption("foo"), 1))
})

test_that("it resets an options after mocking", {
  with_options(foo = 1, expect_identical(getOption("foo"), 1))
  expect_identical(getOption("foo"), NULL)
})
