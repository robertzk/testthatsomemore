context('pending')

term <- Sys.getenv()["TERM"]
colour_terms <- c("xterm-color", "xterm-256color", "screen",
                        "screen-256color")

test_that('it writes a yellow dot', {
  output <-
    if (testthat:::rcmd_running() || !any(term %in% colour_terms, na.rm = TRUE))
      "^\\.$"
    else "^\033\\[1;33m.\033\\[0m$"
  expect_output(pending(), output) 
})
