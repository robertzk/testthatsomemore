context('pending')

test_that('it writes a yellow dot', {
  expect_output(pending(), "\033\\[1;33m.\033\\[0m") 
})
