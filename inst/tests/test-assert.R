context('assert')

test_that('it lets no error go through', {
  assert(TRUE)
})

test_that('it fails on an error', {
  expect_error(assert(stop()))
})

