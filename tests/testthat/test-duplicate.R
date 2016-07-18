context("duplicate")

test_that('it duplicates a function', {
	fn <- function(x) cat(x, "\n")
	fn_copy <- duplicate(fn)
	expect_equal(fn, fn_copy)
})
