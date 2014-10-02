context('package_stub function')

test_that('it errors when package is not found', {
  expect_error(package_stub('non-existent','boo',,), 'Could not find')
})

test_that('it errors when a non-character function name is given', {
  expect_error(package_stub('non-existent',1,,))
})

test_that('it warns when a non-function is stubbed', {
  expect_warning(package_stub('methods','new',1,1), 'instead of a function')
})

test_that('it errors when stubbing a non-existent method', {
  expect_error(package_stub('methods', 'non-existent',identity,), 'it must exist')
})

test_that('it can stub methods::new', {
  expect_equal(package_stub("methods", "new", function(...) 'test', new('hello')), 'test')
})

test_that('it restores methods::new after stubbing', {
  package_stub("methods", "new", function(...) 'test', new('hello'))
  expect_true(length(formals(methods::new)) > 1)
})

