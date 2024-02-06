################################################################################
##                          Homework Assignment 2                             ##
##                           Super Bowl Caselet 
##                         Student Name: Chanukya Bolli
################################################################################
library(dplyr)

# This script is based on the Superbowl data!!
# Use the caselet description (superbowl.docx) and data (superbowl.csv) 

# Think about the managerial implications as you go along

# The aim of this exercise is to use your knowledge on DPLYR
# I have provided hints where necessary, fill in the missing parts of the statement
################################################################################
# Read the data from the superbowl.csv
################################################################################

# set your working directory 

setwd("C:/Users/Srinivas Bolli/Documents/Assignment3")

# read.csv() to read the file

superbowl<-read.csv(file = "superbowl.csv",header=TRUE)
View(superbowl)


################################################################################
# To explore the superbowl table,
# use five functions of dim(), str(), colnames(), head() and tail()
# observe different columns of the table and the type of R objects
# type your answer below this line


dim(superbowl)

str(superbowl)

colnames(superbowl)

head(superbowl)

tail(superbowl)

################################################################################

# tell R, new_brand, month and superbowl columns are factor, fill in the missing arguments

table(superbowl$new_brand)
superbowl$new_brand<-as.factor(superbowl$new_brand)
str(superbowl)

table(superbowl$month)
superbowl$month<-as.factor(superbowl$month)
str(superbowl)

table(superbowl$superbowl)
superbowl$superbowl<-as.factor(superbowl$superbowl)
str(superbowl)

# tell R, week_of is date of format "%d-%b-%y"

superbowl$week_of<- as.Date(superbowl$week_of,"%d-%b-%y")
str(superbowl)

# you can try and experiment with different date formats here: 
# https://campus.datacamp.com/courses/intermediate-r-for-finance/dates?ex=6

################################################################################
##                          5 functions of DPLYR                              ##
################################################################################

# Query 1. Filter all rows where new_brand == 'Beetle'
# type your answer below this 

superbowl %>% filter( new_brand == 'Beetle')

# interpret the results:
# Ans) There are a total of 15 rows with the brand as beetle.
################################################################################

# Query 2.Select all the columns related to buzz metrics (volume, pos, neg)
# type your answer below this line

superbowl %>% select(volume, pos, neg)

# interpret the results:
# Ans) There are 45 rows, with 3 columns of buzz metrics of volume, pos and neg.
################################################################################

# Query 3. Arrange the adspend column in descending order and see which brand has the highest advertising spend and in which week_of
# type your answer below this line

superbowl %>% arrange(desc(adspend))

# Second way to arrange in descending order.
arrange(superbowl, -(adspend)) 

# interpret the results:
# Ans) Beetle brand has the highest adspend of 7105 spend in the week of 2012-01-30 and it has
#      lowest adspend of 0.3 in the week of 2012-03-05. Camaro has the highest adspend of 3977.6
#      in the week of 2012-01-30 and lowest adspend of 59.9 in the week of 2012-02-13. CR-Z has 
#      the highest adspend of 2.4 in the week of 2012-01-23 and CR_Z has the lowest adspend of 0.4 in the 
#      week of 2012-01-09.
################################################################################

# Query 4. Create a new column called sentiment which is a sum of positive (column name is pos) and negative (column name is neg) mentions,
# and select only three columns for display: week_of, new_brand and sentiment
# type your answer below this line
superbowl %>% mutate(sentiment = pos + neg) %>% select(week_of, new_brand, sentiment)

# interpret the results:
# Ans) Camaro has the highest sentiment value of 32988 in the week of 27-Feb-12 and CR_Z has
#      the lowest sentiment value of 92.

################################################################################
##                            Descriptive Statistics                          ##
################################################################################
# complete this section after going through the content for Session 3

# Query 5. For the brand Beetle: 

# a) Compute the mean and standard deviations for the buzz metrics (volume, pos, neg). 

beetle_summary <- superbowl %>% group_by(new_brand) %>% 
summarize(avg_volume=mean(volume),sd_volume=sd(volume), avg_pos=mean(pos), sd_pos=sd(pos), avg_neg=mean(neg), sd_neg=sd(neg)) %>% filter(new_brand=='Beetle')

beetle_summary

# Find the list of aggregate functions of summarise() here: https://rpubs.com/williamsurles/292547

# b) Calculate the average buzz volume before and after the Superbowl for the brand Beetle? 

beetle_summary_time <- superbowl %>% group_by(new_brand, superbowl) %>% 
  summarize(avg_buzz_volume = mean(volume)) %>% filter( new_brand == 'Beetle')

beetle_summary_time

# c) Interpret the result and write managerial implications.
# Ans)    The average volume, standard deviation, average pos, standard pos, average neg and standard neg
#      of the beetle brand are 4079, 1335, 884, 411, 137 and 90.9 respectively.
#         The average buzz volume before and after superbowl is 3418 and 4319 respectively, from this
#      result, I observed that advertising during the superbowl creates a significantly higher volume
#      of buzz, Hence I think the managers must decide to spend more on advertising during the superbowl
#      rather than before the superbowl, if they want to have a much more wider impact of their advertising
# .    campaigns.

