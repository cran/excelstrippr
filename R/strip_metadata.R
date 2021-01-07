#' Strip Report MetaData From Excel File
#'
#' @param from the file path to the excel report.
#' @param promote logical. Should first non-NA row be promoted to column names?
#'     Default tries to make a reasonable determination.
#' @param ... extra parameters to pass to the read_excel function
#' @return a data frame containing the tabular data from the report
#' @export
#'
#' @examples
#' \dontrun{
#' strip_metadata("./man/example/example-report")
#' # specify a particular sheet
#' strip_metadata("my-excel-file.xlsx", sheet = "report summary")
#' }
strip_metadata <- function(from, promote = NA, ...) {
    .df <- suppressMessages(readxl::read_excel(from, col_names = FALSE, ...))
    # check to see if column names need to be promoted
    if (is.na(promote)) {
        if (any(grepl("\\.\\.\\.[0-9]+", names(.df)))) {
            promote = TRUE
        } else {
            promote = FALSE
        }
    }
    .df <- extract_data(.df, promote_colnames = promote)
    return(.df)
}
