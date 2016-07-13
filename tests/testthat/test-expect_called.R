context('expect_called')


test_that('it finds called function', {
	f <- function() sum(2, 2)
	expect_true(expect_called(base::sum, f())) 
})

test_that('it detects function was not called', {
	f <- function() 10
    expect_true(expect_called(base::sum, f(), was_called = FALSE )) 
})

test_that('Package setting works', {
	f <- function() sum(1, 2)
    expect_true(expect_called(sum, f(), "base"))
})

# neither test_that nor describe wrappers work here?
# test_that('it detects errors when function is expected but actually not called', {
# 	f <- function() 10
# 	expect_error(
# 	expect_called(base::sum, f() ),
# 	"is not identical" 
# 	)
# })





