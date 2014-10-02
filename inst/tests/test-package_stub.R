context('package_stub function')

test_that('it errors when package is not found', {
  expect_error(package_stub('non-existent','boo',,), 'Could not find')
})

#test_that('i 
