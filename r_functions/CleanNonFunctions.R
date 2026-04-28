#' @title Clean Environment and Keep Functions
#'
#' @description 
#' Removes all non-function objects (dataframes, vectors, lists, etc.) 
#' from the specified environment while keeping all functions.
#' @author daotq
#'
#' @param env The environment to clean. Defaults to the Global Environment (.GlobalEnv).
#' @return Invisible NULL. The function's primary purpose is the side effect of object removal.
#' @export

CleanNonFunctions <- function(env = .GlobalEnv) {
  
  # List all objects in the specified environment
  objs <- ls(envir = env)
  
  # Identify objects that are NOT functions
  non_funcs <- objs[!sapply(objs, function(x) {
    obj <- get(x, envir = env)
    is.function(obj)
  })]
  
  # Print status message
  if (length(non_funcs) > 0) {
    message(paste("Removed", length(non_funcs), "non-function object(s) from working environment."))
    rm(list = non_funcs, envir = env)
  } else {
    message("No non-function objects found. Environment is already clean.")
  }
  
  return(invisible(NULL))
}
