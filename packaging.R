#=====================================================================================
# Create R package
#
# This script creates a simple R package with optional vignette and unit tests.
# Much more info on https://r-pkgs.org/
#=====================================================================================

# Clean up some files and folders. They will be generated later.
for (f in c(".Rbuildignore", "DESCRIPTION", "NAMESPACE", "LICENSE.md", "R/utils-pipe.R"))
  if (file.exists(f)) file.remove(f)
for (f in c("doc", "Meta", "man"))
  if (dir.exists(f)) unlink(f, recursive = TRUE)

# WORKFLOW FOR CREATING A NEW PACKAGE
# 1) Clone this template from https://github.com/mayer79/prettybreaks.
# 2) Rename main folder to YOUR package name, remove folder ".git" and
#    create a fresh git tracking (in RStudio or by running "git init").
# 3) If you don't need them, delete folders "tests" and/or "vignettes".
# 4) Replace word "prettybreaks" in all files and file names by your package name
#    (NEWS.md, packaging,R, *.Rproj, README.md, tests/, vignettes/.
# 5) Put user visible functions of your package into folder "R" as [function_name].R each.
#    Helper functions can be added (undocumented) to a "utils.R" script
#    or in any of the existing scripts in folder "R".
# 6) Edit NEWS.md, README.md, packaging.R and the content of the optional folders
#    "tests" and "vignette" to describe your package.
#    If the package should go to CRAN, edit file "cran-comments.md" as well.
# 7) Restart RStudio and run this script. It will generate a zip and tar.gz package.
#    The vignette is not part of the package but can be found in folder "doc".

# WORKFLOW TO UPDATE PACKAGE TO NEW VERSION
# 1) Update functions, documentation (NEWS.md, README.md, vignettes, tests,
#    and - if package is on CRAN - also cran-comments.md).
# 2) Increase package version in the script below and run this script.

# NOTES
# - Should something go wrong, fix the problems and rerun this script.
# - In your R-scripts, never load a library or run "source".
# - In your R-scripts, the use of "packagename::function" is fine, while
#   you can't use internal functions like "packagename:::function".
# - Keep the dependency footprint small, i.e., don't use unnecessary packages.
# - If the package should go to CRAN, no warnings/notes should appear in check().
# - Git tracking is recommended, but not strictly required.

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
use_gpl_license(2)  # To avoid a warning. For private packages, this is a bit strange.
# use_github_links() # use this if this project is public(!) and is on github

# List required external packages (one row per package)
# use_package("stats", "Imports")  # If your code uses functions from "stats"
# use_pipe()                       # if your code uses the pipe operator %>%

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
check(vignettes = FALSE)             # Run package checks. No errors or warnings should be left.
build()                              # Create tag.gz package in parent(!) folder
build(binary = TRUE)                 # Create zip (for useres without RTools)
install()                            # Install package on your machine

# Run only if package is public(!) and should go to CRAN
if (FALSE) {
  check_win_devel()
  check_rhub()

  # Wait until above checks are passed without relevant notes/warnings
  # then submit to CRAN
  devtools::release()
}

