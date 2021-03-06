#' Create a vignette
#'
#' Adds needed packages to \code{DESCRIPTION}, and creates draft vignette
#' in \code{vignettes/}. It adds \code{inst/doc} to \code{.gitignore}
#' so you don't accidentally check in the built vignettes.
#'
#' @param name File name to use for new vignette. Should consist only of
#'   numbers, letters, _ and -. I recommend using lower case.
#' @export
#' @inheritParams use_template
use_vignette <- function(name, base_path = ".") {
  use_dependency("knitr", "Suggests", base_path = base_path)
  use_description_field("VignetteBuilder", "knitr", base_path = base_path)
  use_dependency("rmarkdown", "Suggests", base_path = base_path)

  use_directory("vignettes", base_path = base_path)
  use_git_ignore(c("*.html", "*.R"), "vignettes", base_path = base_path)
  use_git_ignore("inst/doc", base_path = base_path)

  path <- file.path("vignettes", slug(name, ".Rmd"))

  done("Creating '", path, "'")
  rmarkdown::draft(file.path(base_path, path), "html_vignette", "rmarkdown",
    create_dir = FALSE, edit = FALSE)
  open_in_rstudio(path, base_path = base_path)
}
