# Author: Your Name, Date, Title
## Pound sign to annotate
# Control + Enter or Command + Enter = moves from script to console

# install.packages("package name you want", dependencies = TRUE) This is how you download packages - only need to do once
install.packages("tidyverse", dependencies=TRUE)
install.packages("ggplot2", dependencies = TRUE)
install.packages("dplyr", dependencies=TRUE)
install.packages("plyr", dependencies=TRUE)

# This is how you load packages - need to do every time you use them
library(tidyverse)
library(ggplot2)
library(dplyr)
library(plyr)

# Load data into R
Burdock_data<-read.csv(file="Burdock_data.csv", header=TRUE) # This is how you read data in
View(Burdock_data) # This is how we look at full data sheet
head(Burdock_data) # Shows first 6 lines of data frame
str(Burdock_data) # Structure: shows the structure
names(Burdock_data) # tells you column names

dat<-ddply(Burdock_data, .(Plant_number), summarize, # Collapses Burdock dataframe based on Plant_number ID
      No_burrs=mean(No_burrs), # Taking mean of No_burrs - should be same across the plant
      Plant_size=mean(Plant_size), # ""
      Avg_No_seeds=mean(No_seeds), # Finding the avg. # of seeds per burr per plant
      Num=length(Plant_number) # Indexing number rows collapsed for sanity check
      )

head(dat)
dat$Fecundity<- dat$No_burrs * dat$Avg_No_seeds # Calculating fecundity and adding a column to a data frame
head(dat)

#### Histogram of Burdock Data
ggplot(dat, aes(Fecundity))+
  geom_histogram(binwidth=250)+
  geom_vline(xintercept=mean(dat$Fecundity))+
  ggtitle("Burdock Fecundity Distribution")+
  #xlab()
  ylab("Count (number of plants)")

sd(dat$Fecundity) # 
               
  









