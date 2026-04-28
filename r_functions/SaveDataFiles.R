#' @title Save all data frame objects in the global environment as .RData files
#' @description Automatically identifies and exports all `data.frame` objects from the 
#' Global Environment into `.RData` files.
#' @author daotq
#' 
#' @param path Character. The directory path where files will be saved. 
#' If there is no input for path, data will be stored in a folder "saved_data" 
#' which is created in the current working directory.
#' @export

SaveDataFiles <- function(path = NULL) {
  
  # Setup default path
  if (is.null(path)) {
    path <- file.path(getwd(), "saved_data")
  }
  
  # Create directory if it doesn't exist
  if (!dir.exists(path)) {
    dir.create(path, recursive = TRUE)
  }
  
  # Identify all objects in global environment
  all_objs <- ls(envir = .GlobalEnv)
  
  # Filter objects that are data.frames or tibbles
  data_objs <- Filter(function(x) {
    obj <- get(x, envir = .GlobalEnv)
    is.data.frame(obj)
  }, all_objs)
  
  # Save data
  if (length(data_objs) == 0) {
    message("No data frame objects found in your environment.")
    return(invisible(NULL))
  }
  
  for (obj_name in data_objs) {
    file_path <- file.path(path, paste0(obj_name, ".RData"))
    save(list = obj_name, file = file_path, envir = .GlobalEnv)
  }
  
  # Report message
  message(sprintf("Saved %d data file(s) to folder: %s", length(data_objs), path))
}
