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
  # install.packages("dplyr", dependencies=TRUE)
  # install.packages("plyr", dependencies=TRUE)


### Loading packages: library(package)
  library(tidyverse)
  library(ggplot2)
  library(dplyr)
  library(plyr)



################## Burdock Data:
### Loading data:
  # No data, R data object, etc. should have spaces, or any character other than a "." or an "_"
  # Be sure your data is in the same folder as project
  # Be sure it's saved as .csv
Burdock_data<-read.csv(file="Burdock_data.csv", header=TRUE)

# Exploring Data:
#View(Burdock_data)
 head(Burdock_data)
#str(Burdock_data)
#names(Burdock_data)

dat<-ddply(Burdock_data, .(Plant_number), summarize, # Summarize on Plant_number field
        No_burrs=mean(No_burrs), # Taking mean, because they should all be the same
        Avg_No_seeds=mean(No_seeds), # Finding average number of seeds per burr per plant
        Plant_size=mean(Plant_size_), # Taking mean, because they should all be the same
        Num=length(Plant_number)) # Indexing number of rows collapsed for data cleaning
View(dat)
head(dat)
dat$Fecundity<-dat$Avg_No_seeds*dat$No_burrs
head(dat)

### Data cleaning: who only entered the # burrs that they counted?
which(dat$No_burrs==dat$Num) # which rows have the same total number of burrs as the number of burrs counted? Which rows are wrong?
which(dat$No_burrs!=dat$Num) # Which rows have different values? Which are right?
data<-dat[which(dat$No_burrs!=dat$Num),] # Let's save only those rows. Rows which only have the number of burrs counted will skew our results to show only low numbers

datA <- subset(dat, No_burrs != Num )
?subset

mf<-mean(data$Fecundity)
# Histogram
ggplot(data, aes(Fecundity))+
  geom_histogram(binwidth=500)+
  geom_vline(xintercept=mean(data$Fecundity))+
  ggtitle("Distribution of Burdock Fecundity")+
  ylab("Count (number of plants)")
  # xlab()

################## Bridge Data:
bridge<-read.csv("Bridge_data.csv", header=TRUE)
head(bridge)
str(bridge)
Gen1<-filter(bridge,Generation=="Gen1")
Gen2<-filter(bridge,Generation=="Gen2")

# Histograms

# Histogram of Generation 1 Fitness only
ggplot(Gen1, aes(Fitness))+
  geom_histogram(binwidth=50)+
  geom_vline(xintercept=mean(Gen1$Fitness))+
  ggtitle("Distribution of Bridge Fitness in Generation 1")+
  ylab("Count (number of bridges)")+
  xlab("Bridge Fitness")

# Histogram of Generation 2 Fitness only
ggplot(Gen2, aes(Fitness))+
  geom_histogram(binwidth=50)+
  geom_vline(xintercept=mean(Gen2$Fitness))+
  ggtitle("Distribution of Bridge Fitness in Generation 2")+
  ylab("Count (number of bridges)")+
  xlab("Bridge Fitness")

# Histogram of all fitness values across generations
ggplot(bridge, aes(Fitness))+
  geom_histogram(binwidth=50)+
  geom_vline(xintercept=mean(bridge$Fitness))+
  geom_vline(xintercept=mean(Gen1$Fitness))+
  geom_vline(xintercept=mean(Gen2$Fitness))+
  ggtitle("Distribution of Bridge Fitness in Both Generations")+
  ylab("Count (number of bridges)")+
  xlab("Bridge Fitness")

# Overlapping Histograms
ggplot(bridge, aes(Fitness, fill=Generation))+
  geom_histogram(binwidth=50)+
  geom_vline(xintercept=mean(bridge$Fitness))+
  geom_vline(xintercept=mean(Gen1$Fitness))+
  geom_vline(xintercept=mean(Gen2$Fitness))+
  ggtitle("Distribution of Bridge Fitness in Both Generations")+
  ylab("Count (number of bridges)")+
  xlab("Bridge Fitness")
