#*******************************************************************************
#**********************Session 6 Lab********************************************
#*******************************************************************************

# this is Lab Session 6
# in this session, we will focus on predictive analytics -> supervised learning -> regression
# Predictive analytics is focused on predicting future from the past data
# Supervised learning is when we know X (independent variable) and Y (dependent variable) both
# Regression is used when you are trying to find relationship between two variables

# I have included a description of each function with the code
# you can also make your notes (comments) on each function as I explain them
# to add a note as a comment, start the statement with # sign

## control+Enter to run on PC
## command+Enter to run on MAC

################################################################################

# So far we have looked at basic functions in R, exploring dataset, DPLYR
# and descriptive statistics, visualization
# Now we will move to regression in R

################################################################################

################################################################################

# In this R script we will cover

# 1 Regression using lm()
# 2.Interpreting the regression results: p-value, coefficients, R square, f-stats
# 3.Interpreting the regression when X is continuous vs. categorical
################################################################################

# we are going to work with ABC grape juice data

################################################################################
#                                       Caselet
################################################################################
# A fabricate company, ABC store chain, is selling a new type of grape juice in 
# some of its stores for pilot testing 
# The manager of ABC wants to analyze the impact of the new product launch:-
# The analyst has randomly sampled 30 observations and constructed the following
# dataset for the analysis. There are 5 variables (columns) in the dataset.
################################################################################

#first things first, lets call our packages

library(ggplot2)

# set the working directory using setwd() and 

setwd("~/Google Drive/MGT 585/class material/S6-Supervised Learning Part 1 Regression/data")

# read the data grape_juice.csv
grape_juice <- read.csv(file = "grape_juice.csv")

################################################################################
#                                 Variable	Description 
################################################################################
# Sales:	Total unit sales of the grape juice in one week in a store
# Price:	Average unit price of the grape juice in the week
# ad_type:	The in-store advertisement type to promote the grape juice.
#   ad_type = 0,  the theme of the ad is natural production of the juice
#   ad_type = 1,  the theme of the ad is family health caring
# price_apple:	Average unit price of the apple juice in the same store in the week
# price_cookies:	Average unit price of the cookies in the same store in the week

################################################################################

# like usual, explore the data using 5 functions

dim(grape_juice)

str(grape_juice)

colnames(grape_juice)

head(grape_juice)

tail(grape_juice)

# what do we know about the data

# we have 30 observations and 5 variables:
# 
# sales : a continuous variable and in units
# price: a continuous variable and in $
# ad_type: a categorical variable with 0 = natural and 1 = family health
# price_apple: price of competing product - apple juice in $
# price_cookies: price of complementary product - cookies in $

# Correct the type of R objects

# ad_type takes two values and is a factor
table(grape_juice$ad_type)
grape_juice$ad_type<- as.factor(grape_juice$ad_type)

################################################################################
##                               Descriptive Statistics
################################################################################

# Descriptive stats for continuous variables: mean, median, min, max, sd
# sales

summary(grape_juice$sales)
sd(grape_juice$sales)

# price

summary(grape_juice$price)
sd(grape_juice$price)

# price_apple

summary(grape_juice$price_apple)
sd(grape_juice$price_apple)

# price_cookies

summary(grape_juice$price_cookies)
sd(grape_juice$price_cookies)

# descriptive stats for categorical variable: frequency distribution
# ad_type

table(grape_juice$ad_type)

################################################################################
##                               Regression
################################################################################

# What information do need to run regression
# 1. Data frame (data)
# 2. X variable (column name) is the independent variable, impacting variable
# 3. Y variable (column name) is the dependent variable, impacted variable
# 4. lm() is used to run the regression models and is abbreviation for linear model (straight line)

# Steps for using lm()
# 1. The first argument of lm() is the model: Y ~ X
# ~ operator is called tilde (~) and connects Y to X
# 2. The second argument of the lm() is the data frame

# lm() template
# lm(Y ~ X, data= <dataframe name>)
################################################################################
################################################################################

### We will start with X as continuous (interval or ratio) variable

################################################################################
#                             X as continuous
################################################################################
# The reactions of sales quantity of the grape juice to its price change;

# X is grape juice price
# Y is grape juice sales quantity

ggplot(grape_juice, mapping = aes(x=price, y=sales)) + geom_point() + geom_smooth(method = "lm",se = FALSE, colour = "pink1") + ggtitle("Impact of price on sales quantity") + xlab("price") +ylab("sales quantity")

reg1 <- lm(sales ~ price, data = grape_juice)

summary(reg1)

# p-value: a: p < 0.05; b: p < 0.05
# coefficients: a= 833.362; b = -63.327 as price increases, sales goes down
# R square: 71.44% of sales qty is explained by price of grape juice
# f-stats: 73.55 > 1
################################################################################
# The reactions of sales quantity of the grape juice to the price changes of 
# other products such as apple juice and cookies in the same store

# competing product: apple juice

# X is apple juice price
# Y is grape juice sales quantity

ggplot(grape_juice, mapping = aes(x=price_apple, y=sales)) + geom_point() + geom_smooth(method = "lm",se = FALSE, colour = "pink1") + ggtitle("Impact of price of apple juice on sales quantity") + xlab("price of apple juice") +ylab("sales quantity")

reg2 <- lm(sales ~ price_apple, data = grape_juice)

summary(reg2)

# p-value: a: p > 0.05, b < 0.05
# coefficients: b = 67.33
# R square: 10.57%
# f-stats: 4.428 > 1

# complementary product: cookies

# X is cookies price
# Y is grape juice sales quantity

