#*******************************************************************************
#**********************Session 3.2 Lab********************************************
#*******************************************************************************

library(dplyr)

# this is Lab Session 3.2
# in this part, we will focus on descriptive statistics
# once you establish the objective and questions you want to answer,
# after tidying your data, you can start analyzing the data

# we will start with descriptive statistics and move to predictive statistics in
# the later classes

# I have included a description of each function with the code
# you can also make your notes (comments) on each function as I explain them
# to add a note as a comment, start the statement with # sign

## control+Enter to run on PC
## command+Enter to run on MAC

################################################################################

# So far we have looked at basic functions in R, R objects and DPLYR for manipulation

################################################################################

################################################################################

# In this R script we will cover
# 1.Frequency distribution for categorical variables like nominal and ordinal (factor in R)
# 2 Mean, median, range, sd for continuous variables such as interval and ratio 
# variables (numeric or integer in R)

################################################################################

# we will use inbuilt data set called iris for this class
# first step
# know your data

dim(iris)

colnames(iris)

str(iris) # note the column names are either char, num or int

head(iris)

tail(iris)

################################################################################
#                            Frequency distribution using table()
################################################################################

# Species is a factor

# Factors in R can be nominal or ordinal variables
# Factors are categorical

# You can run frequency distribution on factor variables

# use table() to calculate frequency of each category of Species

table(iris$Species)

################################################################################
#                            Summary Statistics using summary()
################################################################################

# Now, the other four columns are continuous
# continuous variables can be of interval or ratio
# in R, continuous variables are either integer or numeric

# summary() gives you mean, median, min, max and 1st and 3rd quantiles
summary(iris$Sepal.Length)

# sd() gives you standard deviation
sd(iris$Sepal.Length)


################################################################################
# using DPLYR you can do this in one statement
################################################################################
library(dplyr)

iris %>% summarise(mean=mean(Sepal.Length), sd=sd(Sepal.Length), min=min(Sepal.Length), max=max(Sepal.Length))

# you can also get summaries by Species (factor) using group_by()
# if you still have doubts on group_by(), please note this command
# and compare its output with the previous command

iris %>% group_by(Species) %>% summarise(mean=mean(Sepal.Length), sd=sd(Sepal.Length), min=min(Sepal.Length), max=max(Sepal.Length))

################################################################################
# Exercise 1 calculate summary statistics for Sepal.Width, Petal.Length and Petal.Width
################################################################################
# summary statistics for Sepal.Width
# type your answer below this line

iris %>% group_by(Species) %>% summarise(mean=mean(Sepal.Width), sd=sd(Sepal.Width), min=min(Sepal.Width), max=max(Sepal.Width))


################################################################################
# summary statistics for Petal.Length
# type your answer below this line

iris %>% group_by(Species) %>% summarise(mean=mean(Petal.Length), sd=sd(Petal.Length), min=min(Petal.Length), max=max(Petal.Length))


################################################################################
# summary statistics for Petal.Width
# type your answer below this line

iris %>% group_by(Species) %>% summarise(mean=mean(Petal.Width), sd=sd(Petal.Width), min=min(Petal.Width), max=max(Petal.Width))


################################################################################
##                              Black Friday Sale caselet                     ## 
################################################################################

# Caselet: Mary, Joe and Fred are a family. They are planning for black friday
# sale and want to know how much do they have in savings. Look at the table
# below and answer the questions that follow:
#   Sno Name Savings Gender
#     1 Joe   100     Male
#     2 Fred  120     Male
#     3 Mary  130    Female

# 1. Create a table called savings.

# you can use data.frame() to create new data frames
# see how I have defined columns such as Sno, Name, Savings and Gender
# also, observe how I have defined rows using c() for creating vectors

family <- x <- data.frame("Sno" = 1:3, "Name" = c("Joe","Fred","Mary"), 
                          "Savings" = c(100,120,130), "Gender" = c("M","M","F"))

################################################################################
# 2. Calculate their average savings. The average savings is the sum of all the
# savings by Joe, Fred and Mary divided by number of observation which is 3.
# The answer is 116.7

# You will require knowledge of both DPLYR package and summary()

# you can use summary()

summary(family$Savings)

# or DPLYR package

family %>% summarize(savings=mean(Savings))

################################################################################
# 3. Calculate their mean savings by gender.
# type your answer below this line, use DPLYR package

family %>% group_by(Gender) %>% summarize(savings=mean(Savings))

################################################################################
# 4. Calculate their mean savings by gender and display only that gender
# whose mean of savings is greater than 120
# type your answer below this line, use DPLYR package

family %>% group_by(Gender) %>% summarize(savings=mean(Savings)) %>% filter(savings>120)

################################################################################