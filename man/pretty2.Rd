% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pretty2.R
\name{pretty2}
\alias{pretty2}
\title{Pretty Breakpoints}
\usage{
pretty2(x, n = 5, p = c(1, 2, 5), base = 10, tol = 1e-09)
}
\arguments{
\item{x}{Numpy array of size >= 2. Used to derive breaks.}

\item{n}{Approximate number of intervals between breaks. Defaults to 5.}

\item{p}{List of basic rounding numbers in [1, base), e.g., \code{p = 10/7} will lead to multiples of 1/7, 10/7, 100/7 etc, whatever fits best to \code{x} and \code{n}. Defaults to \code{c(1, 2, 5)}.}

\item{base}{Radix of the number system >= 2. Defaults to 10.}

\item{tol}{Numeric tolerance for close 0 breaks. Defaults to 1e-9.}
}
\value{
A vector with breaks.
}
\description{
Classic algorithm to create pretty breaks from a numeric vector, see reference. In contrast to \code{base::pretty()}, this function works for different number systems and with different notion of "pretty" numbers.
}
\examples{
x <- 1:100

pretty2(x)                           # c(0, 20, 40, 60, 80, 100)
pretty2(x, n = 4)                    # c(0, 50, 100, 150)
pretty2(x, base = 5)                 # c(0, 25, 50, 75, 100)
pretty2(x, p = c(10/7, 20/7, 50/7))  # c(0., 28.57143, 57.14286, ...)
}
\references{
W. J. Dixon and R. A. Kronmal (1965). The choice of origin and scale for graphs. Journal of the ACM, 12(2):259-261.
}
