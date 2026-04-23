# 📦 DA-Materials: R Functions Toolbox

## You can use function files from this github repo directly in your R environment without manually downloading the files, ensuring you are always working with the most up‑to‑date version of the code. 
## This instruction is designed to call functions in folder r_functions separately.

## Step 1: Run this code in your R script
```R
CallFunction <- function(file) {
  git_path <- "https://raw.githubusercontent.com/daotran-rnd/da-materials/refs/heads/main/r_functions/"
  source(paste0(git_path, file))
}
```
## Step 2: Add name of a specific function to call it
Example:
```R
CallFunction("CreateDateHierarchy.R")
```
