#building a lasso model
#build a x matrix
x=model.matrix(transactions$AUM~.,transactions)[,-1]
y=transactions$AUM
#train test split
set.seed(1)
train=sample(1:nrow(x),13000)
test=(-train)
y.test=y[test]
library(glmnet)
#perform a 10 fold cross validation in finding the best lambda
cv.out<-cv.glmnet(x[train,],y[train],alpha=1,standardize=TRUE,standardize.response=TRUE)
#plot the model error bs lambda
plot(cv.out)
#find the most ideal lambda
bestlam<-cv.out$lambda.min
#refit the ridge using the lambda chosen on the full data set
out=glmnet(x,y,alpha = 1,standardize = TRUE,standardize.response = TRUE)
predict(out,type="coefficients",s=bestlam)[1:16,]
lasso.pred<-predict(out,newx = x[test,])
sqrt(mean((lasso.pred-y.test)^2))

