#In this lab you will get the data that is in a file. The file is formatted as a comma-delimited txt file (a .csv file) that was saved in Microsoft Excel. Once you read the file it will be stored in an object called "finchbeaks".
finchbeaks <- read.csv(file.choose())

#If the first row of the file has names for each column (which it does), you want R to recognize those names and associate them with the appropriate numbers. You do this with the command "attach".  This makes your data frame searchable.

#attach data to make columns available
attach(finchbeaks)

#preview the data
head(finchbeaks)
View(finchbeaks)

#"Died" and "Survived" are all the birds that were sampled in 1977. "NextGeneration" are all the birds that were sampled in 1978. "Mother" + "Father" are a subset of "Survived", "Offspring" are a subset of "Mother"+ "Father"

#Your file contains five columns of numbers, treated by R as vectors, some of which are longer than others. If a column is shorter than the longest, R inserts an NA as a place holder so that all vectors are the same length. Many of the functions in R cannot handle NAs, so you need to get rid of them. The vector Survived has a lot of NAs. Remove them by overwriting the old vector Survived with the command "na.omit()". This will get rid of them. (Aside: sometimes NAs are very useful, just not in this case.)
Survived<-na.omit(survived)
#Now make a vector for those that died
Died<-na.omit(died)


#Objective 1: Estimate Selection (S): The first objective is to construct a histogram of the beak size before and after selection. The data for before selection are in two columns so you need to make a new vector with the two columns combined. You do this by concatenating the survived and died vectors into one vector named "AllIndividuals" using the command "c(x1,x2)". 
AllIndividuals <- c(Died, Survived)
All1977<-AllIndividuals # You'll use this later in objective four

#To visually summarize variation in a population you need to make a histogram. The command "hist(x)" will do this for you. If you store the data from hist(x) you can plot it with other histogram data. So we will do two hist functions or the two populations: before and after selection. We add vertical lines that indicate the average beak size for the individuals before and after selection to help show what the selection coefficient (S, a measure of the extent to which natural selection is acting to reduce the relative contribution of a given genotype to the next generation). Note the command na.rm=TRUE makes sure there are no NA values in the vector.


hist(AllIndividuals, col="green",main="Beak Sizes Before And After Selection",
     xlab="Beak Sizes",ylab="Count")

hist(Survived, col="red", add=T)
legend("topright",legend=c("Before","After","Mean Before","Mean After"), 
       col = c("green", "red", "black","black"),
       lty = c(0, 0, 1,3), lwd = c(0, 0, 1,1),
       pch = c(22, 22, NA,NA),
       pt.bg = c("green", "red", NA,NA),
       pt.cex = 2)

#Calculate the mean before selection
MeanBeforeSelection <- mean(AllIndividuals, na.rm=T)
#Did that produce the correct mean value?  What do you have to add to the code to make it work?

#Calculate the mean after selection
MeanAfterSelection <- mean(Survived, na.rm=T)
#You'll need to change ^this^ line as well

#Calculate S: magnitude of selection
S <- MeanAfterSelection - MeanBeforeSelection
# This will go in your lab write-up

#graph means as vertical lines using "abline()".
abline(v=MeanBeforeSelection, lwd=3)
abline(v=MeanAfterSelection, lwd=3,lty=3)

# While the histogram shows the count of individual beak sizes, a smoothed density plot shows the proportion with each beak size. ** Note: the PROPORTION is taken in EACH subset (before and after selection), so at first glance, it appears that there are more individuals in the second subset, when the opposite is in fact true. Prior to selection, there were 751 individuals. After selection, there were only 90.
dA<-density(AllIndividuals)
plot(dA, ylim=c(0,0.55), xlab="Beak Size", ylab="Proportion of Individuals WITHIN Subsets", main="Density Distribution of Beak Sizes")
polygon(dA, col="green", border="black")
dS<-density(Survived)
polygon(dS,col="red", border="black")
lines(dA, col="black")
#graph means as vertical lines using "abline()".
abline(v=MeanBeforeSelection, lwd=3)
abline(v=MeanAfterSelection, lwd=3,lty=3)
legend("topright",legend=c("Before","After","Mean Before","Mean After"), 
       col = c("green", "red", "black","black"),
       lty = c(0, 0, 1,3), lwd = c(0, 0, 1,1),
       pch = c(22, 22, NA,NA),
       pt.bg = c("green", "red", NA,NA),
       pt.cex = 2)


