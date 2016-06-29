#' Mocks an httr response
#'
#' @param status code integer.
#' @param content list. 
#' @param type character. json or text
#' @return a response object.
#' @export
#' @examples
#' mock_httr_response(200L, list(data = "it works!"), "json")
mock_httr_response <- function(status_code, content, type) {
  type <- match.arg(type, c("json", "text"))
  if (identical(type, "json")) {
    if(is.list(content)) { content <- jsonlite::toJSON(content, auto_unbox = TRUE) }
    httr:::response(
      status_code = status_code,
      content = charToRaw(content),
      headers = list(`Content-Type` = "application/json")
    )
  } else if (identical(type, "text")) {
    httr:::response(
      status_code = status_code,
      content = charToRaw(content),
      headers = list(`Content-Type` = "text")
    )
  } else {
    stop(paste("Unknown Content-Type:", type))
  }
}


