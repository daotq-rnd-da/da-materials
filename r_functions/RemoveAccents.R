#' @title Remove accents from a dataframe column
#'
#' @description This function converts accented characters (typically in Vietnamese words) 
#' to their unaccented Latin-ASCII equivalents. It is particularly helpful for cleaning names or 
#' addresses in urban/demographic datasets to ensure system compatibility and standardization.
#' E.g.: Convert value of "Hồ Chí Minh City" to "Ho Chi Minh City" in a column "CityName".
#' @author daotq
#' 
#' @param data A dataframe or tibble.
#' @param target_column The unquoted column name containing accented text.
#' 
#' @return A modified dataframe with the target column converted to ASCII.
#' @export

RemoveAccents <- function(data, target_column) {
  
  # Setup environment
  if (!require("pacman")) install.packages("pacman")
  pacman::p_load(stringi, dplyr, rlang)
  
  # Capture column name and create new column name string
  col_name_str <- rlang::as_label(rlang::enquo(target_column))
  new_col_name <- paste0(col_name_str, "_unaccented")
  
  # Process data
  data <- data %>%
    mutate(
      !!new_col_name := stringi::stri_trans_general({{ target_column }}, "Latin-ASCII")
    ) |> 
    relocate(!!new_col_name, .after = {{ target_column }} )
  
  return(data)
}
