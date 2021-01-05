#' Determine Row Percentage NA Values
#'
#' @param x a vector
#'
#' @return a numeric vector containing the percentage of NA values in x
percent_missing <- function(x) {
    sum(is.na(x)) / length(x)
}
