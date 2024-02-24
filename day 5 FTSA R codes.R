library(fpp)
library(forecast)

plot(austourists)

a <- acf(austourists,50)
#At lag 0 ACF always 1 because time series always co-related with it self at lag 0
#This ACF does not approach to suddenly when its lags are increasing therefore series doesn't appear as stationary

pacf(austourists,50)
#PACF also doesn't indicate a sharp drop after few lags. That's shows the series is not stationary

D1Y = diff(austourists,1)
D1Y
#In here we apply differencing.
#In this case the data set differencing with the previous consecutive value to make the series stationary
#This 1 in the diff funtion represent that we applied first order differencing 

D4Y = diff(austourists,4)
D4Y
#In here we applied 4th order differencing higher order difference helps to remove seasonal and trend effects

DD1Y =diff(D1Y,1)
#Here we apply first order differencing into the D1Y, which is already defferenced by order 1
DD1Y =diff(diff(austourists,1),1)
#Here we apply differencing twice to original data set 
#This is equal to calculate the second order differencing

plot(austourists)
#here we can see trend and seasoanlity as well
plot(D1Y)
#here we can see seasonality but no trend is there
plot(D4Y)
#Higher order differencing model (oder 4 ) indicates no seasonality and trend

D4Y = diff(austourists,4)
#Here we apply order 4 differencing to the original data set
D1D4Y = diff(D4Y,1)
#In here we calculated the first order differencing on the 4th oder diffrenced austourist data set
plot(D1D4Y)

D4D1Y = diff(D4Y,1)

Acf(austourists,50)
#In every 4th lag there is a significant difference can be appear. This shows seasonality effect

Acf(D4Y,50)
#There are no seasoanl patters can be appeared

Acf(D1Y,50)
#Seasonal Pattern can be appear

Acf(D4D1Y,50)
#Deseasonalized and Detrend 

Box.test(austourists,12)
#L-jung box test for white noise in time series data
#test will examine whether there is any significant autocorrelation in the residuals
#of the time series at a lag of 12 time periods (in this case, 12 months).
#df =12 because model examine the auto correlations with lag 12 time periods
# p value is almost near to zero this mean we can reject null hypothesis with strong evidence
#That mean model has significant auto correlation with residuals
# This suggests that the model used to analyze this data may not adequately capture all of its underlying patterns
