#build a x matrix
x=model.matrix(transactions$TotalTransactions~.,transactions)[,-1]
y=transactions$TotalTransactions
#train test split
set.seed(1)
train=sample(1:nrow(x),3000)
test=(-train)
y.test=y[test]
#build a ridge model
library(glmnet)
#perform a 10 fold cross validation in finding the best lambda
cv.out<-cv.glmnet(x[train,],y[train],alpha=0,standardize=TRUE,standardize.response=TRUE)
#plot the model error bs lambda
plot(cv.out)
#find the most ideal lambda
bestlam<-cv.out$lambda.min
#refit the ridge using the lambda chosen on the full data set
out=glmnet(x,y,alpha = 0,standardize = TRUE,standardize.response = TRUE)
predict(out,type="coefficients",s=bestlam)[1:27,]
