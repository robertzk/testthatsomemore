context('package_stub function')

test_that('it errors when package is not found', {
  expect_error(package_stub('non-existent','boo',,), 'Could not find')
})

test_that('it errors when a non-character function name is given', {
  expect_error(package_stub('non-existent',1,,))
})

test_that('it warns when a non-fucntion is stubbed', {
  expect_warning(package_stub('methods','new',1,), 'instead of a function')
})