# Now, if we wanted to view this as a frequency distribution (raw number of individuals), we have to make some adjustments to our density distribution from above. **This graph will most closely resemble the graph found in the lab reading.

# First, we convert "density" or "proportion" to frequency (or # of individuals) by multiplying each datapoint by the number of individuals in the given generation:
freqdA<-dA$y*length(AllIndividuals)
freqdS<-dS$y*length(Survived)
# Plot beak sizes versus frequency:
plot.new()
plot(dA$x, freqdA, type="l", xlab="Beak Size", ylab="Number of Individuals", main="Frequency Distribution of Beak Sizes")
polygon(dA$x, freqdA, col="green", border="black")
polygon(dS$x, freqdS,col="red", border="black")
# Add mean lines
abline(v=MeanBeforeSelection, lwd=3)
abline(v=MeanAfterSelection, lwd=3,lty=3)
legend("topright",legend=c("Before","After","Mean Before","Mean After"), 
       col = c("green", "red", "black","black"),
       lty = c(0, 0, 1,3), lwd = c(0, 0, 1,1),
       pch = c(22, 22, NA,NA),
       pt.bg = c("green", "red", NA,NA),
       pt.cex = 2)

# Answer all questions in lab write-up document:
#Question 1: Briefly describe the figures above. In your description include the average beak sizes before and after selection, and the estimate of S.

  
#Objective 2: Visualize selection: Objective 2 asks you to construct a graph of survivorship as a function of beak size. The survivorship data is a 0 if the bird died and a 1 if the bird survived. We need to make a new vector that has zeros and ones depending on whether individuals lived or died and because our vector AllIndividuals is organized as all the individuals that died and then all individuals that survived we can simply count that number of individuals that died and put the same number of 0s in a vector and then count the number of individuals that lived and put the same number of 1s below the zeros. To make it easy we'll do it in two steps: make two vectors, one with 0s and one with 1s and then we'll put the two together. The command "rep(x,y)" makes a vector of x values that is of length y.

SurvInd <- rep(1,length(Survived))
DiedInd <- rep(0,length(Died))


#Put the zeros and ones into a single vector
Fitness <- c(DiedInd,SurvInd)

#Now its simply a matter of plotting the trait values in FirstGen against fitness. We can estimate the probability of survival from these data using a logistic regression (slightly different from linear regression) and plot the predicted values. I don't expect you to know this; however, it is worth spending some time researching logistic regression a little if you have an interest in this sort of thing (i.e. estimating probabilities).

#First we will plot the data, then we run the logistic regression. The line estimates expected probability of survival as a function of beak size. The function "glm(formula = y ~ x, family=binomial(link="logit"))" allows you to run a logistic regression (in case you are wondering). The function "predict" allows you to draw the expectation line. You are not expected to understand the mathematics, but you should be able to interpret the graph


plot(AllIndividuals, Fitness, ylab="Fitness",
     xlab="Beak Size", main="Fitness of Finch Beaks")

fitness.model <- glm(formula = Fitness ~ AllIndividuals,
                     family=binomial(link="logit"))
newdata <- predict(fitness.model, type="response")
expected.x <- sort(AllIndividuals)
expected.y <- sort(newdata)
lines(expected.x, expected.y, lwd=3)


#Question 2
#Provide a brief description of the figure above. What does the regression line communicate about survival and beak size? Do you think this is a relatively strong or weak relationship, and why?
  
  
#Objective 3: Estimate heritability (H). Objective 3 asks you to visualize the dependence of offspring trait values on the trait values of the midparent (average parent). You have a vector of values of the father and the mother and the offspring. First you need to make the midparent values vector. As I said, this is the average of the two parent vectors: Mother and Father.

#Construct a vector of the mid-parent values.
MidParent <- (mother + father)/2

#Construct a plot showing the dependence of offspring values on the mid-parent value.
plot(MidParent, offspring, main="Estimate of Heritability", 
     xlab="Midparent", ylab="Offspring")

