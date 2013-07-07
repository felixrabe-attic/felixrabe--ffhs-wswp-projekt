f <- function(x, ...) {
  format(x, ..., big.mark = "'", scientific = FALSE, trim = TRUE)
}

eq <- function(a, b) {
  abs(a - b) < abs(a) / 10000
}

aeq <- function(a, b) {
  if (!eq(a, b)) stop('unexpected unequality')
}
