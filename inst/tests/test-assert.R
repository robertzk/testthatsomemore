context('assert')

local({
  stub(assert, expect_false) <- function(x) if (identical(x, TRUE)) stop()

  test_that('it lets no error go through', {
    assert(TRUE)
  })

  test_that('it fails on an error', {
    expect_error(assert(stop()))
  })

})
