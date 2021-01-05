#' Extract Data From a Report
#'
#' @param .df a data frame object.
#' @param checkcol numeric. (optional). The column number to check for NA values.
#'     If not specified, extract_data will attempt to guess the appropriate column.
#' @param promote_colnames logical. (optional). Should the first row be promoted
#'     to column names?
#' @param strip_na_greater_than double between 0 - 1. Drops rows with greater than this percentage of missing values. Defaults to 0.2
#'
#' @return a data frame object.
#' @export
#'
#' @examples
#' \dontrun{
#' df <- readxl::read_excel("man/example/example-report.xlsx")
#' extract_data(df)
#' }
#'
extract_data <- function(.df,
                         checkcol = NA,
                         promote_colnames = TRUE,
                         strip_na_greater_than = .20) {
    # drop any columns with only NA values
    .df <- dplyr::select_if(.df, function(x) any(!is.na(x)))

    # find the first row with the fewest NA values in the header
    startrow <- which.min(apply(.df[1:15,], 1, function(x) sum(is.na(x))))[1]
    # drop everything before this start row
    .df <- .df[startrow:nrow(.df), ]

    # drop any columns with only NA values (again)
    .df <- dplyr::select_if(.df, function(x) any(!is.na(x)))

    # count the NA values in each column
    nacount  <- apply(.df, 2, function(x) sum(is.na(x)))
    if (is.na(checkcol)) {
        # assume that key exists on first column with fewest missing values
        checkcol <- names(which.min(nacount))[1]
    }

    # drop any rows which have NA values in the check column
    .df <- tidyr::drop_na(.df, checkcol)

    # drop rows with greater than the specified percent of NA values
    .df <- strip_na_percent(.df, strip_na_greater_than)

    if (promote_colnames) {
        # promote row to columns names
        .df <- promote_colnames(.df)
    }
    return(.df)
}
