#' Use RStudio
#'
#' Creates an \code{.Rproj} file and adds RStudio files to \code{.gitignore}
#' and \code{.Rbuildignore}.
#'
#' @inheritParams use_template
#' @export
use_rstudio <- function(base_path = ".") {
  use_template(
    "template.Rproj",
    paste0(project_name(base_path), ".Rproj"),
    base_path = base_path
  )

  use_git_ignore(".Rproj.user", base_path = base_path)
  use_build_ignore(c("^.*\\.Rproj$", "^\\.Rproj\\.user$"), escape = FALSE, base_path = base_path)

  invisible(TRUE)
}


# Is base_path open in RStudio?
in_rstudio <- function(base_path = ".") {
  if (!rstudioapi::isAvailable())
    return(FALSE)

  if (!rstudioapi::hasFun("getActiveProject"))
    return(FALSE)

  proj <- rstudioapi::getActiveProject()

  normalizePath(proj) == normalizePath(base_path)
}
