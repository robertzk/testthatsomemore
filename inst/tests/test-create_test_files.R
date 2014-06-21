context('create_test_files')

local({
  expect_is_empty_file <- function(x, ...)
    expect_true(file.exists(x) && nchar(readLines(x)) == 0, ...)

  test_that('it errors when invalid arguments are given', {
    expect_error(create_test_files(1), 'You must either provide a filename',
                 info = 'create_test_files should not be able to take numeric arguments.')
    expect_error(create_test_files(TRUE), 'You must either provide a filename',
                 info = 'create_test_files should not be able to take TRUE as an argument.')
  })

  test_that('it create an empty directory when NULL is given', {
    expect_is_directory(create_test_files())
    expect_is_directory(create_test_files(NULL))
  })

  test_that('it creates a directory with one file if a single character is passed', {
    expect_is_file(file.path(create_test_files('a'), 'a'),
                   info = 'A directory with a single file named "a" should have been created')
  })

  test_that('it creates a directory with one empty file if a single character is passed', {
    expect_is_empty_file(file.path(create_test_files('a'), 'a'),
      info = 'A directory with a single empty file named "a" should have been created')
  })

  test_that('it creates a directory with two empty file if two characters are passed', {
    dir <- create_test_files(files <- c('a','b'))
    for (file in files) 
      expect_is_empty_file(file.path(dir, file),
        info = paste0('A directory with a single empty file named "', file,
                      '" should have been created'))
  })

  test_that('it creates a nested directory structure', {
    dir <- create_test_files(list(a = list(b = list(c = list('d')))))
    expect_is_empty_file(file.path(dir, 'a', 'b', 'c', 'd'))
  })

  test_that('it writes to a file if the terminal nodes are strings', {
    out <- readLines(file.path(create_test_files(list(a = inn <- "test\nit")), 'a'))
    expect_identical(paste0(out, collapse = "\n"), inn)
  })

  test_that('it can use a custom directory', {
    temp_dir <- create_test_files() 
    create_test_files('a', dir = temp_dir)
    expect_is_file(file.path(temp_dir, 'a'))
  })

  test_that('it can execute expressions passed in', {
    value <- create_test_files(list(a = 'test'), readLines(file.path(tempdir, 'a')))
    expect_identical(value, 'test',
      info = paste0('create_test_files should have been able to execute ',
                    'the passed in expression.'))
  })

  test_that('it cleans up after using the directory', {
    dir <- create_test_files()
    value <- create_test_files(list(a = 'test'), readLines(file.path(tempdir, 'a')), dir)
    expect_false(file.exists(file.path(dir, 'a')))
  })

})

