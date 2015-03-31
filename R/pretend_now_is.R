#' Pretend now is some other time.
#'
#' This method stubs the built-in \code{\link{Sys.time}}, 
#' \code{\link{Sys.Date}}, and \code{\link{date}} methods with an overwritten
#' value for use in unit tests.
#'
#' Either a \code{\link{Date}} or \code{\link{POSIXct}} object can be
#' provided, or an English string in the form "<number> <unit>s <from now/agO>"
#' such as:
#'
#' \itemize{
#'   \item{1 hour ago}
#'   \item{2 months from now}
#'   \item{10 seconds ago}
#' }
#' 
#' These are translated into \code{Sys.time() + as.difftime(number, units = unit)}
#' (or \code{-} in the case of "ago").
#'
#' @param time Date or POSIXct or character. For example,
#'   \code{Sys.time() + as.difftime(1, units = "days")} or
#'   \code{"1 day from now"}.
#' @param expr expression. The expression to evaluate while pretending
#'   the current time is \code{time}.
#' @return the value of \code{expr}.
pretend_now_is <- function(time, expr) {
  current_time <- Sys.time()

  time <- parse_time(time)

  # package_stub("base", "Sys.Date", function() { 
}

parse_time <- function(time) {
  UseMethod("parse_time")
}

parse_time.POSIXct <- function(time) {
  time
}

parse_time.Date <- function(time) {
  as.POSIXct(time)
}

parse_time.character <- function(time) {
  stopifnot(length(time) == 1)

  # http://blog.codinghorror.com/regular-expressions-now-you-have-two-problems/
  regex <- "^[[:space:]]*([[:digit:]]+)[[:space:]]*([[:alpha:]]+)[[:space:]]*(from now|ago)[[:space:]]*"

  matches <- regexpr(regex, time, perl = TRUE, ignore.case = TRUE)
  list2env(extract_time(matches, time), environment())

  number <- as.integer(number)
  unit   <- normalize_unit(tolower(unit))
  op     <- if (tolower(tense) == "from now") `+` else `-`

  list2env(legal_unit_number_pair(unit, number), environment())
  op(Sys.time(), as.difftime(number, units = unit))
}

normalize_unit <- function(unit) {
  if (substring(unit, nchar(unit)) != "s") {
    unit <- paste0(unit, "s")
  }

  if (unit == "seconds") "secs"
  else unit
}

legal_unit_number_pair <- function(unit, number) {
  if (unit == "months") {
    unit   <- "days"
    number <- 30 * number
  } else if (unit == "years") {
    unit   <- "days"
    number <- 365 * number
  } else if (unit == "eons") {
    unit   <- "days"
    number <- 99999999 * number
  }
  list(unit = unit, number = number)
}

extract_time <- function(matches, time) {
  setNames(nm = c("number", "unit", "tense"),
    Map(substring, time, s <- attr(matches,"capture.start"),
        s + attr(matches, "capture.length") - 1)
  )
}

parse_time.default <- function(time) {
  stop("Time provided to ", crayon::red("testthatsomemore::pretend_now_is"),
       "is in an invalid format. Must be a ", sQuote("POSIXct"), ", ",
       sQuote("Date"), ", or ", sQuote("character"), ".", call. = FALSE)
}

