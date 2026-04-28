#' @title Format data table for viewing
#'
#' @description Generates a stylized and interactive data table. 
#'     The function automatically standardizes column names to BigCamelCase, 
#'     formats numeric values with thousand separators and two decimal places, 
#'     and freezes header for better navigation.
#' @author daotq
#' 
#' @param data A data frame, tibble, or data.table to be displayed.
#' @param height Numeric. The height of the table container in pixels. 
#'     Setting a fixed height enables the vertical scrollbar and sticky header functionality. 
#'     Defaults to 500.
#' @param rows Numeric. The default number of rows to display per page. 
#'     Defaults to 10.
#' @return A `reactable` HTML widget object.
#' @export 

ViewDataAsTable <- function(data, height = 500, rows = 10) {
  
  # Setup 
  if (!require("pacman")) install.packages("pacman")
  pacman::p_load(reactable, dplyr, snakecase)
  
  # Data Processing
  df <- as.data.frame(data)
  colnames(df) <- snakecase::to_any_case(colnames(df), case = "big_camel")
  
  # Render table
  reactable(
    df,
    height = height,             
    defaultPageSize = rows,
    showPageSizeOptions = TRUE,
    searchable = TRUE,
    filterable = TRUE,
    striped = TRUE,
    highlight = TRUE,
    bordered = TRUE,
    resizable = TRUE,
    
    # Theme and Header
    theme = reactableTheme(
      style = list(fontFamily = "Arial, sans-serif", fontSize = "13px"),
      headerStyle = list(
        position = "sticky",
        top = 0,
        zIndex = 1,                 
        backgroundColor = "#21618C",
        color = "#ffffff",
        fontWeight = "bold",
        borderBottom = "2px solid #1a5276"
      )
    ),
    
    # Default Column Definition
    defaultColDef = colDef(
      headerVAlign = "bottom",
      minWidth = 150,
      format = colFormat(separators = TRUE, digits = 2 ),
      style = function(value) {
        if (is.numeric(value)) {
          list(textAlign = "right", fontFamily = "Arial, monospace")
        } else {
          list(textAlign = "left")
        }
      }
    )
  )
}

