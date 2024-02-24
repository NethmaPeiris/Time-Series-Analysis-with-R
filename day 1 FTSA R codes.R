#Loading relevant library that contains data set
library(fpp)

?wmurders
wmurders

#plotting the data set
plot(wmurders)
#by exploring the wmurders plot there is clear trend in the data between 1975 to 2004
#Therefore we have to separate that portion to create a time series

#creating a subset of the original time series data.
#It selects a window of data from years 25 to 55 of the original time series
After1975 = window(ts(wmurders),25,55)

#This code line converts the previously selected window of data (After1975) into a new time series object.
#It sets the start and end years for this time series.
#So, you are now specifically analyzing data from 1975 to 2004
After1975 = ts(After1975,start = 1975, end = 2004)

plot(After1975)
#Data 

## Moving Average Approach ##

#his code calculates a moving average with a window size of 5 for the After1975 time series.
#It computes the average value of the time series within a rolling window of 5 data points
MA_5 = ma(After1975,5)
plot(MA_5)

#Plot actual vs fitted values in MA_5 using matplot 

#sequence starting from no 1 that's what the first 1 says
#length of the the sequence is the length of After1975
#and final 1 says the increment of the sequence is 1 by 1 
t = seq(1,length(After1975),1)
?matplot
matplot(t,cbind(After1975,MA_5),type="l",col=c("red","green"),lty = c(1,1))

## Regression Approach ##
t = seq(1,length(After1975),1)

#This line fits a linear regression model. 
#It models After1975 as a function of t, 
#effectively trying to find a linear relationship between the two variables.
#The result is stored in the variable fit.
fit = lm(After1975~t)

#After fitting the linear regression model,
#this line extracts the fitted or predicted values from the model and assigns them to the variable fits.
#These predicted values represent the values of After1975 that the linear regression model estimates based on the values of t.
fits <- fit$fitted.values
matplot(t,cbind(After1975,fits),type="l",col=c("red","green"),lty = c(1,1))
summary(fit)
