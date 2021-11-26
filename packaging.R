#=====================================================================================
# BUILD THE PACKAGE
#=====================================================================================
# This script creates a simple R package with vignette and unit tests.

# WORKFLOW
# 1) Rename main folder to YOUR package name
# 2) Replace word "prettybreaks" by your package name in all files
#    (cran-comments, NEWS, packaging, Rproj, README, tests/..., vignettes/....
# 3) Put main functions of your package into folder "R" as [function_name].R each.
#    Helper functions can be added (undocumented) to a "utils.R" script or below
#    its main function.
# 4) Edit cran-comments, NEWS, README, packaging and the content of the folders
#    tests/ and vignette/ to fit your package.
# 5) Run this script

library(usethis)
library(devtools)
library(testthat)
library(knitr)
library(rmarkdown)

# Clean up files and folders
for (f in c(".Rbuildignore", "DESCRIPTION", "NAMESPACE")) {
  if (file.exists(f)) {
    file.remove(f, recursive = TRUE)
  }
}

for (f in c("doc", "Meta", "man")) {
  if (dir.exists(f)) {
    unlink(f, recursive = TRUE)
  }
}

# Create description file
use_description(
  fields = list(
    Package = "prettybreaks",
    Title = "Pretty Breaks",
    # Type = "Package",
    Version = "0.0.1",
    Date = Sys.Date(),
    Description = "Creation of pretty breaks for numeric vectors, extending the base function `pretty()` in R base.",
    `Authors@R` = "person('Michael', 'Mayer', email = 'mayermichael79@gmail.com', role = c('aut', 'cre'))",
    URL = "https://github.com/mayer79/prettybreaks",
    BugReports = "https://github.com/mayer79/prettybreaks/issues",
    Depends = "R (>= 3.1.0)",
    VignetteBuilder = "knitr",
    License = "GPL(>= 2)",
    LazyData = NULL,
    Maintainer = "Michael Mayer <mayermichael79@gmail.com>"),
  roxygen = TRUE)

# Add dependencies to DESCRIPTION
# use_package("stats", "Imports")     # List packages used by your functions as "Imports"
use_package("knitr", "Suggests")      # For vignette
use_package("rmarkdown", "Suggests")  # Same
use_package("testthat", "Suggests")   # For automatic tests

# List files and folders that do not belong to the package
use_build_ignore(c(".git", ".gitignore", "packaging.R", "cran-comments.md",
                   "doc", "Meta", "[.]Rproj$", ".Rproj.user"), escape = FALSE)

# Finish package building
document()            # Create documentation from Roxygen tags (@param etc.)
test()                # Run own unit tests
build_vignettes()     # Build vignete
check(manual = TRUE)  # Run package checks
build()               # Create package in parent(!) folder
install()             # Install it

#======================================
# Run if package shoud go to CRAN
#======================================

check_win_devel()
check_rhub()

# Wait until above checks are done, then submit to CRAN
devtools::release()
