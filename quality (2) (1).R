################################################################################
##                          Homework Assignment 3                             ##
##                           Quality Control Caselet                          ##
################################################################################
library(dplyr)

# This script is based on the Quality Control data!!
# Use the caselet description (Quality Control Caselet.docx) and data (quality.csv) 

# Think about the managerial implications as you go along

# The aim of this exercise is to use your knowledge on Analytics process and regression
# I have provided hints where necessary, fill in the missing parts of the statement

################################################################################
# Read the data from the quality.csv
################################################################################

#first things first, lets call our packages

library(ggplot2)

# set the working directory using setwd() and 

setwd("C:/Users/Srinivas Bolli/Documents/FundamentalsOfBA")

# read the data quality.csv
quality <- read.csv(file = "quality.csv")

# like usual, explore the data using 5 functions

dim(quality)

str(quality)

colnames(quality)

head(quality)

tail(quality)

################################################################################
# Q1. Identify the statistical data types. Do you need dummy variable. Yes/ No?
################################################################################

# Correct the type of R objects

# am takes two values and is a factor
table(quality$am)
quality$am<- as.factor(quality$am)
str(quality)
# write your answer to whether you need a dummy variable here: 
# Ans)Yes a dummy variable is needed.

################################################################################
# Q2.	Run descriptive statistics
################################################################################

# Descriptive stats for continuous variables: mean, median, min, max, sd
# defect
summary(quality$defect)
sd(quality$defect)

# temp
summary(quality$temp)
sd(quality$temp)

# density
summary(quality$density)
sd(quality$density)

# rate
summary(quality$rate)
sd(quality$rate)

# descriptive stats for categorical variable: frequency distribution

# am
table(quality$am)


################################################################################
# Q3.	Identify a dependent variable
################################################################################
# Hint: in total, there will be one dependent and 4 independent variables

# write your dependent variable here: 
# Ans) Average number of defects per 1000 produced is the dependent variable.

################################################################################
# Q4.	Generate a scatter plot with a line. 
# Interpret the relationships between other variables and the dependent variable. 
# What “obvious conclusions” can you draw?
################################################################################

# scatter plot using ggplot() for all independent variables and the dependent variable
# make sure you use bar chart for the categorical variable am

# independent variable 1 and dependent variable
#1)temperature as independent variable and average number of defects as dependent variable
ggplot(quality, mapping = aes(x=temp, y=defect)) + geom_point() + geom_smooth(method = "lm",se = FALSE, colour = "pink1") + ggtitle("Impact of temperature on number of defects") + xlab("temperature") +ylab("average number of defects")

# independent variable 2 and dependent variable
#2)density as independent variable and average number of defects as dependent variable
ggplot(quality, mapping = aes(x=density, y=defect)) + geom_point() + geom_smooth(method = "lm",se = FALSE, colour = "pink1") + ggtitle("Impact of density on number of defects") + xlab("density") +ylab("average number of defects")

# independent variable 3 and dependent variable
#3)rate of production as independent variable and average number of defects as dependent variable
ggplot(quality, mapping = aes(x=rate, y=defect)) + geom_point() + geom_smooth(method = "lm",se = FALSE, colour = "pink1") + ggtitle("Impact of rate of production on number of defects") + xlab("rate of production") +ylab("average number of defects")

# independent variable 4 and dependent variable
#4)am as independent variable and average number of defects as dependent variable
ggplot(quality, mapping = aes(x=am, y=defect)) + geom_point() + geom_smooth(method = "lm",se = FALSE, colour = "pink1") + ggtitle("Impact of am on number of defects") + xlab("am") +ylab("average number of defects")

ggplot(quality,aes(x=am, y=defect, fill = am)) + geom_bar(stat="identity") + ggtitle("Impact of am on number of defects") + xlab("am") +ylab("average number of defects")

