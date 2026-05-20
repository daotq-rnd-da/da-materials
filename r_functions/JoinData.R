#' @title Flexible Dataset Joiner
#'
#' @description A wrapper function to perform various types of joins between two datasets
#' based on a specific key column.
#' @author daotq
#'
#' @param left_data The primary dataframe (left side).
#' @param right_data The secondary dataframe (right side).
#' @param key_col A character vector of variables to join by.
#' @param join_type Character string: "left", "right", "inner", "full", or "anti".
#'        Default is "left".
#' @readmore https://statisticsglobe.com/r-dplyr-join-inner-left-right-full-semi-anti
#' @return A joined dataframe.
#' @export

JoinData <- function(left_data, 
                     right_data, 
                     key_col, 
                     join_type = "left") {

  start_time <- Sys.time()

  # Setup
  if (!require("pacman")) install.packages("pacman")
  pacman::p_load(dplyr, rlang)

  # Standardize join_type
  join_type <- tolower(as.character(join_type))

  # Ensure key_col joinable
  if (is.symbol(substitute(key_col))) {
    key_col <- as.character(substitute(key_col))
  }

  # Select join_type
  result <- switch(
    join_type,
    "left"  = left_join(left_data, right_data, by = key_col),
    "right" = right_join(left_data, right_data, by = key_col),
    "inner" = inner_join(left_data, right_data, by = key_col),
    "full"  = full_join(left_data, right_data, by = key_col),
    "anti"  = anti_join(left_data, right_data, by = key_col),
    stop("Invalid join_type! Choose: left, right, inner, full, or anti.")
  )

  end_time <- Sys.time()
  duration <- round(as.numeric(difftime(end_time, start_time, units = "secs")), 3)

  message(">>> [", join_type, " join] completed in ", duration, " seconds.")
  message(">>> Result: ", nrow(result), " rows x ", ncol(result), " columns.")

  return(result)
}
