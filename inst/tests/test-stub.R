context('stub function')

test_that('stubbing works on a simple example using non-standard evaluation', {
  fn <- function() x
  stub(fn, x) <- 1
  expect_identical(fn(), 1)
})

test_that('stubbing works on a simple example using a string key', {
  fn <- function() x
  stub(fn, 'x') <- 1
  expect_identical(fn(), 1)
})

test_that('the character.only arguments overrides non-standard evaluation', {
  fn <- function() x
  name <- 'x'
  stub(fn, name, character.only = TRUE) <- 1
  expect_identical(fn(), 1)
})

