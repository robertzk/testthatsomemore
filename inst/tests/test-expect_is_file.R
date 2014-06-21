context('expect_is_file')

test_that('it returns an error on a non-character', {
  expect_error(expect_is_file(5))
  expect_error(expect_is_file(NULL))
  expect_error(expect_is_file(factor(1)))
})

test_that('it returns an error on a non-existent file', {
  expect_error(expect_is_file('not/a/file'))
})

test_that('it does not error on an actual file', {
  assert(expect_is_file(tempfile()))
})

