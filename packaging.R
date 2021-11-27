#=====================================================================================
# Create R package
#
# This script creates a simple R package with optional vignette and unit tests.
# Much more info on https://r-pkgs.org/
#=====================================================================================

# Firstly, clean up files and folders that are generated later
for (f in c(".Rbuildignore", "DESCRIPTION", "NAMESPACE"))
  if (file.exists(f)) file.remove(f)
for (f in c("doc", "Meta", "man"))
  if (dir.exists(f)) unlink(f, recursive = TRUE)

# WORKFLOW (without clicking any buttons...)
# 0) Rename main folder to YOUR package name.
# 1) Delete folders "tests" and/or "vignettes" if you don't need them.
# 2) Replace word "prettybreaks" by your package name in all files and file names
#    (NEWS.md, packaging,R, *.Rproj, README.md, tests/..., vignettes/....
# 3) Put main functions of your package into folder "R" as [function_name].R each.
#    Helper functions can be added (undocumented) to a "utils.R" script or below
#    its main function.
# 4) Edit cran-comments.md, NEWS.md, README.md, packaging.R
#    and the content of the folders tests/ and vignette/ to fit your package.
#    Restart RStudio.
# 5) Run this script. It will generate a zip and tar.gz package that can be distributed.
#    The vignette is not part of the package but can be found in doc/

# Should something go wrong, fix the problems and rerun this script.

library(usethis)
library(devtools)
library(testthat)
library(knitr)
library(rmarkdown)

has_tests <- dir.exists("tests")
has_vignette <- dir.exists("vignettes")

# Create description file
use_description(
  fields = list(
    Package = "prettybreaks",
    Title = "Pretty Breaks",
    Version = "0.0.1",
    Date = Sys.Date(),
    Description = "Creation of pretty breaks for numeric vectors, extending the base function `pretty()` in R base.",
    `Authors@R` = "person('Michael', 'Mayer', email = 'mayermichael79@gmail.com', role = c('aut', 'cre'))",
    Depends = "R (>= 3.1.0)",
    VignetteBuilder = "knitr",  # maybe remove if there is no vignette
    LazyData = NULL,            # change to TRUE if there is data in your package
    Maintainer = "Michael Mayer <mayermichael79@gmail.com>"),
  roxygen = TRUE)
# use_gpl_license(2) # use this if this project is public(!)
# use_github_links() # use this if this project is public(!) and is on github

# For each package imported in your functions, add a "use_package" line
# use_package("stats", "Imports")

# Packages used for unit tests and/or vignettes
if (has_tests) use_package("testthat", "Suggests")
if (has_vignette) {
  use_package("knitr", "Suggests")
  use_package("rmarkdown", "Suggests")
}

# List files and folders that do not belong to the package
ignore <- c(".git", ".gitignore", "packaging.R", "cran-comments.md",
            "doc", "Meta", "[.]Rproj$", ".Rproj.user")
use_build_ignore(ignore, escape = FALSE)

# Should you need to include data in your package
# use_data(...) # and document it in R/data.R

# Finish package building
document()                           # Create documentation from Roxygen tags (@param etc.)
if (has_tests) test()                # Run unit tests
if (has_vignette) build_vignettes()  # Build vignette (it will be put into "doc/")
check(vignettes = FALSE)             # Run package checks
build()                              # Create package in parent(!) folder
build(binary = TRUE)                 # Create package zip
install()                            # Install it

# Run only if package is public(!) and should go to CRAN
if (FALSE) {
  check_win_devel()
  check_rhub()

  # Wait until above checks are passed without relevant notes/warnings
  # then submit to CRAN
  devtools::release()
}
