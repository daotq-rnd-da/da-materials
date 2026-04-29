#' @title Generate a Data Summary
#'
#' @description This function provides a detailed overview of structure of a dataframe.  
#' For each column, it calculates the data type, number of unique values, 
#' count and percentage of missing values (NA), and basic descriptive statistics 
#' (Min, Max, Mean, SD) for numeric variables.
#' @author daotq
#'
#' @param data A dataframe or tibble to be summarized.
#' @export

QuickDataSummary <- function(data) {
  
  # Ensure required packages are loaded
  if (!require("pacman")) install.packages("pacman")
  pacman::p_load(dplyr, purrr, tibble)
  
  # Main logic
  data %>%
    purrr::map_df(~tibble(
      Type = class(.x)[1],
      Unique = n_distinct(.x),
      N_NA = sum(is.na(.x)),
      Perc_NA = round(sum(is.na(.x)) / length(.x) * 100, 2),
      Min =  if(is.numeric(.x)) min(.x, na.rm = TRUE) else NA,
      Max =  if(is.numeric(.x)) max(.x, na.rm = TRUE) else NA,
      Avg = if(is.numeric(.x)) round(mean(.x, na.rm = TRUE), 2) else NA ,
      SD =   if(is.numeric(.x)) sd(.x, na.rm = TRUE) else NA,
    ), .id = "Variable")
}
