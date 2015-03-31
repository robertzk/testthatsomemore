context("pretend_now_is")

describe("parse_time", {
  test_that("it leaves POSIXct alone", {
    expect_equal(parse_time(Sys.time()), Sys.time())
  })

  test_that("it leaves Date less alone", {
    expect_equal(parse_time(Sys.Date()), as.POSIXct(Sys.Date()))
  })

  test_that("it can parse every format in the world", {
    grid <- expand.grid(1:10, c("day", "days", "second", "secs", "minutes", "month", "years", "eons"), c("+", "-"))
    apply(grid, 1, function(row) {
      string <- sprintf("%s %s %s", row[1], row[2], if (row[3] == "+") "from now" else "ago")
      list2env(legal_unit_number_pair(normalize_unit(row[2]), as.integer(row[1])), environment())
      expect_equal(parse_time(string), 
        getFunction(row[3])(Sys.time(), as.difftime(number, units = unit)),
        info = sprintf("%s did not parse correctly", sQuote(string)), tolerance = 0.1)
    })
  })
    e git add "$(git rev-parse --show-toplevel)"; git commit -m "add pretend_now_is examples"; git push -q origin `git rev-parse --abbrev-ref HEAD` &
})

describe("pretend_now_is", {
  test_that("it is able to pretend now is a day from today", {
    now      <- Sys.time()
    tomorrow <- now + as.difftime(1, units = "days")
    pretend_now_is(tomorrow, expect_equal(Sys.time(), tomorrow))
  })

  test_that("it is able to pretend now is a day from today using character notation", {
    now      <- Sys.time()
    tomorrow <- now + as.difftime(1, units = "days")
    pretend_now_is("1 day from now", expect_equal(Sys.time(), tomorrow))
  })

    now        <- Sys.time()
    five_s_ago <- now - as.difftime(5, units = "secs")
    pretend_now_is("5 seconds ago", expect_equal(Sys.time(), five_s_ago))
  })

  test_that("it can pretend date is different", {
    tomorrow_date <- as.Date(Sys.Date() + as.difftime(1, units = "days"))
    pretend_now_is("1 day from now", {
      expect_equal(Sys.Date(), tomorrow_date)
    })
  })

  test_that("it can pretend date is different", {
    tomorrow_date <- as.Date(Sys.Date() + as.difftime(1, units = "days"))
    pretend_now_is("1 day from now", {
      expect_equal(Sys.Date(), tomorrow_date)
    })
  })

  test_that("it can pretend date is different", {
    tomorrow_time <- Sys.time() + as.difftime(1, units = "days")
    pretend_now_is("1 day from now", {
      expect_equal(date(), format(tomorrow_time, "%a %b %d %H:%M:%S %Y"))
    })
  })
})

