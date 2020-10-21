#train test split
set.seed(1)
train=sample(1:nrow(transactions),3000)
test=(-train)
#fit model
lm.fit<-lm(TotalTransactions~.,data = transactions,subset = train,)
lm.fit
summary(lm.fit)$r.sq
confint(lm.fit)
abline(lm.fit,lwd=3,col='red')
plot(transactions$TotalTransactions,transactions$Units,col='red')
par(mfrow=c(2,2))
plot(lm.fit)
