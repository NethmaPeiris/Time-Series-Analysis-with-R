library(fpp)
library(fUnitRoots)

plot(chicken)
chicken
length(chicken)

#partitioning the data set 
trainingSet= window(ts(chicken),22,60)
testingSet = window(ts(chicken),61,70)

#Converting both training and testing in to time series variable 
trainingSet = ts(trainingSet,frequency = 12, start = 1945)
testingSet = ts(trainingSet, frequency = 12, start = 1946)

# Identifying the non seasonal differencing 
D1chick= diff(trainingSet,1)
plot(D1chick)

adfTest(D1chick,lags = 1,type = c("c"))
acf(D1chick)
pacf(D1chick)
#Interpretation:

#The null hypothesis of the ADF test is that the time series is non-stationary.
#The alternative hypothesis is that the time series is stationary.
#Since the p-value is less than 0.01, you can reject the null hypothesis.
#In other words, there is strong evidence to suggest that the D1chick time series is stationary