# Author: Amy Benefield, 9/12/2019: Base R Commands for Getting Started (Evolution, Fall 2019)

### Installing R and Rstudio
  # https://cran.r-project.org/
  # https://www.rstudio.com/products/rstudio/download/

### Creating R Project:
  #Outside of R: create directory for new project “DIRECT”
  # In R: File -> new project -> new directory -> new project-> “DIRECT”-> set location file path name
  # Then R project should always be where we store data, and also our default directory

### Installing packages: install.packages("package", dependencies = TRUE)
  # Compiling: try no first, then try yes, then try updating R version
  # install.packages("tidyverse", dependencies=TRUE)
  # install.packages("ggplot2", dependencies=TRUE)

### Loading packages: library(package)
  # library(tidyverse)
  # library(ggplot2)

### Loading data:
  # No data, R data object, etc. should have spaces, or any character other than a "." or an "_"
  # Be sure your data is in the same folder as project
  # Be sure it's saved as .csv
  # read.csv(file="data", header=TRUE)
