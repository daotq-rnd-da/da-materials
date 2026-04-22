# 📦 DA-Materials: R Functions Toolbox

## You can call these functions directly into your R environment without downloading the files manually. This ensures you are always using the most up-to-date version of the code. This is for calling function separately. 

## Step 1: Run this code in your R script
CallFunction <- function(file) {
  base_url <- "https://raw.githubusercontent.com/daotq-rnd-da/chart-map-functions/refs/heads/main/r_functions/"
  source(paste0(base_url, file))
}

## Step 2: Add name of a specific function to call it
example: CallFunction("SaveHTMLMapToPNG.R")
