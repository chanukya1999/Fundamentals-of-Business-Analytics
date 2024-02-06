#*******************************************************************************
#**********************Session 4 Lab********************************************
#*******************************************************************************

# this is Lab Session 4
# in this session, we will focus on a package called GGPLOT2
# GGPLOT2 is short for Grammar of Graphics and has important functions that can help
# you create elegant data visualizations for your analysis

# I have included a description of each function with the code
# you can also make your notes (comments) on each function as I explain them
# to add a note as a comment, start the statement with # sign

# install ggplot2 package, required only once

## control+Enter to run on PC
## command+Enter to run on MAC

################################################################################

# So far we have looked at basic functions in R, exploring dataset, DPLYR
# and descriptive statistics
# Now we will move to visualization of data using ggplot2

################################################################################

################################################################################

# In this R script we will cover

# 1 Data visualization using ggplot2
# 2.Univariate visualizations (box plots, histograms)
# 3.Bivariate visualizations (scatter plots, bar graphs, stacked bar graphs, line charts)

################################################################################

# install and load the package ggplot2

install.packages("ggplot2")
library(ggplot2)
library(dplyr)

# set the working directory using setwd() and read the table we are going to work with

setwd("Google Drive/MGT 585/class material/S4-Visualization/data/")
gm <- read.csv(file = "gapminder.csv")

# like usual, explore the data using 5 functions

dim(gm)

str(gm)

colnames(gm)

head(gm)

tail(gm)

# what do we know about the data

# we have 1704 observations and six variables:
# 
# country: a categorical variable with 142 countries
# continent: a categorical variable with 5 continents
# year: going from 1952 to 2007 in increments of 5 years
# pop: population
# gdpPercap: GDP per capita
# lifeExp: life expectancy

# Correct the type of R objects

# Continent is a factor
table(gm$continent)
gm$continent<- as.factor(gm$continent)

################################################################################
##                               GGPLOT
################################################################################

# What information do you need to plot a graph
# 1. Data frame (data)
# 2. Variable (column name) that should be plotted on x axis
# 3. Variable (column name) that should be plotted on y axis
# 4. Graph type (boxplot, histogram, scatter plot, bar plot, line plot)

# Steps for using ggplot()
# 1. The first argument of ggplot is a data frame to use in the graph
# 2. The second argument of the ggplot() is a function called  aes() which 
#    specifies x and y coordinates of the graph, aes stands for aesthetics
# 3. You can add a layer to ggplot() to tell R which plot you want
#    (we will cover different types of plots in detail in this R script)
#    geom_point() for scatter plot
#    geom_bar() for bar plots

# GGPLOT template
# ggplot(data = <data frame>, aes(y= <y axis>, x = <x axis>)) + geom_function_type()
################################################################################
################################################################################

### We will start with univariate visualization (one variable or one column)

################################################################################
#                             (1) Boxplot using geom_boxplot()
################################################################################
# Boxplots are used to see key descriptive statistics of a variable
# Plot a boxplot for a variable lifeExp
# In ggplot plot, we specify name of the data frame
# in aes(), we specify the name of the variable
# for boxplot add a layer to ggplot() using geom_boxplot()

ggplot(gm, aes(y = lifeExp)) + geom_boxplot()

ggplot(gm, aes(x = continent, y = lifeExp)) + geom_boxplot()

################################################################################
#                             (2) Histogram using geom_histogram()
################################################################################
# Histograms are used to see distribution of a variable
# In ggplot plot, we specify name of the data frame
# in aes(), we specify the name of the variable
# for histogram add a layer to ggplot() using geom_histogram()

# Plot a histogram for a variable gdpPercap

ggplot(gm, aes(x = gdpPercap)) + geom_histogram()

# use bins argument to specify number of bins

ggplot(gm, aes(x = gdpPercap)) + geom_histogram(bins=1000)

################################################################################
#                              (3) Bar plot using geom_bar()
################################################################################
# Bar plots can also be used to see distribution of a categorical variable (factor)
# Bar charts for one variable
# Plot a bar plot for the variable continent
# In ggplot plot, we specify name of the data frame
# in aes(), we specify the name of the variable (factor)
# for bar plot add a layer to ggplot() using geom_bar()

