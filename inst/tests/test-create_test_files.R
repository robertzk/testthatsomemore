context('create_test_files')

test_that('it errors when invalid arguments are given', {
  expect_error(create_test_files(1), 'You must either provide a filename',
               info = 'create_test_files should not be able to take numeric arguments.')
  expect_error(create_test_files(TRUE), 'You must either provide a filename',
               info = 'create_test_files should not be able to take TRUE as an argument.')
})

test_that('it create an empty directory when NULL is given', {
  expect_true(create_test_files(NULL)
})

