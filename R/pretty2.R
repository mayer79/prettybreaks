#' Pretty Breakpoints
#'
#' Classic algorithm to create pretty breaks from a numeric vector, see reference. In contrast to \code{base::pretty()}, this function works for different number systems and with different notion of "pretty" numbers.
# #' @importFrom stats aggregate, ave  # Import some functions from a package
# #' @import ggplot2                   # Import package if many functions needed
#' @param x Numpy array of size >= 2. Used to derive breaks.
#' @param n Approximate number of intervals between breaks. Defaults to 5.
#' @param p List of basic rounding numbers in [1, base), e.g., \code{p = 10/7} will lead to multiples of 1/7, 10/7, 100/7 etc, whatever fits best to \code{x} and \code{n}. Defaults to \code{c(1, 2, 5)}.
#' @param base Radix of the number system >= 2. Defaults to 10.
#' @param tol Numeric tolerance for close 0 breaks. Defaults to 1e-9.
#' @return A vector with breaks.
#' @export
#' @references
#' W. J. Dixon and R. A. Kronmal (1965). The choice of origin and scale for graphs. Journal of the ACM, 12(2):259-261.
#' @examples
#' x <- 1:100
#'
#' pretty2(x)                           # c(0, 20, 40, 60, 80, 100)
#' pretty2(x, n = 4)                    # c(0, 50, 100, 150)
#' pretty2(x, base = 5)                 # c(0, 25, 50, 75, 100)
#' pretty2(x, p = c(10/7, 20/7, 50/7))  # c(0., 28.57143, 57.14286, ...)
pretty2 = function(x, n = 5, p = c(1, 2, 5), base = 10, tol = 1e-9) {
  # Initialization and checks
  stopifnot(length(x) >= 2L, base >= 2, n >= 2)

  A <- min(x)
  B <- max(x)
  R <- B - A

  if (R <= 0) {
    stop("x is a constant vector!")
  }

  n <- trunc(n)

  p <- sort(p)
  p <- p[(p >= 1) & (p < base)]

  if (length(p) < 1L) {
    stop("p must contain at least one number in [1, base).")
  }

  ti <- floor(logb(R / n, base = base))
  k <- ti + (R / n / base^ti > max(p))
  i <- which(p >= R / n / base^k)[1]

  # Until scale is large enough
  b <- B - 1
  while (B > b) {
    s <- p[i] * base^k
    a <- s * floor(((B + A) / 2 - s * n / 2) / s)
    b <- a + s*n

    if (i < n) {
      i <- i + 1
    } else {
      i <- 1
      k <- k + 1
    }
  }

  # Organize output
  out <- seq(a, b, s)
  out <- out[(out >= A - s) & (out <= B + s)]
  out[abs(out) < tol] <- 0
  out
}

# Put (undocumented) helper functions here