# Let’s look at the number of countries in each continent

ggplot(gm, aes(x=continent)) + geom_bar()

################################################################################
# We will now look at  bivariate visualization (two variables or two columns)
# bar charts for two variables

# Bar graph is used to show a comparison among different items, 
# or it can show a comparison of items over time, especially when you have few categories

# In case of bar plots with two variables,
# in aes(), we specify the name of the two variables, what should be the x-axis and y-axis

# we want a bar chart to display the GDP per capita between years 1952 to 2007 (because we want few categories)

ggplot(gm,aes(x=year, y=gdpPercap)) + geom_bar(stat="identity")

# we want a bar chart to display the GDP per capita in Argentina between years 1952 to 2007

# for the country Argentina, what is gdp per capita per year

gm2 <- gm %>% filter(country == "Argentina")
ggplot(gm2,aes(x=year, y=gdpPercap)) + geom_bar(stat="identity")

# or you could do it in one go using pipe operator

gm %>% filter(country == "Argentina") %>% ggplot(aes(x=year, y=gdpPercap)) + geom_bar(stat="identity")

# Add color to your life :)

ggplot(gm2,aes(x = year, y = gdpPercap)) + geom_bar(stat = "identity", fill="green", colour="black")
ggplot(gm2,aes(x = year, y = gdpPercap)) + geom_bar(stat = "identity", fill="pink1", colour="black" )

# Stacked

# Stacked bar graph: This should be used to compare many different items and 
# show the composition of each item being compared.

# use fill argument to create stacked bar charts

# Let's try to see population by country

ggplot(gm, aes(y=pop, x=year, fill=country)) + 
  geom_bar(stat="identity")

# Not very pretty
# Let's change the scope of the dataset to continent instead of country
# When we want to change the scope of the data frame, we use group_by() from DPLYR
# group_by() is often used with summarise()

# In the next statement, I have calculated the total poplation by continent, using group_by and summarise
# because we want information by year, we will also include year in the group_by()
# we are using filter() to select year > 1990

gm3 <- gm %>% 
  filter(year > 1990) %>%
  group_by(year, continent) %>%
  summarise(totalPop = sum(as.double(pop)))

head(gm3)

ggplot(gm3, aes(y=totalPop, x=year,fill=continent)) + 
  geom_bar(stat="identity")

# Grouped bar chart using position="dodge"

ggplot(gm3, aes(y=totalPop, x=year,fill=continent)) + 
  geom_bar(position="dodge", stat="identity")

################################################################################
#                             (4) Scatter plots using geom_point()
################################################################################

# A scatter plot will show the relationship between two different variables 
# or it can reveal the distribution. It should be used when there are many different data 
# points, and you want to highlight similarities in the data set. 
# This is useful when looking for outliers or for understanding the distribution of your data.

# In ggplot plot, we specify name of the data frame
# in aes(), we specify the name of the variable on x-axis and y-axis
# for scatter plot add a layer to ggplot() using geom_point()

# Let's look at the relationship of life expectancy with GDP per capita
# What is your hypothesis? I assume that the life expectancy would increase in the countries who have higher GDP
# Let's check

ggplot(gm, mapping = aes(x=gdpPercap, y=lifeExp)) + geom_point()

#Scale the x_axis, log-scale 

g6<-ggplot(gm, mapping = aes(x=gdpPercap, y=lifeExp)) + geom_point() + scale_x_log10() 
g6
# Add the trend line to your plot (regression line)

g7 <- g6 + geom_smooth(method = "lm")
g7

# change the color of the line

g9 <- g6 + geom_smooth(method = "lm",se = FALSE, colour = "pink1")
g9

################################################################################
#                              Linechart using geom_line()
################################################################################

# A line charts reveals trends or progress over time 
# and can be used to show many different categories of data. 
# You should use it when you chart a continuous data set.

# In ggplot plot, we specify name of the data frame
# in aes(), we specify the name of the variable on x-axis and y-axis
# for scatter plot add a layer to ggplot() using geom_point()

# Find a way to show the trend of life expectancy throughout the years in Argentina

gm4 <- gm %>% filter(country == "Argentina")
ggplot(gm4, aes(x=year, y=lifeExp)) + geom_line()

