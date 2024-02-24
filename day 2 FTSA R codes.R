## Single Exponential Approaching Method ##
library(fpp)
plot(oil)

#Apply Single exponential smoothing for oil data set
# ses() is function to apply single exponential smoothing
# h=12 is the no of periods that want to forecast in future
# smoothing parameter alpha is 0.8
fitSES <- ses(oil, h=12 ,alpha=0.8)

# creating a sequence for time 
t = seq(1,length(oil),1)

#calling fitted values in exponential smoothing model
fitSES$fitted

# Assigning fitted values into a variable called fitSESFitted
FitSESFitted <- fitSES$fitted

#plotting actual vs fitted values of exponential smoothing method using matplot
matplot(t,cbind(oil,FitSESFitted),type="l",col=c("red","green"),lty=c(1,1))

## Double exponential smoothing approach ##
# we apply double exponential approach for series that have trend but no seasonal trend
plot(ausair)
?ausair

fitHolt <- holt(ausair,h=12)
fitHolt$model

#Results explanation
#holt(y=ausair,h=12)
#y represent the data set and h=12 represent that no future periods that are going to estimate
#smoothing constant alpha is 0.999 near to 1
#this alpha represent the weight that given to recent observations.
#In this case alpha near to 1 means model gave more weight for the recent observations

#Initial state 
# l=6.4015 represent the initial level
# b=1.0834 represent the initial trend
# sigma=1.6243 represent the standard deviation of the residuals
# lower AIC and BIC values are better when it comes to model selection.


## Triple Exponential approach 
#data set shown both seasonal and trend variations
plot(austourists)
austourists
#data taken from quarterly from 1999 to 2010
#variance are changing over the time in the data set
fitHw = hw(austourists,seasonal = "multiplicative")

fitHwFitted <- fitHw$fitted

#creating a time sequence 
t = seq(1,length(austourists),1)

#plot actual vs fitted values using matplot
matplot(t,cbind(austourists,fitHwFitted),type="l",col=c("red","green"),lty = c(1,1))
