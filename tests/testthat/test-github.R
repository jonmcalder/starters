context("test-github")

test_that("setup_gh_repo works", {
  skip_if_not(identical(Sys.getenv("TRAVIS"), "true"))
  testthat::skip_if_not(nzchar(Sys.getenv("GITHUB_PAT")))
  testthat::skip_if_not(gh::gh_whoami()$name == "chibimaelle")
  expect_silent(setup_gh_repo("chibimaelle", private = TRUE,
                              protocol = "ssh",
                              title, "cool"))
  expect_true(repo_exists("chibimaelle", "cool"))


  quoted_expression <- quote(gh::gh("DELETE /repos/:owner/:repo",
                                    owner = "chibimaelle", repo = "cool"
  ))

  expect_true(gh_retry(quoted_expression))
})


test_that("setup_gh_repo fails well", {
  skip_if_not(identical(Sys.getenv("TRAVIS"), "true"))
  testthat::skip_if_not(nzchar(Sys.getenv("GITHUB_PAT")))
  testthat::skip_if_not(gh::gh_whoami()$name == "chibimaelle")
  expect_error(setup_gh_repo(username = "maelle", private = TRUE,
                              protocol = "ssh",
                              title, "cool"),
               "GitHub repo creation failed")
})
