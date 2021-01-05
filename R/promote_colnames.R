#' Promote Row to Column Names
#'
#' @param .df a data frame
#' @param rownum numeric. The row in the data frame to be promoted to column names
#'
#' @return a data frame with the promoted row as column names
#' @export
#'
#' @examples
#' df <- data.frame(v1 = c("X", "123.45"), v2 = c("Y", "345.67"))
#' promote_colnames(df)
promote_colnames <- function(.df, rownum = 1) {
    .names <- .df[rownum, ]
    colnames(.df) <- .names
    .df[-rownum, ]
}
