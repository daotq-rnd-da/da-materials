#' @title Setup Project Structure
#' @description Creates a standardized folder structure at a specified path without overwriting existing data.
#' @author daotq
#' 
#' @param base_path Character. The root directory where the project will be setup. Defaults to current working directory.
#' @param extra_folders Character vector. Optional names of additional folders to create.
#'
#' @export

SetupFolders <- function(base_path = getwd(), extra_folders = NULL) {
  
  # Normalize the base path
  root <- normalizePath(base_path, winslash = "/", mustWork = FALSE)
  
  # Define structure with nested data folders
  core_folders <- c(
    "data",
    file.path("data", "data_raw"),
    file.path("data", "data_processed"),
    "scripts",
    "visuals"
  )
  
  # Combine with extra folders if any
  all_folders <- unique(c(core_folders, extra_folders))
  
  # Progress Reporting
  message("--- Folder Setup Started ---")
  message(paste("Target Directory:", root))
  message("---------------------------------------")
  
  for (f in all_folders) {
    ## Combine the base path with the folder name
    target_dir <- file.path(root, f)
    
    ## CRITICAL CHECK: Only create if the directory DOES NOT exist
    if (!dir.exists(target_dir)) {
      
      ### recursive = TRUE ensures parent folders are created if missing
      dir.create(target_dir, recursive = TRUE)
      
      ### Double check after creation
      abs_path <- normalizePath(target_dir, winslash = "/", mustWork = FALSE)
      message(paste("[Created]", f))
      message(paste("      at:", abs_path))
    } else {
      
      ### If folder exists, do nothing to protect existing files
      abs_path <- normalizePath(target_dir, winslash = "/", mustWork = FALSE)
      message(paste("[Protected] Folder already exists - No changes made to:"))
      message(paste("           ", f))
      message(paste("      at:  ", abs_path))
    }
  }

  # Complete message 
  message("--- Folder Setup is Complete! ---")
}
