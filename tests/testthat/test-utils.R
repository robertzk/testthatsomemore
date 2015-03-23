context("utils")

test_that("it can detect directories", {
  expect_true(is.directory(dirname(tempfile())))
})

test_that("it can touch a file", {
  file <- NULL
  package_stub("base", "system", function(f) file <<- f, {
    touch("foo")
    expect_equal(file, "touch foo")
  })
})