# write your conclusions here (1 line for each pair of independent and dependent variable)
# Ans) 1)As temperature(independent variable) increases, average number of defects per 1000 produced(dependent variable) also increases. 
#      2)As density(independent variable) increases, average number of defects per 1000 produced(dependent variable) decreases.
#      3)As the rate of production(independent variable) increases, average number of defects per 1000 produced(dependent variable) also increases.
#      4)The average number of defects per 1000 produced(dependent variable) is more in the morning compared to afternoon.

################################################################################
# Q5.	Predict defect from each of the predictor variables separately, 
# e.g., defect from temp, defect from density, defect from rate, etc. 
# Which of the predictors are significant in the simple linear regressions?
################################################################################
# The impact of independent variable 1 on the dependent variable;

# X is temperature
# Y is average number of defects per 1000 produced

reg1 <- lm( defect ~ temp, data = quality)

summary(reg1)

# p-value: a: p<0.05; b: p<0.05 reject null hypothesis as significant relation exits
# coefficients: a = -40.966, b = 30.915 
# R square: 85.83% of number of defects produced is explained by temperature
# f-stats: 176.6>1

# Final interpretation (1 sentence in simple English)
# Ans) For every 1 unit increase in temperature, the average number of defects produced will increase by 30.915 units.
################################################################################
# The impact of independent variable 2 on the dependent variable;

# X is density
# Y is average number of defects per 1000 produced

reg2 <- lm(defect ~ density, data = quality)

summary(reg2)

# p-value: a: p<0.05; b: p<0.05 reject null hypothesis as significant relation exits
# coefficients: a = 161.979, b = -5.333 as density increases, average number of defects per 1000 produced decreases
# R square: 84.73% of rate of production is explained by density
# f-stats: 162>1

# Final interpretation (1 sentence in simple English)
# Ans) For every 1 unit increase in density the average number of defects produced goes down by 5.333 units.
################################################################################

# The impact of independent variable 3 on the dependent variable;

# X is rate of production
# Y is average number of defects per 1000 produced

reg3 <- lm( defect ~ rate, data = quality)

summary(reg3)

# p-value: a: p<0.05; b: p<0.05 reject null hypothesis as significant relation exits
# coefficients: a = -128.90616, b = 0.65977 
# R square: 77.61% of rate of production is explained by the average number of defects
# f-stats: 101.5>1

# Final interpretation (1 sentence in simple English)
# Ans) For every 1 unit increase in rate of production, the average number of defects produced will increase by 0.65977 units.
################################################################################
##                       Dummy variable regression
################################################################################
# Q6.	“Interestingly, many of the workers on the morning shift think that 
# the problem is “those inexperienced workers in the afternoon,” who, curiously, 
# feel the same way about the morning workers.” 
# Do you think the claim by morning shift workers is true?
################################################################################
# The impact of independent variable 4 on the dependent variable;

# X is am
# Y is average number of defects per 1000 produced

table(quality$am)

reg4 <- lm( defect ~ am, data = quality)

summary(reg4)

# p-value: a: p<0.05; b: p<0.05
# coefficients: a = 0 = afternoon = 16.920, b = 1 = morning = +20.440
# R square: 26.12% of rate of production is explained by am
# f-stats: 11.25>1

# Final interpretation (1 sentence in simple English)
# Ans) The average number of defects produced by workers working during the morning is more compared to afternoon.
#      Hence the claim by morning workers is false.

################################################################################
# Q7. How would you present your findings to your manager Ole?
# Hint: Rate is the only variable that the manager can control. 
# type your answer below (1-2 sentences)

# Ans) It has been observed from the graph between rate of production and defects that for every 25 units increase in 
#      rate of production after reaching 200 units the average number of defects increase by around 20 units. 
#      Hence the number of defects produced can be kept to close to none by maintaining the production rate close to 200 units. 
#      In this way manager ole can maintain high production rate with low cost and less number of defects.

################################################################################

