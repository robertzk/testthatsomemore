context("pretend_now_is")

describe("parse_time", {
  describe("invalid inputs", {
    test_that("it errors when an invalid time format is given", {
      expect_error(parse_time(10), "invalid format")
    })

    test_that("it errors on invalid character inputs", {
      expect_error(parse_time("foo seconds ago"), "Could not parse")
    })
  })

  test_that("it leaves POSIXct alone", {
    expect_equal(parse_time(Sys.time()), Sys.time())
  })

  test_that("it leaves Date less alone", {
    expect_equal(parse_time(Sys.Date()), as.POSIXct(Sys.Date()))
  })

  test_that("it can parse date strings", {
    expect_equal(as.Date(parse_time("1 day from now")), as.Date(strdate::strdate("1 day from now")))
  })
})

describe("pretend_now_is", {
  test_that("it is able to pretend now is a day from today", {
    now      <- Sys.time()
    tomorrow <- now + as.difftime(1, units = "days")
    pretend_now_is(tomorrow, expect_equal(Sys.time(), tomorrow))
  })

  test_that("it is able to pretend now is a day from today using character notation", {
    now      <- Sys.Date()
    tomorrow <- now + as.difftime(1, units = "days")
    pretend_now_is("1 day from now", expect_equal(Sys.Date(), tomorrow))
  })

  test_that("it can pretend it's 5 seconds ago", {
    now        <- Sys.time()
    five_s_ago <- now - as.difftime(5, units = "secs")
    pretend_now_is("5 seconds ago", expect_equal(Sys.time(), five_s_ago))
  })

  test_that("it can pretend Sys.Date is different", {
    tomorrow_date <- as.Date(Sys.Date() + as.difftime(1, units = "days"))
    pretend_now_is("1 day from now", {
      expect_equal(Sys.Date(), tomorrow_date, tolerance = 0.01)
    })
  })

  test_that("it can pretend date is different", {
    tomorrow_time <- Sys.time() + as.difftime(1, units = "days")
    pretend_now_is("1 day from now", {
      expect_equal(date(), format(tomorrow_time, "%a %b %d %H:%M:%S %Y"), tolerance = 0.01)
    })
  })
})
