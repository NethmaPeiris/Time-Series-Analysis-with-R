library(fpp)
plot(wmurders)

length(wmurders)
#length is 55


?wmurders
wmurders
#data taken from 1950 to 2004
#in monthly basis


#partition data set into test and training set

trainingSet <- window(ts(wmurders),1,43)
testingSet <- window(ts(wmurders),44,55)

#Converting the training and testing set into time series variables
trainingSet <- ts(trainingSet, frequency = 12, start = 1950)
testingSet <- ts(testingSet, frequency = 12, start = 2004)

plot(trainingSet)
#Plot shows variance is vary over the time periods 

# make the variance constant by transforming 
# This helps to make the variance constant over when we dealing with series which vary the variance over the time
LWmurd = log(trainingSet)
plot(LWmurd)
Acf(LWmurd) #Shows that series is not stationary 

ndiffs(LWmurd)



## Identifying the order of non-seasonal differencing 
D1LWmurd = diff(LWmurd,1)
plot(D1LWmurd)
acf(D1LWmurd)
pacf(D1LWmurd)

Box.test(D1LWmurd,lag=12, type = "Ljung")
#P value is greater than 0.05 that mean we have don't have enough evidence to reject null hypothesis(Ho)
#That mean model doesn't have significant autocorrelation in the residuals of the D1LWmurd

# Modeling using the recent set of data
trainingSet = window(ts(wmurders),22,50)
testingSet = window(ts(wmurders),51,55)
trainingSet =ts(trainingSet,frequency = 12,start=1952)

plot(trainingSet)
Acf(trainingSet,50)
pacf(trainingSet,50)

#Parameter estimation
fit1 = Arima(trainingSet,order=c(1,0,0), include.mean = TRUE)
summary(fit1)
coeftest(fit1)
