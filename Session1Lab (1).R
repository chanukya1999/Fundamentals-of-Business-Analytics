#*******************************************************************************
#**********************Session 1 Lab********************************************
#*******************************************************************************

# this is Lab Session 1

################################################################################

# In this R script we will cover
# 1. Basics of R

################################################################################

# I have included description of each function with the code
# you can also make your notes (comments) on each function as I explain them
# to add a note as a comment, start the statement with # sign

# THIS IS A COMMENT
# OK! Let’s learn some R :)

# this is my first code

################################################################################
#                            Basics of R
################################################################################

#***********************PRINT FUNCTION******************************************

# learning any programming language begins with printing 'Hello World'
# to print a string in R, use print()
# I will always use brackets after a function, i.e., ()
# more on function later, we are just getting started
# for now, think of functions as verbs in the English language
#, i.e., they tell R to do things

print('Hello World')

# to run a code snippet, select the text and press Command + Enter for MAC 
# and CTRL + Enter for Windows
#***************************EXERCISE 1******************************************

# Now your turn, write your name between the quotes
# type your answer below this

print('') # print('Khadija')

#*******************************************************************************

#***********************DATA SET************************************************

# a data set is a collection of data organized in a tabular manner
# now, let's try to explore a data set called the iris
# iris already exists in the memory of R

# for help use question mark
# ? is used to ask for help, any word that you write after ?, R will try to help
# you with that word

?iris

# View() displays the whole table in a new window, try running it and you will 
# see a new window called the iris

View(iris) 

# take some time to eyeball the data

# use dim() to know the number of rows and columns in the data set

dim(iris)

# use str() to see the structure of the data set

str(iris)

# use colnames() to see the column names of the table iris

colnames(iris) # iris has 5 columns

# use head() and tail() function to select first and last rows from the iris table

head(iris) # first few rows of iris
tail(iris) # last few rows of iris

#***********************OBJECTS*************************************************

# objects are used to store values in R, think of objects as nouns in English language

# assignment operator is used to assign a value to an object, see Environment window
# on your right-hand side of the screen

a <- 1

# the Environment window will show you a new object a
# you can print the value of object a

a

# you can do mathematical operations such as addition

a <- a + 1

a # it should print 2 as 1 + 1 is 2 :D

#***************************EXERCISE 2******************************************

# choose any number and assign that number to object b
# type your answer below this



# increase the value of b by 2
# type your answer below this



# multiply the result by 3
# type your answer below this



# subtract 6 from the answer
# type your answer below this



# divide what you get by 3
# type your answer below this



# print the value of b
# type your answer below this



#*******************************************************************************
#*************************Important functions in R******************************

# use hash to write a comment, R does not execute comments, they are for you to 
# understand (1) what you are trying to do OR (2) what you did
# this is a comment
# always use comments to document what you are trying to do, 
# you might want to publish the code or reuse it 6 months from now

# functions are predefined tasks, think of functions as a verb
# I will always use brackets after a function, i.e., ()

# funcname(arg1,arg2)

# arguments go into parenthesis of functions, think of arguments as adverbs that
# modify functions (verbs in R)

# round() is a function and 3.14 is argument

round(3.14)

# to list all the objects in R's Environment

ls() 

#***************************WORKING DIRECTORY***********************************

# working directory: all the input/output functions will read/write 
# files from this folder
# make sure you use forward slash, else it will throw an error!! 
# (no one likes errors, but you can fix them! more on this later)

setwd("~/Google Drive/MGT 585/class material/S1-Introduction/data") 

# got an error? use your path

setwd("") 

#******************************FILE INPUT OUTPUT********************************

# often, you would like to read data from a file or write the data to a file
# it's a two-step process to load data in R

# FIRST, set working directory (as discussed before); this is where your file is saved on your laptop
# Download bigbangtheory.csv from D2L
# bigbangtheory is a fun data set from the show Big Bang Theory,
# it contains details on the show's characters

# I saved bigbangtheory.csv in a folder with the path below
# ~/Google Drive/MGT 585/class material/S1/data

# on Windows, this path may look like this
# C:/Users/fks1053/Desktop/Data management courseoutline/R code
# make sure you use correct slash

# type your path here: 

setwd("~/Google Drive/MGT 585/class material/S1/data") # use your path here

# Now, the file you downloaded from D2L is a csv file
# it is preferred you use a csv

# SECOND, assign the data to a new object using read.csv() function; 
# I set the option header=TRUE because we have names of columns as our first row
# remember it's a dumb machine, and you need to tell it everything

bbt <- read.csv("bigbangtheory.csv", header=TRUE)

# type ?read.csv if you are still unclear about what it does

# now you have bbt as a new object

ls()

# you can use bbt just the way you used iris
# you can see your data, always use dim(), str(), head(), tail() and colnames() to understand that data

# dim() outputs the number of rows followed by the number of columns in a data frame

dim(bbt) # 7 rows and 5 columns

# str() shows the structure of the data

str(bbt) 

# print column names

colnames(bbt)

# print first and last few rows

head(bbt)
tail(bbt)

# note bbt is an object of a type data frame; tables are stored as data frames in R 
# data frames are handy in doing transformations

# $ sign is used to access a column of a data frame

bbt$name

# to write to a csv file

write.csv(bbt,file="bigbangtheory2.csv")

#*********************************INDEXING**************************************

# now, let's focus a little on indexing
# what is indexing?
# we often wish to examine a part of a data set
# indexing is used to access a part of a data set
# it can be a column
# it can be a row
# it can be a few columns or rows
# or it can a cell/ value that you need to access

# let's continue with bigbangtheory data frame

# print value in the first row, second column

bbt[1,2] # Sheldon

# name[row,column]

# print first column

bbt[,1]

# print first row

bbt[1,]

# you can also specify a condition choose which rows you want to display

bbt[bbt$name=='Sheldon',]

# Now your turn

#***************************EXERCISE 3******************************************

# Question 1: Display names of the characters

# type your answer below this



################################################################################

# Question 2: Display all the details about Howard

# type your answer below this



################################################################################

# Question 3: Display details of all the male characters

# type your answer below this



################################################################################

# Question 4: Display all the data related to bbt characters who are Physicist

# type your answer below this



################################################################################

#*******************************INSTALLING PACKAGES*****************************

# using a package is a two-step process
# FIRST, install the package using install.packages(), needs to be done only once

install.packages("tidyverse") # this may take a while and a lot of printing

# installing packages should be done only once at the beginning when you are 
# using the package for the first time

install.packages("tidyr")

# another way of installing a package is to go to the 'Packages' in lower right 
# window and click install, then input the package name
# to install tidyr package, this is the package we will use for the first few classes

# SECOND, use library() to tell R that you will use the package in this session
# once you have installed a package, you need to tell R you are going to use the 
# functions of the package. For that, use library() function

library(tidyverse)
library(tidyr)

# to remove a package that is already installed

#*****DO NOT RUN*****

remove.packages("tidyr")

#**************************End of Session 1 Lab*********************************