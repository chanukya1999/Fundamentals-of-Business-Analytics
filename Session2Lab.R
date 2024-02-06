#*******************************************************************************
#**********************Session 2 Lab********************************************
#*******************************************************************************

# this is Lab Session 2
# in this session, we will focus on a package called DPLYR
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
# Now we will move to data manipulation using DPLYR

################################################################################

################################################################################

# In this R script we will cover
# 1 Data types
# 2.Five functions of DPLYR + group_by()
# 3.Joins using DPLYR (we will cover this in the next class)

################################################################################

################################################################################
#                            Data types
################################################################################
install.packages("dplyr") 
library(dplyr)

# set your working directory
# use setwd to set your working directory

# you can also go to session-> set working directory -> choose directory
# working directory is the path to the folder and not file

# make sure the path of the directory is correct, i.e., where you have stored your data

setwd("~/Google Drive/MGT 585/class material/S2-Data transformation/data")

# read the movies file using read.csv

movie <- read.csv(file = "movies.csv")

# first step
# know your data

dim(movie)

colnames(movie)

str(movie) # note the column names are either char, num or int

head(movie)

tail(movie)

# No logical, factor, date columns

# Now, title_type column takes only three values: Documentary, Feature Film and TV movie

# How do you know this- domain knowledge

# you can verify the different values in the column using table()

table(movie$title_type)

# To convert a data type into factor, use as.factor()

movie$title_type<- as.factor(movie$title_type)

str(movie)

# working with date, use as.Date() to tell R that an object is date

as.Date("2020-09-07")

as.Date("09/07/2020","%m/%d/%Y")

#***************************EXERCISE 1******************************************

# Now your turn, 

# Ques 1) Convert genre column as a factor
# type your answer below this

table(movie$genre)

movie$genre<- as.factor(movie$genre)

# Ques 2) Use as.Date() to tell R that 01/01/2021 is a date
# type your answer below this

as.Date("01/01/2021","%m/%d/%Y")

################################################################################

# know if there are any missing values

is.na(movie$director)

table(is.na(movie$director))

# create vectors using c(), to create a data structure of same data types

v <- c(0.5, 0.6) 

# create lists using list(). to create a data structure of different data types

l <- list("s", "Hello", TRUE, 53,1.5)

################################################################################
#                            Five Functions of DPLYR
################################################################################

#******************************SELECT*******************************************

# from movie dataset, select column title 

select(movie,title)

# select columns from title to mpaa_rating

select(movie,title:mpaa_rating)

# select all columns except those from title to mpaa_rating

select(movie,-(title:mpaa_rating))

# from dataset movie, select columns that start with "dvd"

select(movie, starts_with("dvd"))

# from dataset movie, select columns that end with "rating"

select(movie, ends_with("rating"))

# from dataset movie, select columns that contain "imdb"

select(movie, contains("imdb"))

#*********************************FILTER****************************************

# logical operators: AND and OR

# AND operator: all rows with movies released after 2008 with imdb_rating larger than 8

filter(movie, thtr_rel_year > 2008 & movie$imdb_rating > 8)

# OR operator: we want the information on movies who have been released in 2012 or 2013

filter(movie, thtr_rel_year == 2012 | thtr_rel_year == 2013)

# is.na()

# show movies that have missing studio information

filter(movie, is.na(studio))

#********************************Exercise 2*************************************

# Ques 1) Find all movies that star "Al Pacino" in first actor 
# Hint: column name is actor1
# write your answer below this line

filter(movie, actor1 == "Al Pacino")

# Ques 2) Extract all the information on movies who have imdb_rating larger than 7,
# but did not catch critic's attention, i.e., critics_score less than 40
# Hint: use & operator
# write your answer below this line

filter(movie, imdb_rating > 7 & critics_score < 40)

# These are the movies who got people's attention but not critics

# Ques 3) Extract all the information on the movie "The Bay"
# Hint: column name is title
# write your answer below this line

filter(movie, title == "The Bay")

#**********************************ARRANGE**************************************

# arrange movies by imdb rating, 
# by default R will arrange the columns in ascending order

arrange(movie, imdb_rating)

# arrange movies by imdb rating descending 

arrange(movie, desc(imdb_rating))

arrange(movie, -(imdb_rating))

# are the result from above two queries identical?

identical(arrange(movie, -(imdb_rating)),arrange(movie, desc(imdb_rating)))

# which movies have the shortest runtime? Which have the longest?

#shortest:
arrange(movie,runtime)

#longest:
arrange (movie,-runtime)

