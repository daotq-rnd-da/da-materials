# 📦 RCraftToolbox: R functions for data wrangling

## About this project 🤔
This project is a code library for data wrangling in general. 
<br>
<br>


## Instruction 🔖
You can use function files from this github repo directly in your R environment without manually downloading the files, ensuring you are always working with the most up‑to‑date version of the code. 
This instruction is designed to call functions in folder r_functions separately.

### Step 1️⃣: Run this code in your R script
```R
CallRCraftToolbox <- function(file) {
  git_path <- "https://raw.githubusercontent.com/daotran-rnd/da-materials/refs/heads/main/r_functions/"
  source(paste0(git_path, file))
}
```
### Step 2️⃣: Add name of a specific function to call it
Example:
```R
CallRCraftToolbox("CreateDateHierarchy.R")
```
Now the function `CreateDateHierarchy()` is available in the functions list of your R environment. 

### Step 3️⃣: Use the function for its designated purpose 
Example: We have a dataset `bike_sales` and there is a column called `OrderDate`. 
Here is how to use function `CreateDateHierarchy()`. 
```R
CreateDateHierarchy(data = bike_sales,
                    date_column = OrderDate)
```
Kindly read description in each R function to know parameters to input. 
<br>
<br>

## Recommended order for going through R functions 🏃🏻‍♂️‍➡️
**Batch 1: R working space**
  *	SetupRProjectHere
  *	SetupFolders
  *	SetupRLibraries
  *	CleanRWorkspace
  *	CleanNonFunctions
  *	MemoryProfiler

**Batch 2: Load and save data**
  *	LoadDatasets 
  *	LoadExcelSheets 
  *	ConverExcel2RData
  *	SaveDataFiles

**Batch 3: Data wrangling / working with tables**
  *	ViewDataAsTable
  *	QuickDataSummary
  *	CheckMissingData
  *	TransposeData
  *	JoinData
  *	CreateDateHierarchy
  *	RemoveAccents

### Enjoy and stay strong!⚡
