#' @title Load multiple Excel sheets
#' @description 
#' Reads every sheet from a Excel file and assigns each to the 
#' Global Environment as a standalone dataframe named after the sheet.
#' @author daotq
#'
#' @param file_path Character. The path to the .xlsx or .xls file.
#' @return Invisibly returns a character vector of the processed sheet names.
#' @export

LoadExcelSheets <- function(file_path) {
  
  # Setup environment
  if (!require("pacman")) install.packages("pacman")
  pacman::p_load(readxl, purrr, stringr)
  
  # Validation
  if (!file.exists(file_path)) {
    stop(paste("Error: File not found at", file_path))
  }
  
  # Get all sheet names
  all_sheets <- readxl::excel_sheets(file_path)
  
  message("--- Starting Excel Data Import ---")
  message(paste("File:", basename(file_path)))
  message(paste("Total sheets found:", length(all_sheets)))
  
  # Iterative loading
  purrr::walk(all_sheets, function(sheet) {
    
    ## Read sheet data
    data <- readxl::read_excel(file_path, sheet = sheet)
    
    ## Create a valid R variable name
    ## Replaces spaces/special chars with underscores or dots
    var_name <- tolower(make.names(sheet))
    
    ## Assign to Global Environment
    assign(var_name, data, envir = .GlobalEnv)
    
    ## User feedback
    message(paste("Successfully imported sheet [", sheet, "] as object: ", var_name))
  })
  
  message("--- Import Complete ---")
  
  return(invisible(all_sheets))
}
