context("pretend_now_is")

test_that("it is able to pretend now is a day from today", {
  now      <- Sys.time()
  tomorrow <- now + as.difftime(1, units = "days")
  pretend_now_is(tomorrow, expect_equal(Sys.time(), tomorrow))
})
