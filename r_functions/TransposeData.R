#' @title Transpose Data frame with smart type detection
#' 
#' @description Rotates a data frame by swapping rows and columns 
#'    (similar to the Transpose function in Excel) 
#'    and automatically re-detects data types for the new columns.
#' @author daotq
#'
#' @param data A data frame or tibble.
#' @param var_name The name for the new first column.
#' @export

TransposeData <- function(data, var_name = "Variable") {
  
  start_time <- Sys.time()
  
  # Setup
  if (!require("pacman")) install.packages("pacman")
  pacman::p_load(dplyr, tidyr, tibble, readr)
  
  # Transpose data
  res <- data %>%
    mutate(across(everything(), as.character)) %>%
    tidyr::pivot_longer(cols = -1) %>%
    tidyr::pivot_wider(names_from = 1, values_from = value) %>%
    dplyr::rename(!!sym(var_name) := name)
  
  # Auto convert data types to Numeric, Date, Logical...
  res <- res %>% readr::type_convert(guess_integer = TRUE)
  
  duration <- round(as.numeric(difftime(Sys.time(), start_time, units = "secs")), 3)
  message(">>> [Transpose] completed in ", duration, "s. Data types auto-detected.")
  
  return(res)
}