#***************Combining Multiple Operations with the Pipe*********************

# we can combine multiple operations with %>% operator.

movie %>% filter(imdb_rating >= 8) %>% select(title,imdb_rating) %>% 
  arrange(-imdb_rating)

# show the title and studio of movies who were released in year 2000

movie %>% filter(thtr_rel_year == 2000) %>% select(title,studio) 

#******************************MUTATE*******************************************

# create new variable, called thtr_to_dvd that 
# shows how many years after theater release(thtr_rel_year), 
# the dvd of the movie was released (dvd_rel_year)
# for simplicity, show only title, thtr_rel_year, dvd_rel_year 
# and newly created thtr_to_dvd

movie %>% mutate(thtr_to_dvd = dvd_rel_year - thtr_rel_year) %>% 
  select(title,thtr_rel_year,dvd_rel_year,thtr_to_dvd)

# create a new variable with ifelse statement

# ifelse(condition, value if TRUE, value if FALSE)

# create a new variable, called which_half, which gets the value of “first_half” if the theater release month (thtr_rel_month) 
# is less or equal to 6, and “second_half”  if not.
# only show the title, thtr_rel_month  and which_half

movie %>% mutate(which_half = ifelse(thtr_rel_month <= 6,"first_half","second_half")) %>% select(title,thtr_rel_month,which_half)

#***************************GROUP_BY********************************************

# in the case of group_by(), the dplyr functions automatically apply “by group”. 
# take a case that we want to create a new variable, genreNum,
# that has the number of movies in each genre. 
# In this case we can group the table by genre, 
# and get the number of lines in each group, which is done by n(). 
# That is the number of movies in each genre:

movie %>% group_by(genre) %>% mutate(genreNum = n()) %>% 
  select(title, genre, genreNum)

#*************************SUMMARIZE*********************************************

# create a new table, called month_rate, 
# that have the average of imdb_rating of movies released each month

month_rate <- movie %>%
  group_by(thtr_rel_month) %>%
  summarize(
    avg_rating = mean(imdb_rating)
  )

month_rate

# movies released in December have higher rating average!

# Create a new table, called year_MaxRate, 
# that has the maximum imdb_rating of movies released in each year

year_MaxRate <- movie %>%
  group_by(thtr_rel_year) %>%
  summarize(
    max_rate = max(imdb_rating)
  )

year_MaxRate

# create a new table, called genre_num, that have the number of movies in each genre

genre_num <- movie %>%
  group_by(genre) %>%
  summarize(
    genreNum = n()
  ) 

genre_num

# majority of movies are in Drama genre, only 9 in science fiction and animation

# create a new table, called total number of imdb votes(imdb_num_votes) within each genre

genre_total_vote <- movie %>%
  group_by(genre) %>%
  summarize(
    voteNum = sum(imdb_num_votes)
  )

genre_total_vote

# create a new table, called genre_total_vote
# that calculates total number of imdb votes(imdb_num_votes) within each genre

genre_total_vote <- movie %>%
  group_by(genre) %>%
  summarize(
    voteNum = sum(imdb_num_votes)
  )
genre_total_vote

# create a new table, called studio_num_year
# that has total number of distinct studios producing movies in each year
# arrange the table by studiNum, which is the number of distinct studios producing
# movies in each year

studio_num_year <- movie %>%
  group_by(thtr_rel_year) %>%
  summarize(
    studiNum = n_distinct(studio)
  ) %>% arrange(studiNum)

studio_num_year

#********************************Exercise 3*************************************

# for all these questions, use pipe(%>%) when there is a need to use multiple dplyr functions

# Ques 1) From table movie, of all the movies who won best picture(best_pic_win)
# show the title and release date (thtr_rel_year)

movie %>% filter(best_pic_win == "yes") %>% select(title,thtr_rel_year)

# Ques 2) From table movie, show the title, director, 
# first(actor1) and second actor(actor2) of movies directed by "Richard Pearce"

movie %>% filter(director == "Richard Pearce") %>% select(title,director,actor1,actor2)


# Ques 3) From table movie, show the title, 
# imdb rating(imdb_rating) and imdb number of votes(imdb_num_votes), 
# arrange form highest imdb_num_votes to lowest imdb_num_votes

movie %>% select(title,imdb_rating,imdb_num_votes) %>% arrange(-imdb_num_votes)

################################################################################
# To rewind this is what we have covered in this lab session

# 1 Data types esp. factor and date
# 2.DPLYR functions like filter(), select(), arrange(), mutate() and summarise() with group_by()

################################################################################

