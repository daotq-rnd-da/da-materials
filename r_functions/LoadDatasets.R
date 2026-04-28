#' @title Import all datasets from a directory
#'
#' @description 
#' Automatically identifies and loads supported datasets into the Global Environment. 
#' Supported formats: .RData, .rds, .csv, .xlsx, .xls, .sav (SPSS), .dta (Stata), 
#' and .sas7bdat (SAS). For Excel files, only the first sheet is loaded, and 
#' a message notifies the user if additional sheets exist.
#' @author daotq
#'
#' @param path Character. The directory path. If NULL, defaults to the current 
#' working directory.
#' @param include_subfolder Logical. If TRUE, searches all subdirectories. 
#' Defaults to FALSE.
#'
#' @export
LoadDatasets <- function(path = NULL, include_subfolder = FALSE) {
  
  # Setup
  if (!require("pacman")) install.packages("pacman")
  pacman::p_load(readr, readxl, haven, tools)
  
  # Path
  if (is.null(path)) {
    path <- getwd()
    message(">> No path provided. Using current directory: ", path)
  }
  
  if (!dir.exists(path)) {
    stop(sprintf("Directory '%s' does not exist.", path))
  }
  
  # List all files
  all_files <- list.files(path, full.names = TRUE, recursive = include_subfolder)
  
  # Track loaded files
  count <- 0
  
  for (f in all_files) {
    ext <- tolower(tools::file_ext(f))
    obj_name <- tools::file_path_sans_ext(basename(f))
    
    tryCatch({
      ## --- Native R Formats ---
      if (ext == "rdata") {
        load(f, envir = .GlobalEnv)
        count <- count + 1
      } else if (ext == "rds") {
        assign(obj_name, readRDS(f), envir = .GlobalEnv)
        count <- count + 1
      } 
      ## --- Flat Files (CSV) ---
      else if (ext == "csv") {
        assign(obj_name, readr::read_csv(f, show_col_types = FALSE), envir = .GlobalEnv)
        count <- count + 1
      } 
      ## --- Excel Files with a message to load the 1st sheet ---
      else if (ext %in% c("xlsx", "xls")) {
        sheets <- readxl::excel_sheets(f)
        n_sheets <- length(sheets)
        
        assign(obj_name, readxl::read_excel(f, sheet = 1), envir = .GlobalEnv)
        
        if (n_sheets > 1) {
          message(sprintf("i [Excel] Loaded 1st sheet of '%s'. (%d other sheet(s) skipped: %s)", 
                          basename(f), n_sheets - 1, paste(sheets[-1], collapse = ", ")))
        }
        count <- count + 1
      } 
      ## --- Other statistical formats ---
      else if (ext == "sav") {
        assign(obj_name, haven::read_sav(f), envir = .GlobalEnv)
        count <- count + 1
      } else if (ext == "dta") {
        assign(obj_name, haven::read_dta(f), envir = .GlobalEnv)
        count <- count + 1
      } else if (ext == "sas7bdat") {
        assign(obj_name, haven::read_sas(f), envir = .GlobalEnv)
        count <- count + 1
      }
    }, error = function(e) {
      warning(sprintf("! Failed to load: %s. Error: %s", basename(f), e$message))
    })
  }
  
  # Message
  message(sprintf("\nSuccessfully loaded %d dataset(s) from: %s", count, path))
}