# Now, the trend in average of life expectancy over different years by continents	

gm5 <- gm %>% group_by(year,continent) %>% summarize(AvglifeExp = mean(lifeExp))
ggplot(gm5 , aes(x = year, y = AvglifeExp,color=continent)) + geom_line()

#*********Modifying Aesthetics*******

gm5 <-  gm %>% filter(country == "Afghanistan") 

ggplot(gm5, aes( x = year, y = lifeExp)) + geom_line()

# Modify the color of your line

ggplot(gm5, aes( x = year, y = lifeExp)) + geom_line(colour = "pink1")

# Modify the size of line:	

ggplot(gm5, aes( x = year, y = lifeExp)) + geom_line(colour = "pink1",size = 2)

# Go back to your scatter plot, we want to compare different categories by different colors in the same plot

#Original plot

ggplot(gm, mapping = aes(x=gdpPercap, y=lifeExp)) + geom_point() + scale_x_log10() 

# Compare different continents on the same plot by color

ggplot(gm, mapping = aes(x=gdpPercap, y=lifeExp, color = continent)) + geom_point() + scale_x_log10() 

################################################################################
#                             Labels
################################################################################

#Give the title of “Life expectancy if Argentina over the years” to your previous line chart

gm5 <-  gm %>% filter(country == "Argentina") 

ggplot(gm5, aes( x = year, y = lifeExp)) + geom_line() 

ggplot(gm5, aes( x = year, y = lifeExp)) + geom_line() + labs(title = "Life expectancy in Argentina over the years")

#or

ggplot(gm5, aes( x = year, y = lifeExp)) + geom_line() + ggtitle("Life expectancy in Argentina over the years")

#Change the y axis labels to “Life expectancy”

ggplot(gm5, aes( x = year, y = lifeExp)) + geom_line() + labs(title = "Life expectancy in Argentina over the years") + ylab("Life Expectancy") 

ggplot(gm5, aes( x = year, y = lifeExp)) + geom_line() + labs(title = "Life expectancy in Argentina over the years") +  ylab("Life Expectancy") + xlab("Year") 

#OR

ggplot(gm5, aes( x = year, y = lifeExp)) + geom_line() + labs(title = "Life expectancy in Argentina over the years") + labs(y = "Life Expectancy",x="Year") 

################################################################################
#                              Facets
################################################################################

# Compare different continents on the same plot by color

ggplot(gm, mapping = aes(x=gdpPercap, y=lifeExp, color = continent)) + geom_point() + scale_x_log10() 

# Now, show the different categories that we have previously showed with color, this time, on different panels

ggplot(gm, mapping = aes(x=gdpPercap, y=lifeExp)) + 
  geom_point() + 
  scale_x_log10() + 
  facet_wrap(~ continent)

#*******************FINAL PLOT********

ggplot(gm, mapping = aes(x=gdpPercap, y=lifeExp)) + 
  geom_point(alpha = 0.6, color = "blue") + 
  scale_x_log10() + 
  facet_wrap(~ continent) +
  geom_smooth(method = "lm",se = FALSE, colour = "pink1") +
  theme_bw() +
  xlab("GPD per Capita") +
  ylab("Life Expectancy") +
  ggtitle("Life expectancy in all continents over the years")

################################################################################
##                       TITANIC EXERCISE                                     ##
################################################################################

# set working directory and read titanic.csv

# read more about the data here

# survival- Survival 0 = No, 1 = Yes
# pclass- Ticket class	1 = 1st, 2 = 2nd, 3 = 3rd
# sex- 	Sex
# age- Age in years
# sibsp- # of siblings / spouses aboard the Titanic
# parch- # of parents / children aboard the Titanic
# ticket- 	Ticket number
# fare- Passenger fare
# cabin- Cabin number
# embarked- Port of Embarkation C = Cherbourg, Q = Queenstown, S = Southampton

# 1. Let's start with setting the working diretory

setwd("")

# 2. read the data into titanic object

titanic <- read.csv("titanic.csv")

# 3. explore your dataset using 5 functions: dim(), str(), colnames(), head() and tail

dim(titanic)
str(titanic)
colnames(titanic)
head(titanic)
tail(titanic)

# Write the number of rows and columns here:
# Note factor, numeric and integer columns

