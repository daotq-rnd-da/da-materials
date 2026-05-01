#' @title Create R Project in current Working Directory
#' 
#' @description 
#' Check and create .Rproj at the current working directory (wd).
#' Note: remember to set up wd first before running this function.  
#' @author daotq
#'
#' @export

SetupRProjectHere <- function() {
  
  # Setup
  if (!require("pacman")) install.packages("pacman")
  pacman::p_load(usethis, fs)
  
  current_path <- getwd()
  project_name <- fs::path_file(current_path)
  proj_file_path <- paste0(current_path, "/", project_name, ".Rproj")
  
  # Check if file .Rproj exists
  if (file.exists(proj_file_path)) {
    message(">>> [Warning]: File .Rproj already exist at: ", current_path)
  } else {
    
  # Create R Project 
    ## input open = FALSE to avoid new RStudio window popup
    usethis::create_project(current_path, open = FALSE)
    message(">>> [Success]: Created .Rproj at: ", current_path)
  }
  
  return(invisible(current_path))
}

