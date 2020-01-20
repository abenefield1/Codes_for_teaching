# Author: Your Name, Date
#install.packages("tidyverse", dependencies=TRUE) # This is how we install new packages
#install.packages("ggplot2", dependencies=TRUE)
#install.packages("dplyr", dependencies=TRUE)
#install.packages("plyr", dependencies=TRUE)

### This is how you load packages for use
library(tidyverse)
library(ggplot2)
library(dplyr)
library(plyr)

### This is how you name things
whatever<-c(1,2,3,4,5)

### This is how you delete data from environment:
rm(whatever) # remove
rm(list=ls()) # clear entire environment

# Loading Burdock data
Burdock_data<-read.csv(file="Burdock_data.csv", header=TRUE)

#Exploring Data
View(Burdock_data) # look at whole sheet
head(Burdock_data) # Look at top 6 six lines of data
str(Burdock_data) # Structure of data
names(Burdock_data) # Show names of columns

dat<-ddply(Burdock_data, .(Plant_number), summarize, # Summarizing on Plant_number field
      No_burrs=mean(No_burrs), # Taking the mean of number of burrs, b/c they should be same
      Avg_No_seeds=mean(No_seeds), # Finding avg no seeds/burr/plant
      Plant_size=mean(Plant_size), # Taking the mean, b/c they should be same
      Num=length(Plant_number)) # Indexing number of collapsed rows

View(dat)
head(dat)

datA<-subset(dat, No_burrs != Num)
str(datA)

