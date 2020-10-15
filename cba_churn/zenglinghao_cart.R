library(rpart)
tree.fit<-rpart(formula = Churn~.,data=churn.train.balanced,method = "class",control = rpart.control(minsplit = 2,cp=0))
library(rpart.plot)
rpart.plot(tree.fit)
summary(tree.fit)
#find the best cp using cp plot and cp table
par(mfrow=c(1,1))
plotcp(tree.fit)
printcp(tree.fit)
##from the cp table and the cp graph, teh optiimal cp is between 0.012 and 0.00945626
tree.prune<-prune(tree.fit,cp=0.0003655)
rpart.plot(tree.prune)
printcp(tree.prune)
summary(tree.prune)
pred<-predict(tree.prune,newdata = churn.test,type="class")
library(caret)
confusionMatrix(pred,churn.test$Churn)

