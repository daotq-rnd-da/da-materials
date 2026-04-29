#' @title Load R Libraries
#'
#' @description This function installs (if missing) and loads libraries (packages)
#' those are must-have for data wrangling, cleaning, visualization, and export. 
#' It also lets you know the start time, completion status, and total time taken.
#' @author daotq
#'
#' @return Invisible NULL. Prints progress and timing to the console.
#' @export

SetupRLibraries <- function() {
  
  # Record start time
  start_time <- Sys.time()
  
  # Make sure pacman is installed
  if (!require("pacman")) {
    install.packages("pacman")
  }
  
  # Define the list of core libraries
  libs <- c(
    "tidyverse", "readr", "dplyr", "tidyr", "magrittr", # Core packages
    "stringi", "janitor", "lubridate", "zoo",           # Cleaning and Transformation
    "plotly", "highcharter", "echarts4r", "ggplot2",    # Visualization
    "writexl"                                           # Export
  )
  
  # Notify user of the start
  message(">>> [", format(start_time, "%H:%M:%S"), "] Loading core R libraries...")
  
  # Load and/or install libraries
  pacman::p_load(char = libs)
  
  # Record end time and calculate duration
  end_time <- Sys.time()
  duration <- round(as.numeric(difftime(end_time, start_time, units = "secs")), 2)
  
  # Final notifications
  message(">>> [", format(end_time, "%H:%M:%S"), "] R libraries are ready.")
  message(">>> Total initialization time: ", duration, " seconds.")
  
  return(invisible(NULL))
}
