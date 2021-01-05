#' Remove Rows of a Data Frame by Percent NA Values
#'
#' @param .df a data.frame object
#' @param greater_than double. The cutoff percent of NA values in a row to remove that row.
#'   Defaults to 0.25
#'
#' @return a data frame with specified rows removed.
#' @export
#'
#' @examples
#' df <- data.frame(A = runif(5), B = runif(5), C = runif(5))
#' df$B[3:4] <- NA
#' df$C[4] <- NA
#' strip_na_percent(df, greater_than = .5)
strip_na_percent <- function(.df, greater_than = .25) {
    na_percent <- apply(.df, 1, percent_missing)
    .df[na_percent < greater_than, ]
}
