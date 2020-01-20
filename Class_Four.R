# Author: Amy Benefield, Title of Script, Date

# This is how you install packages: install.packages("packageName", dependencies=TRUE)
# If package asks about compiling, say no. Only have to install packages once
install.packages("tidyverse", dependencies=TRUE)
install.packages("ggplot2", dependencies=TRUE)
install.packages("dplyr", dependencies=TRUE)
install.packages("plyr", dependencies=TRUE)

# Have to load a package every time - for every R session.
# How to load packages:
library(tidyverse)
library(ggplot2)
library(dplyr)
library(plyr)

##### Burdock Data Analysis:
# How to read in csv data:
Burdock_data<-read.csv(file="Burdock_data.csv", header=TRUE) 
# how to name objects: <-
x<-7
# How to remove objects from environment: rm(object)
rm(x)
# remove all objects in environment with rm(list=ls())

# Exploring data:
#View(Burdock_data)
head(Burdock_data)
str(Burdock_data)
names(Burdock_data)

# How to collapse on ID variable: going from long to wide data format
dat<-ddply(Burdock_data, .(Plant_number), summarize, #collapse Burdock_data by using Plant_number as id variable
      Num_burrs=mean(No_burrs), # take mean of number of burrs per plant, because should all be the same
      Plant_size=mean(Plant_size), # " same deal
      Avg_num_seeds=mean(No_seeds), # Take average of the number of seeds per burr per plant
      RowNums=length(Plant_number) # Sanity check to keep track of number of rows collapsed
      )

head(dat)
# Sanity check: should be 1242
sum(dat$RowNums)

# Calculating Fecundity:
Fecundity<-dat$Avg_num_seeds * dat$Num_burrs
Fecundity
mf<-mean(Fecundity)
mf
sdF<-sd(Fecundity)
sdF

dat$Fecundity<-Fecundity
head(dat)

# Histograms
ggplot(dat, aes(Fecundity))+
  geom_histogram(binwidth = 200)+
  geom_vline(xintercept=mf)+
  ggtitle("Title")+
  ylab("y label")+
  xlab("xlabel")

####
Gen1<-filter(Bridge_data, Generation=="1")
Gen2<-filter(Bridge_data, Generation=="2")

