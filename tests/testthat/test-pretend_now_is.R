context("pretend_now_is")

describe("parse_time", {
  test_that("it leaves POSIXct alone", {
    expect_equal(parse_time(Sys.time()), Sys.time())
  })

  test_that("it leaves Date less alone", {
    expect_equal(parse_time(Sys.Date()), as.POSIXct(Sys.Date()))
  })

  test_that("it can parse every format in the world", {
    grid <- expand.grid(1:10, c("day", "days", "second", "secs", "month", "years"), c("+", "-"))
    apply(grid, 1, function(row) {
      string <- sprintf("%s %s %s", row[1], row[2], if (row[3] == "+") "from now" else "ago")
      list2env(legal_unit_number_pair(normalize_unit(row[2]), as.integer(row[1])), environment())
      expect_equal(parse_time(string), 
        getFunction(row[3])(Sys.time(), as.difftime(number, units = unit)),
        info = sprintf("%s did not parse correctly", sQuote(string)), tolerance = 0.01)
    })
  })
})

test_that("it is able to pretend now is a day from today", {
  now      <- Sys.time()
  tomorrow <- now + as.difftime(1, units = "days")
  pretend_now_is(tomorrow, expect_equal(Sys.time(), tomorrow))
})