# 4. make sure nominal variables are factors which includes Survived, Pclass and Sex

titanic$Survived<-as.factor(titanic$Survived)
titanic$Pclass<-as.factor(titanic$Pclass)
titanic$Sex<-as.factor(titanic$Sex)

# 5. use table() to see the distribution of Survived, Pclass and Sex

table(titanic$Survived)
table(titanic$Pclass)
table(titanic$Sex)

# 6. use summary() and sd() to see the summary statistics of Fare, SibSp and Age

summary(titanic$Fare)
sd(titanic$Fare)

summary(titanic$Age)
sd(titanic$Age)

sd(!is.na(titanic$Age))

summary(titanic$SibSp)
sd(titanic$SibSp)

################################################################################

# OBJECTIVE: we will answer the question: who survived using visualization

# import ggplot

library(ggplot2)

# Q1) Does age play a role?

# Let's try to imagine how the graph should look like
# It should be a bar plot with age on the x axis
# No. of passengers who survive on the y axis
# the grouping variable (fill) is Survived

# I have created a categorical variable for you from the countuous age column
# It takes four values from 0-3
# age 0-20 are group 0
# age 21- 40 are group 1
# age 41 to 60 are group 2
# age 61 and above are group 3

titanic$age_cat<-0
titanic$age_cat[titanic$Age>20]<-1
titanic$age_cat[titanic$Age>40]<-2
titanic$age_cat[titanic$Age>60]<-3

# create a data frame with three columns using group_by and summarise()
# group_by should be on two columns of age_cat and Survived
# in the summariz() use n() to count the number of rows

titanic0 <- titanic %>% 
  group_by(age_cat,Survived) %>%
  summarise(totalSurv = n())

titanic0

# now using the new object that you just created, plot a bar graph where
# x axis is age
# y axis is number of passengers who survived
# grouping variable (fill) is Survived

ggplot(titanic0, aes(fill=as.factor(Survived), y=totalSurv, x=age_cat)) + 
  geom_bar(position="dodge", stat="identity") + xlab("Age") + ylab("No. of pax who survived") +ggtitle("Does age play a role") + labs(fill="Survived")

# You will notice that I have use more functions
# xlab() is label of x-axis
# ylab() is label of y-axis
# ggtitle() is the main title of the chart
# lab() specifies the label for the grouping variable

################################################################################

# Q2) Does gender play a role?

# Follow similar pattern as the last question, replace age_cat with Sex

titanic1 <- titanic %>% 
  group_by(Sex,Survived) %>%
  summarise(totalSurv = n())

ggplot(titanic1, aes(fill=as.factor(Survived), y=totalSurv, x=Sex)) + 
  geom_bar(position="dodge", stat="identity") + xlab("Gender") + ylab("No. of pax who survived") +ggtitle("Does gender play a role") + labs(fill="Survived")
  
################################################################################

# Q3) Does passenger’s class play a role?

# Follow similar pattern as the last question, replace age_cat with Pclass

titanic2 <- titanic %>% 
  group_by(Pclass,Survived) %>%
  summarise(totalSurv = n())
  
ggplot(titanic2, aes(fill=as.factor(Survived), y=totalSurv, x=Pclass)) + 
  geom_bar(position="dodge", stat="identity") + xlab("Pax Class") + ylab("No. of pax who survived") +ggtitle("Does pax class play a role") + labs(fill="Survived")

################################################################################

# Q4) Does number of siblings or spouse onboard play a role?

# Follow similar pattern as the last question, replace age_cat with SibSp_cat

titanic$SibSp_cat<-0
titanic$SibSp_cat[titanic$SibSp>1]<-1

titanic$SibSp_cat<-as.factor(titanic$SibSp_cat)

titanic3 <- titanic %>%
  group_by(SibSp_cat,Survived) %>%
  summarise(totalSurv = n())

ggplot(titanic3, aes(fill=as.factor(Survived), y=totalSurv, x=SibSp_cat)) + 
  geom_bar(position="dodge", stat="identity") + xlab("Sibling or spouse") + ylab("No. of pax who survived") +ggtitle("Does Sibling or Spouse onboard play a role") + labs(fill="Survived")

################################################################################

