context("utils")

test_that("it can detect directories", {
  expect_true(is.directory(dirname(tempfile())))
})

test_that("it can touch a file", {
  file <- NULL
  package_stub("testthatsomemore", "touch", function(f) file <<- f, {
    touch("foo")
    expect_equal(file, "foo")
  })
})
