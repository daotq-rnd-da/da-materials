#' @title Convert Excel files to RData 
#' @description Function to convert csv/xlsx/xls files in a folder to RData, 
#' user inputs the folder path that stores the original files. 
#' Rdata created will be stored in the same folder. 
#' For csv, the output Rdata is named after the original file.
#' For xlsx, it creates separate RData files for each sheet using the format: 
#' "FileName_SheetName.RData".
#' @author daotq
#'
#' @param path Character. Directory path. If NULL, uses current working directory.
#' @export

ConvertExcelFilesToRData <- function(path = NULL) {
  
  # Setup
  if (!require("pacman")) install.packages("pacman")
  pacman::p_load(readr, readxl, tools)
  
  if (is.null(path)) path <- getwd()
  if (!dir.exists(path)) stop("Directory not found.")
  
  # List files
  files <- list.files(path, pattern = "\\.(csv|xlsx|xls)$", full.names = TRUE, ignore.case = TRUE)
  
  if (length(files) == 0) {
    message("No CSV or Excel files found.")
    return(invisible(NULL))
  }
  
  total_rdata <- 0
  
  for (f in files) {
    ext <- tolower(tools::file_ext(f))
    base_name <- tools::file_path_sans_ext(basename(f))
    
    tryCatch({
      # --- Handle CSV ---
      if (ext == "csv") {
        temp_data <- readr::read_csv(f, show_col_types = FALSE)
        
        ## Naming
        obj_name <- base_name
        assign(obj_name, temp_data)
        
        save(list = obj_name, file = file.path(path, paste0(obj_name, ".RData")))
        message(sprintf("> Converted CSV: %s -> %s.RData", basename(f), obj_name))
        total_rdata <- total_rdata + 1
      } 
      
      # --- Handle Excel ---
      else if (ext %in% c("xlsx", "xls")) {
        sheets <- readxl::excel_sheets(f)
        
        for (s in sheets) {
          sheet_data <- readxl::read_excel(f, sheet = s)
          
          ## Naming
          clean_sheet_name <- gsub("[^[:alnum:]]", "_", s)
          combined_name <- paste0(base_name, "_", clean_sheet_name)
          
          assign(combined_name, sheet_data)
          save(list = combined_name, file = file.path(path, paste0(combined_name, ".RData")))
          
          message(sprintf("> Converted Excel Sheet: %s [%s] -> %s.RData", 
                          basename(f), s, combined_name))
          total_rdata <- total_rdata + 1
        }
      }
    }, error = function(e) {
      warning(sprintf("! Error processing %s: %s", basename(f), e$message))
    })
  }
  
  # Print summary message
  message("\n--- Conversion Completed ---")
  message(sprintf("Source files processed: %d", length(files)))
  message(sprintf("RData files created: %d", total_rdata))
}
