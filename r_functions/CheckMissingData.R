#' @title Check Missing Data 
#' 
#' @description A summary of NA values and types
#' @author daotq
#'
#' @param df The dataframe to analyze.
#' @param threshold Numeric (0-1). Highlight columns with NA ratio above this. 
#' Default 0.1
#' @export

CheckMissingData <-  function(df, 
                              threshold = 0.1) {
  
    if (!require("pacman")) install.packages("pacman")
    pacman::p_load(dplyr, tibble, purrr, tidyr)
    
    total_rows <- nrow(df)
    if (total_rows == 0) return(message(">>> Dataframe is empty."))
    
    # Collect columns
    report <- df %>%
      summarise(across(everything(), .names = "{.col}__{.fn}", list(
        na_count     = ~sum(is.na(.)),
        na_percent   = ~sum(is.na(.)) / total_rows,
        type         = ~class(.)[1],
        unique       = ~n_distinct(., na.rm = TRUE)
      ))) %>%
      pivot_longer(
        everything(), 
        names_to = c("Variable", ".value"), 
        names_sep = "__"
      ) %>%
      arrange(desc(na_count))
    
    # Classification
    report <- report %>%
      mutate(status = case_when(
        na_percent == 1 ~ "❌ EMPTY",
        na_percent > threshold ~ "⚠️ HIGH NA",
        na_percent > 0 ~ "ℹ️ PARTIAL",
        TRUE ~ "✅ CLEAN"
      ))
    
    # Report output
    clean_cols <- sum(report$na_count == 0)
    total_cols <- ncol(df)
    
    message("--- REPORT OF MISSING DATA ---")
    message(sprintf("Total Rows: %d | Total Columns: %d", total_rows, total_cols))
    message(sprintf("Clean Columns: %d/%d (%0.1f%%)", clean_cols, total_cols, (clean_cols/total_cols)*100))
    
    # Print
    if(any(report$na_count > 0)) {
      print(as.data.frame(report))
    } else {
      message(">>> Perfect! No missing values found.")
    }
    
    return(invisible(report))
}
