#*******************************************************************************
#**********************Session 3.1 Lab********************************************
#*******************************************************************************

# this is Lab Session 3.1
# in this session, joins using DPLYR
# DPLYR is used for data manipulation and has important functions that can help
# you clean and prepare the data before you begin your analysis

# I have included a description of each function with the code
# you can also make your notes (comments) on each function as I explain them
# to add a note as a comment, start the statement with # sign

# install dplyr package, required only once.

## control+Enter to run on PC
## command+Enter to run on MAC

################################################################################

# So far we have looked at basic functions in R
# Now we will move to data manipulation using DPLYR (this is what we completed last week)
# 1 Data types
# 2.Five functions of DPLYR + group_by()

################################################################################

################################################################################

# In this R script we will cover
# 3.Joins using DPLYR () 
# this is a part of data tidying and transformation

################################################################################

install.packages("dplyr") 
library(dplyr)

# set your working directory
# use setwd to set your working directory

# you can also go to session-> set working directory -> choose directory
# working directory is the path to the folder and not file

# make sure the path of the directory is correct, i.e., where you have stored your data

setwd("~/Google Drive/MGT 585/class material/S2-Data transformation/data")

################################################################################
#                                  JOINS using DPLYR
################################################################################

one <- read.csv("one.csv", header=TRUE)
two <- read.csv("two.csv", header= TRUE)

dim(one)
str(one)
head(one)

# no nead for tail()

dim(two)
str(two)
head(two)

one
two

# You can do inner join on two tables using inner_join()

inner<- inner_join(one, two, by="id")
inner

# To do left join, use left_join()
# Left join will keep all the rows of left table and merge matching rows of the right table

left <- left_join(one, two, by="id")
left

# To do right join, use right_join()

right <- right_join(one, two, by="id")
right

# To do full join, use full_join()

full <- full_join(one, two, by="id")
full

#********************************Exercise 1*************************************

# This is an exercise on merge

# Data:

# employee_address contains employee name, country, and city data.
# employee_pay contains employee's salary information.
# Both employee_address and employee_pay contain Employee_ID.
# Names are stored in the Employee_Name column as Last, First. 

# **********************set your working directory******************************
# use setwd to set your working directory

# you can also go to session-> set working directory -> choose directory
# working directory is the path to the folder and not file

# read both the tables in R and assign them to an object
# assign the table  employee_address data to object called employee_address
# assign the table employee_pay data to object employee_payroll

# type your answer below this

setwd("~/Google Drive/MGT 585/class material/S2-Data transformation/data")
employee_address<-read.csv("employee_address.csv", header=TRUE)
employee_payroll<-read.csv("employee_pay.csv", header=TRUE)

# know your dataset with 5 functions

# type your answer below this

# first, work on employee_address

dim(employee_address)
str(employee_address)
colnames(employee_address)
head(employee_address)
tail(employee_address)

# next, work on employee_payroll

dim(employee_payroll)
str(employee_payroll)
colnames(employee_payroll)
head(employee_payroll)
tail(employee_payroll)

# Your manager has asked you for following report
# Name, city, and salary of all Australian employees

# Here is a sketch of the desired report:

# Name                       City                   Salary
# Last, First                City Name                  1

# step 1

# merge employee_address and employee_payroll on Employee_ID
# decide which join will you use: inner, outer, left or right

# type your answer below this

address_payroll_inner <- employee_address %>% inner_join(employee_payroll, by="Employee_ID")
address_payroll_left <- employee_address %>% left_join(employee_payroll, by="Employee_ID")
address_payroll_right <- employee_address %>% right_join(employee_payroll, by="Employee_ID")
address_payroll_full <- employee_address %>% full_join(employee_payroll, by="Employee_ID")

# this was a trick question, you can do any join, the output data frame will be the same
# this is because there is 1:1 mapping between Employee ID in employee_payroll
# to the Employee ID in employee_address!!! i.e., both has unique 424 rows (see Environment window)

# step 2
# after merging, using pipe or OR operator filter your results to show
# only those employees who are from AU or au

# type your answer below this

address_payroll_left %>% filter(Country =='AU' | Country=='au') %>% select(Employee_Name, City,Salary)

# you can also do it in one step (one of the benefits of pipe operator; %>% is called pipe operator)

employee_address %>% left_join(employee_payroll, by="Employee_ID") %>% filter(Country =='AU' | Country=='au') %>% select(Employee_Name, City,Salary)

################################################################################
# To rewind this is what we have covered in this lab session

# 1 R objects esp. factor and date
# 2.DPLYR functions like filter(), select(), arrange(), mutate() and summarise() with group_by()
# 3.Different joins using DPLYR, i.e., inner_join(), left_join(), right_join() and full_join() 

################################################################################

