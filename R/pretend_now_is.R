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
}
