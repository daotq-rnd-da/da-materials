#' @title Save data with defined format
#'
#' @description
#' This function saves a data frame, tibble, or similar R object to multiple file formats.
#' Supported formats include CSV, Excel, RDS, RData, JSON, and Parquet.
#' @author daotq
#'
#' @param data An R object (data.frame, tibble) to be saved.
#' @param path A character string specifying the output file path, including extension.
#'   The extension determines the file format (e.g., "output.csv", "output.xlsx").
#' @return No return value. The function writes the data to disk and prints a message
#'   confirming the save location.
#' @examples
#'   SaveData(mtcars, "cars.csv")
#'   SaveData(mtcars, "cars.xlsx")
#'   SaveData(mtcars, "cars.Rdata")
#' @export

SaveData <- function(data, path) {

  # Setup
  if (!require("pacman")) install.packages("pacman")
  pacman::p_load(readr, writexl, jsonlite, arrow)

  ext <- tools::file_ext(path)

  # Save files
  switch(ext,
         "csv"    = readr::write_csv(data, path),
         "xlsx"   = writexl::write_xlsx(data, path),
         "rds"    = saveRDS(data, path),
         "RData"  = save(data, file = path),
         "json"   = jsonlite::write_json(data, path, pretty = TRUE),
         "parquet"= arrow::write_parquet(data, path),
         stop("Unsupported file type: ", ext)
  )

  message(">>> Data saved to ", path)
}