#Perform a linear regression and get the slope and then draw the slope on the graph 
#using some pretty color. You need to get the value for 
#the slope of the line and the p value from the linear regression.

model <-  lm(offspring~MidParent) #linear model of Offspring explained by Midparent

#The slope of the line estimates heritability, H. This is stored in the model and 
#so is the p value. 

summary(model)
H <- summary(model)$coeff[2,1] #un-comment once you create model
p <- summary(model)$coeff[2,4] #un-comment once you create model


#Draw the regression line on the graph
abline(model, lwd=2, col="red") #un-comment once you create model



#Question 3: Provide a brief description of the figure above. What are the estimated coefficients and what is the formal evidence to support or deny the claim that there is heritable variation for beak size in these finches?

#Objective 4: Visualize evolution (change between generations) (R): This objective repeats what you have already done for the first objective only it uses different data. You need to write annotation and the code that accomplishes this objective
#First two overlapping histograms and means. Compare all the 1977 birds with the 1978 birds (see lines 29-54 above). Your histograms should include similar details to the ones made in Objective 1, including vertical lines for the average beak sizes. 
NextGen<-na.omit(NextGeneration)
  #YOUR CODE HERE
hist(All1977, col="green",main="Beak Sizes in Subsequent Generations", xlab="Beak Sizes",ylab="Count")

hist(NextGen, col="red", add=T)
legend("topright",legend=c("Gen 1","Gen 2","Mean Gen 1","Mean Gen 2"), 
       col = c("green", "red", "black","black"),
       lty = c(0, 0, 1,3), lwd = c(0, 0, 1,1),
       pch = c(22, 22, NA,NA),
       pt.bg = c("green", "red", NA,NA),
       pt.cex = 2)

MeanGen1 <- mean(AllIndividuals, na.rm=T) #Calculate the mean before selection

MeanGen2 <- mean(NextGen, na.rm=T)#Calculate the mean after selection

S2 <- MeanGen1 - MeanGen2 #Calculate S: magnitude of selection
# This will go in your lab write-up

#graph means as vertical lines using "abline()".
abline(v=MeanGen1, lwd=3)
abline(v=MeanGen2, lwd=3,lty=3)
1995-1815

# Density Plot Optional
d77<-density(All1977)
plot(d77, xlab="Beak Size", ylab="Proportion of Individuals", main="Density Distribution of Beak Sizes Across Years")
polygon(d77, col="green", border="black")
d78<-density(NextGen)
polygon(d78,col="red", border="black")
lines(d77, col="black")
abline(v=MeanGen1, lwd=3)
abline(v=MeanGen2, lwd=3,lty=3)
legend("topright",legend=c("Gen 1","Gen 2","Mean Gen 1","Mean Gen 2"), 
       col = c("green", "red", "black","black"),
       lty = c(0, 0, 1,3), lwd = c(0, 0, 1,1),
       pch = c(22, 22, NA,NA),
       pt.bg = c("green", "red", NA,NA),
       pt.cex = 2)

# Frequency Plot Optional:
freqd77<-d77$y*length(All1977)
freqd78<-d78$y*length(NextGen)
# Plot beak sizes versus frequency:
plot.new()
plot(d77$x, freqd77, type="l", xlab="Beak Size", ylab="Number of Individuals", main="Frequency Distribution of Beak Sizes 1977-1978")
polygon(d77$x, freqd77, col="green", border="black")
polygon(d78$x, freqd78,col="red", border="black")
abline(v=MeanGen1, lwd=3)
abline(v=MeanGen2, lwd=3,lty=3)
legend("topright",legend=c("Gen 1","Gen 2","Mean Gen 1","Mean Gen 2"), 
       col = c("green", "red", "black","black"),
       lty = c(0, 0, 1,3), lwd = c(0, 0, 1,1),
       pch = c(22, 22, NA,NA),
       pt.bg = c("green", "red", NA,NA),
       pt.cex = 2)

  
#Question 4: Provide a few sentences that describe what happened on the island that explains the intense selection (include an example for why so many birds died and why beak size changed); make sure to cite your sources.
  