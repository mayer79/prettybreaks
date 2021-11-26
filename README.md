# prettybreaks

`prettybreaks` contains functions to create pretty breaks for numeric vectors. 

Its main function `pretty2()` is similar to `base::pretty()` but allows to use different number systems and other tweaks. 

## Installation

``` r
library(devtools)
install_github("mayer79/prettybreaks")
```

## Teaser

``` r
library(prettybreaks)

x <- 1:100

pretty2(x)                           # c(0, 20, 40, 60, 80, 100)
pretty2(x, n = 4)                    # c(0, 50, 100, 150)
pretty2(x, base = 5)                 # c(0, 25, 50, 75, 100)
pretty2(x, p = c(10/7, 20/7, 50/7))  # c(0., 28.57143, 57.14286, ...)

```

