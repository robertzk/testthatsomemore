context('expect_is_directory')

local({
  environment(expect_is_directory) <- new.env(parent = environment(expect_is_directory))
  environment(expect_is_directory)$expect_true <- stopifnot

  test_that('it returns an error on a non-character', {
    expect_error(expect_is_directory(5))
    expect_error(expect_is_directory(NULL))
    expect_error(expect_is_directory(factor(1)))
  })

  test_that('it returns an error on a non-existent directory', {
    expect_error(expect_is_directory('not/a/directory'))
  })

  test_that('it does not error on an actual directory', {
    assert(expect_is_directory(dirname(tempfile())))
  })

})
