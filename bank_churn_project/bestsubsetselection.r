#open the transaction.csc, store into a dataframe
transactions<-read.csv(file.choose(),header = TRUE)
transactions<-transactions[,-c(1,3,16)]
#data exploration
names(transactions)
dim(transactions)
sum(is.na(transactions))
#omitting date
mean(transactions$AUM)
#best subset selection
library(leaps)
set.seed(0)
#train the model using best subset selection
regfit.full<-regsubsets(AUM~.,data=transactions,
                        nvmax=26, really.big=T)
#summary of the model
reg.summary=summary(regfit.full)
#model anlysis
par(mfrow=c(1,1))
plot(reg.summary$rss,xlab="Number of Variables",ylab='RSS')
plot(reg.summary$adjr2,xlab = "Number of Variables", 
    ylab = "Adjusted RSq")
#summary of the model(for each number of varaible selection)
reg.summary
#find the best number of variable selection
which.max(reg.summary$adjr2)
points(11,reg.summary$adjr2[11],col="red",cex=2,pch=20)
#plotting the best fit model adjusted error
plot(regfit.full,scale = "r2")
plot(regfit.full,scale="adjr2")
plot(regfit.full,scale="Cp")
plot(regfit.full,scale = "bic")
#coefficients of the best model
coef(regfit.full,11)
