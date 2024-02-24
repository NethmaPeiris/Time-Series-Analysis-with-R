library(fpp)
library(MLmetrics)

?beer
#monthly beer production from jan 1991 to aug 1995
beer
 
#plotting data set 
plot(beer)

length(beer)
#there are 56 of data records in this data set

#dividing into training and testing data set
trainingSet = window(ts(beer),1,44)
testingSet =window(ts(beer),45,56)
trainingSet = ts(trainingSet,frequency = 12,start = c(1991,1))
testingSet =ts(testingSet,frequency = 12,start = c(1994,9))

plot(testingSet)

#to retrieve the models we use triple exponential smoothing 
#In first case we consider the model as additive model 
fit1 <- hw(trainingSet,seasonal = "additive")

#In second case we consider the model as multiplicative model and give alpha beta and gamma values manually
fit2 <- hw(trainingSet,seasonal = "multiplicative", alpha= 0.1, beta = 0.1, gamma = 0.5)

#In third case we consider the model as multiplicative and set automatic values given by R
fit3 <- hw(trainingSet,seasonal = "multiplicative")


#check the inaccuracies of the models
accuracy(fit1)
#               ME     RMSE      MAE        MPE     MAPE      MASE       ACF1
#Training set -0.4186668 7.954451 6.223062 -0.5433373 4.264735 0.6444595 -0.2744465

accuracy(fit2)
#                 ME     RMSE     MAE        MPE     MAPE      MASE      ACF1
#Training set -0.3179051 9.536847 7.41566 -0.3572227 5.083843 0.7679648 -0.248388

accuracy(fit3)
#                 ME     RMSE      MAE        MPE     MAPE      MASE      ACF1
#Training set -0.5567706 7.258765 6.006083 -0.5922874 4.102665 0.6219892 -0.285722

#by considering the MAPE values of the all model model 3 shows the minimal MAPE value. Therefore model 3 is the best model

#Now extracting the mean values of the fit3 model
fit3$mean
#check the fitted values of model 3
fit3$fitted
#check the residuals of the model 3
fit3$residuals

#creating the time sequence for the model 3 for plotting purposes
t <- seq(1,length(trainingSet),1)
#check the training set vs fitted values in model 3
matplot(t,cbind(trainingSet,fit3$fitted),type="l",col=c("red","green"),lty=c(1,1))

### Classical decomposition approach
classicalModel <- decompose(trainingSet,type="additive")
classicalModel

fittedVal <- classicalModel$seasonal+classicalModel$trend

t <- seq(1:length(trainingSet))
matplot(t,cbind(trainingSet,fittedVal),type="l",col=c("red","green"),lty=c(1,1))

fit <- stl(trainingSet,s.window = "periodic", robust = TRUE)
plot(fit)
fore <- forecast(fit)
plot(fore)

fittedVal = fit$time.series[,1]+fit$time.series[,2]
MAPEvalMA =MAPE(trainingSet,fittedVal)*100
MAPEvalMA
#This mean on the average model's forecasting values are differnce from actual values by 3.9% 
#It implays that model is good for forecasting