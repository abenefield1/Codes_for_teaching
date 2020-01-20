# Read all comments. The code will not work unless you edit it as comments direct.

#Open a new script in R. Save it as "Bridges.r" 

#Enter the bridge fitness data for each generation as separate vectors
  # Using the 'concatenate' command: c()
span_gen_1 <- c(ENTER, VALUES, HERE, SEPARATED, BY, COMMAS)
span_gen_2 <- c()
load_gen_1 <- c()
load_gen_2 <- c()

#Calculate the fitness based on span x load
fitness_gen_1 <- span_gen_1 * load_gen_1
fitness_gen_1
fitness_gen_2 <- # Calculate the fitness of gen 2
fitness_gen_2

#Plot the data (fitness of generation 1 versus firtness of generation 2) using a boxplot

# The general  command for boxplot is: boxplot(treatment1, treatment2). See if you can make a boxplot for the fitness of the two generations by completing the code below
boxplot(, , xlab="Rename X label", ylab="Rename Y label", main= "Rename Title")

#Make a scatter plot of span versus load. First combine data (for both generations) using the concatenate function: c()
  # Create a vector for all span values and a seperate vector for all load values
span_all <- c() # Complete code
span_all
load_all <- c() # Complete code

# The general scatter plot command is: plot(x, y). We want span to be on the x axis and load to be on the y axis. Complete the code below by replacing x & y with the correct vectors
plot(, , xlab="Rename X label (with units)", ylab="Rename y label (with units")

#Draw a best fit line on graph - run a linear regression
  # To run a linear regression, the command is lm(y~x)
    # This translates to "run a linear model of y, given x. Complete the code below, remembering that load is y and span is x
model <- lm( ~ ) # Complete code
summary(model) # P-value is in the bottom right of the output. Also, find R squared
model$coefficients # Gives intercept and slope of line
abline(model) # Adds the line for "model" to your scatter plot

