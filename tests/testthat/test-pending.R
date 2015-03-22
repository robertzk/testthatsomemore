context('pending')

test_that('it writes a yellow dot', {
  expect_output(pending(), '\\.') 
})
