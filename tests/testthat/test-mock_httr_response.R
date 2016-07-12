context('mock httr response function')

test_that("Mocking works with simple JSON example", {
  out <-   getFromNamespace("response", "httr")(
      status_code = 200L,
      content = charToRaw(jsonlite::toJSON(list(data = "it works!"), 
      							auto_unbox = TRUE, digits = 10)),
      headers = list(`Content-Type` = "application/json")
    )
  result <- mock_httr_response(200L, list(data = "it works!"), "json")
  expect_identical(result, out)
})

test_that("Mocking works with text example", {
  out <-   getFromNamespace("response", "httr")(
      status_code = 200L,
      content = charToRaw("it works!"),
      headers = list(`Content-Type` = "text")
    )
  result <- mock_httr_response(200L, "it works!", "text")
  expect_identical(result, out)
})