ggplot(grape_juice, mapping = aes(x=price_cookies, y=sales)) + geom_point() + geom_smooth(method = "lm",se = FALSE, colour = "pink1") + ggtitle("Impact of price of cookies on sales quantity") + xlab("price of cookies") +ylab("sales quantity")

reg3 <- lm(sales ~ price_cookies, data = grape_juice)

summary(reg3)

# p-value: a: p < 0.05, b < 0.05
# coefficients: a = 553.71, b = -35.03
# R square= 10.89%
# f-stats= 4.544

################################################################################
#                              X as categorical: Dummy variable regression
################################################################################

# 0 = natural and 1 = family health
# Which type of in-store advertisement is more effective? 
# They have placed two types of ads in stores for testing, 
# one theme is natural production of the juice
# the other theme is family health caring;

# X is ad type
# Y is grape juice sales quantity

table(grape_juice$ad_type)

ggplot(grape_juice, mapping = aes(x=ad_type, y=sales)) + geom_point() + geom_smooth(method = "lm",se = FALSE, colour = "pink1") # wrong

ggplot(grape_juice,aes(x=ad_type, y=sales, fill = ad_type)) + geom_bar(stat="identity") + ggtitle("Impact of ad type on sales quantity") + xlab("Ad type") +ylab("sales quantity")

reg4 <- lm(sales ~ ad_type, data = grape_juice)

summary(reg4)

# p-value: a: p < 0.05, b: p < 0.05
# coefficients: a = 0 = natural grape juice = 186.67; b = 1 = +60 (family health - natural)
# R square : 31.07%
# f-stats: 14.07 > 1

################################################################################
##                       Advertising data                                     ##
################################################################################

# set working directory and read advertising.csv

# read more about the data here

# The dataset contains statistics about the sales of a product in 200 different markets,
# together with advertising budgets in each of these markets for different media channels: TV, radio and newspaper.
# The sales are in thousands of units and the budget is in thousands of dollars.


# 1. Let's start with setting the working diretory

setwd("~/Google Drive/MGT 585/class material/S6-Supervised Learning Part 1 Regression/data")

# 2. read the data into ad object

ad <- read.csv("advertising.csv")

# 3. explore your dataset using 5 functions: dim(), str(), colnames(), head() and tail

dim(ad)
str(ad)
colnames(ad)
head(ad)
tail(ad)

# Write the number of rows and columns here:
# Note factor, numeric and integer columns

# 4. use summary() and sd() to see the summary statistics of TV,	radio,	newspaper,	sales

summary(ad$TV)
sd(ad$TV)

summary(ad$radio)
sd(ad$radio)

summary(ad$newspaper)
sd(ad$newspaper)

summary(ad$sales)
sd(ad$sales)

################################################################################

# OBJECTIVE: we will answer the question: Is there a relationship between advertising budget and sales?
# if yes, by how much.

# Q1) Does advertising on TV impacts sales?

# Let's try to imagine what is our X (independent) and Y (dependent) variable
# TV impacts sales and is our X
# Sales is being impacted by TV and is our Y

# using ggplot(), plot a scatter plot for TV and Sales
# type your answer below this line

ggplot(ad, mapping = aes(x=TV, y=sales)) + geom_point() + geom_smooth(method = "lm",se = FALSE, colour = "pink1") + ggtitle("Impact of TV ad on sales") + xlab("TV ad") +ylab("sales")


# then use lm() to run a regression analysis on TV as X and sales as Y
# type your answer below this line

reg_tv <- lm(sales ~ TV, data = ad)

summary(reg_tv)

# p-value: a: p < 0.05, b: p < 0.05
# coefficients: a = 7.03, b = 0.047
# R square: 60.99%
# f-stats: 312 > 1
################################################################################

# Q2) Does advertising on radio impacts sales?

# Let's try to imagine what is our X (independent) and Y (dependent) variable
# ?? impacts sales and is our X
# Sales is being impacted by ?? and is our Y

# using ggplot(), plot a scatter plot for radio and Sales
# type your answer below this line

ggplot(ad, mapping = aes(x=radio, y=sales)) + geom_point() + geom_smooth(method = "lm",se = FALSE, colour = "pink1") + ggtitle("Impact of radio ad on sales") + xlab("radio ad") +ylab("sales")

# then use lm() to run a regression analysis on radio as X and sales as Y
# type your answer below this line

reg_radio <- lm(sales ~ radio, data = ad)

summary(reg_radio)

# p-value: a: p < 0.05, b: p < 0.05
# coefficients: a = 9.31, b = 0.20
# R square: 33.87%
# f-stats: 98.42 > 1
################################################################################

# Q3) Does advertising in newspaper impacts sales?

# Let's try to imagine what is our X (independent) and Y (dependent) variable
# ?? impacts sales and is our X
# Sales is being impacted by ?? and is our Y

# using ggplot(), plot a scatter plot for newspaper and Sales
# type your answer below this line

ggplot(ad, mapping = aes(x=newspaper, y=sales)) + geom_point() + geom_smooth(method = "lm",se = FALSE, colour = "pink1") + ggtitle("Impact of newspaper ad on sales") + xlab("newspaper ad") +ylab("sales")

# then use lm() to run a regression analysis on newspaper as X and sales as Y
# type your answer below this line

reg_newspaper <- lm(sales ~ newspaper, data = ad)

summary(reg_newspaper)

# p-value: p < 0.05,  p < 0.05
# coefficients: a = 12.35, b = 0.054
# R square: 4.73% Not very good R square as also shown by the scatter plot, the data points are far away from the regression line
# f-stats: 10.89 > 1
################################################################################
