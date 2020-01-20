# This is how you comment
# Author: Amy Benefield
# Date: 1/15/2020

# This is how you add
2+2
4-3 # subtracting
12/4 # dividing
2*8 # multiplying
sqrt(4) # square root
exp(2) # exponential

# This is how you name variables: <-
x<-2+2
x

# You can combine variables:
y<-x+6
y

# Variables don't change without rerunning code
x<-5
y # y still equals 10, need to rerun
y<-x+6
y # y now equals 11

# This is how you create a dataframe (fancy type of table)
df<-data.frame("Height"=c(160, 168, 170, 174, 180), 
               "Weight"=c(58, 60, 67, 67, 73))
df # To call variable after naming it, simply type the variable name

# Duplicate dataframe, "df" and name it "whatever"
whatever<-df

# This is how you remove variables from environment:
rm(whatever)
whatever # produces error message, "Error: object 'whatever' not found"
# To remove everything command is: rm(list=ls())

# To call columns of dataframe, 2 options: square brackets or dollar sign
  # Square bracket notation to call column Height:
    df[,1]
    # For weight
    df[,2]
    # If I wanted to call 2nd entry in row 3
    df[3,2]
    
    # Square brackets = [row,column]
    
    # To add 6th observation
    df[6,]<-c(1,2)
    df
    # To remove 6th observation
    df<-df[1:5,]
    df
    
    # TO change height of 168 to 169
    df[2,1]<-169
    df
    
  # Dollar sign notation: only useful for calling columns
    df$Height # calling heights
    df$Weight # calling weights
    
# Scatterplot 
    # generic command: plot(x,y)
df
plot(df$Height, df$Weight, 
     xlab="Height", 
     ylab="Weight",
     main="Title")
#plot(df[,1],df[,2])    This is how you would plot in bracket notation

# This is how you run linear regression (make a trend line)
# generic command is: lm(y~x)
line<-lm(df$Weight~df$Height)
summary(line) # Gives summary of linear regression: y=mx+b, y = 0.7574x - 64.2184

# This is how you add lines to scatter plot:
# generic command: abline(line)
abline(line)
# command for vertical line abline(v=line). Adding vertical line for mean in histograms
abline(v=170)

# This is how you read documentation for commands
# generic command: ?NameOfCommand
?abline

# This is how you write a csv file (comma separated values):
?write.csv
write.csv(df,file="Tutorial_Data2.csv", row.names=FALSE)
rm(df)

# This is how you read a csv file:
?read.csv
df2<-read.csv(file="Tutorial_Data2.csv", header=TRUE, sep=",")
df2

# This is how you subset based on some logical condition (by some filter)
  # Generic command for equality: 
    # subset(dataframe, ColumnToSubset==logical condition)
    subset(df2, Height==170)
  # Generic command for greater than: subset(dataframe, ColumnToSubset>logical condition)
    subset(df2, Height>170)
  # Greater than or equal to
    subset(df2, Height>=170)
  # Not is '!'
    subset(df2, Height!=170)
# Everything less than or equal to weight of 67
    subset(df2, Weight<=67)
    