################################################################################

# Query 6. For the 3 brands carry out the following ‘across brand analysis’:

# a)	Compute the mean positive mentions for each of the 3 brands.

pos_summary <- superbowl %>% group_by(new_brand)  %>% 
summarize(mean_positives = mean(pos))

pos_summary

#adspend_ssummary <- superbowl %>% group_by(new_brand)  %>% summarize(mean_adspend = mean(adspend))
#adspend_ssummary

# b)	Interpret your results. Clearly state the managerial implications.

      # Ans)Mean Positives for each brand 
#     The mean positives for Beetle, Camaro and CR-Z brands are 884, 22955 and 320 respectively, 

      # Managerial implications
#     From the above mean positive results, I have observed that Camaro has the highest average positive mentions 
#     and CR-Z has the lowest average rate of positive mentions. Hence, it can be concluded that Camaro's marketing 
#     campaigns had the best impact and they must continue to follow their current strategies, while adapting
#     to new changes, if they want to mantain their lead over the other two brands. The other two brands must 
#     make the necessary changes in their marketing campaigns, expenditure and time of advertisement to improve
#     the positive perception of their brands.

################################################################################

# Q7. For the three brands, carry out ‘within brand analysis’ (before and after the Superbowl): 

#  a.	Compute the mean and standard deviations for the buzz metrics
# (volume, pos and neg) before and after Superbowl 
# for each of the three brands. 

superbowl_summary <- superbowl %>% group_by(new_brand, superbowl) %>% 
summarize(mean_volume=mean(volume),sd_volume=sd(volume), mean_pos=mean(pos), sd_pos=sd(pos), mean_neg=mean(neg), sd_neg=sd(neg))

superbowl_summary

#adspends_summary <- superbowl %>% group_by(new_brand,superbowl)  %>% summarize(mean_adspend = mean(adspend))
#adspends_summary

#  b.	Interpret the result for each of the brands. Clearly state the managerial implications.
        
      #Ans) 
            #Results for each brand
#      The mean volume for Beetle, Camaro and CR-Z before Superbowl are 3418, 87596 and 1172.
#      The mean volume for Beetle, Camaro and CR_Z after Superbowl are 4319, 87956 and 1486.
#      The standard deviation for volume of Beetle, Camaro and CR_Z before Superbowl are 622, 7817 and 266.  
#      The standard deviation for volume of Beetle, Camaro and CR_Z after Superbowl are 1463, 22222 and 712.  
#      The mean positive mentions for Beetle, Camaro and CR_Z before Superbowl are 659, 21432 and 268.
#      The mean positive mentions for Beetle, Camaro and CR_Z after Superbowl are 965, 23509 and 339.
#      The standard deviation for positive mentions of Beetle, Camaro and CR_Z before Superbowl are 659, 21432 and 268.  
#      The standard deviation for positive mentions of Beetle, Camaro and CR_Z after Superbowl are 965, 22509 and 339.
#      The mean negative mentions for Beetle, Camaro and CR_Z before Superbowl are 86.5, 4458 and 60.5.
#      The mean negative mentions for Beetle, Camaro and CR_Z after Superbowl are 156, 4679 and 49.8.
#      The standard deviation for negative mentions of Beetle, Camaro and CR_Z before Superbowl are 17.2, 334 and 33.8.  
#      The standard deviation for negative mentions of Beetle, Camaro and CR_Z after Superbowl are 100, 1333 and 21.6.


        # Managerial Implications
#      The volume of buzz created for all three brands is significantly higher after superbowl, hence the advertising
#      money spent during this time is also high for all the brands and they must continue such a trend in order to create more
#      awareness among potential customers for their respective brands. Beetle spent more money in advertising after superbowl 
#      and spent very less before superbowl and their overall volume of buzz, positive mention rate  was lower compared to camaro, 
#      hence it would be best for beetle to improve their spending before superbowl to increase their volume of social media buzz. The CR-Z volume of buzz
#      is significantly lower compared to other two brands, the primary reason for this in the current scenario is their relatively
#      low spending on the advertising, hence they must improve their marketing campaigns and budgets if they wish to make a wider impact,
#      by offering more discounts and benefits like maintenance, test driving and safety plans for their brand. Among the three brands Camaro
#      has the highest volume of social meadia buzz and positive mention rate thanks to their relatively high budget and well distributed spending
#      on adverstising before and after superbowl, but they also have the highest negative mention rate which occurs, when any brand has a huge base 
#      of customers that have very high expectations, therefore they must go through the reasons for these negative mentions by collecting date from social
#      media and address them properly, if they want to maintain their loyal customers and also to gain new customers.

################################################################################
################################################################################

