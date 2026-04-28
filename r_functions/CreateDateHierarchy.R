#' @title Add time dimensions to dataframe
#' @description 
#' This function takes a dataframe and a date column to generate multiple time-related 
#' dimensions such as Month-Year, Year-Quarter, Month, Year, and Year-Month string.
#' @author daotq
#' 
#' @param data A dataframe or tibble.
#' @param date_column The column containing date objects (unquoted).
#' @return A modified dataframe with new time-related columns.
#' @export

CreateDateHierarchy <- function(data, date_column) {
  
  # Check and then install/load libraries
  if (!require("pacman")) install.packages("pacman")
  pacman::p_load(lubridate, zoo, dplyr)

  # Add date dimensions
  data <- data %>% 
    mutate(
      # Monthly index (e.g., "Jan 2026")
      MonthYear = zoo::as.yearmon({{ date_column }}), 
      
      # Quarterly index (e.g., "2026 Q1")
      YearQtr = zoo::as.yearqtr({{ date_column }}), 
      
      # Numeric month as string ("01", "02"...)
      Month = format({{ date_column }}, format = "%m"), 
      
      # Full year as string ("2026")
      Year = format({{ date_column }}, format = "%Y"), 
      
      # Combined string (e.g., "2026-01")
      YearMonth = paste(Year, Month, sep = "-") 
    )
  
  return(data)
}
