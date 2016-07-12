context('mock httr response function')

test_that("Mocking works with simple JSON example", {
  result <- mock_httr_response(200L, list(data = "it works!"), "json")
  expect_equal(result$status_code, 200L)
  expect_equal(result$content, charToRaw(jsonlite::toJSON(list(data = "it works!"), auto_unbox = TRUE, digits = 10)))
  expect_equal(result$headers$`Content-Type`, "application/json")
  expect_is(result, "response")
})

test_that("Mocking works with text example", {
  result <- mock_httr_response(200L, "it works!", "text")
  expect_equal(result$content, charToRaw("it works!"))
  expect_equal(result$headers$`Content-Type`, "text")
  expect_is(result, "response")
})
  