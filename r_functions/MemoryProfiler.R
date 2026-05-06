#' @title Memory Usage Profiler
#' 
#' @description Identifies top RAM-consuming objects and cleans up the environment.
#' @author daotq
#' 
#' @param n Integer. Number of top objects to display. Default is 10.
#' @param auto_gc Logical. Whether to trigger Garbage Collection automatically. Default is TRUE.
#' @export

MemoryProfiler <- function(n = 10, auto_gc = TRUE) {
  
  # Get all objects in Global Environment
  objs <- ls(envir = .GlobalEnv)
  
  if (length(objs) == 0) {
    message(">>> Your Global Environment is empty.")
    return(invisible(NULL))
  }
  
  # Calculate sizes
  obj_sizes <- sapply(objs, function(x) {
    as.numeric(object.size(get(x, envir = .GlobalEnv))) / (1024^2)
  })
  
  # Create a summary table
  mem_df <- data.frame(
    Object = names(obj_sizes),
    Size_MB = round(obj_sizes, 2),
    stringsAsFactors = FALSE
  )
  
  # Sort by size descending
  mem_df <- mem_df[order(-mem_df$Size_MB), ]
  top_n <- head(mem_df, n)
  
  # Results
  total_mem <- sum(mem_df$Size_MB)
  
  message("--- MEMORY PROFILE REPORT ---")
  message(paste0("Total Memory in Global Env: ", round(total_mem, 2), " MB"))
  message(paste0("Top ", nrow(top_n), " largest objects:"))
  print(top_n, row.names = FALSE)
  message("-----------------------------")
  
  # Suggestions and Action
  large_objs <- top_n$Object[top_n$Size_MB > 100] 
  
  if (length(large_objs) > 0) {
    message(">>> SUGGESTION: Consider removing these large objects if not needed:")
    message("    rm(", paste(large_objs, collapse = ", "), ")")
  }
  
  if (auto_gc) {
    # 'gc' returns memory report from the OS perspective
    captured_gc <- gc(verbose = FALSE)
    message(">>> Garbage Collection (gc) has been triggered to free up System RAM.")
  }
  
  return(invisible(mem_df))
}
