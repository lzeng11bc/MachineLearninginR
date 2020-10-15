names(churn)
glm.fit<-glm(as.factor(Churn)~ Account.Length+International.Plan+Voice.Mail.Plan+Day.Minutes
             +Day.Calls+Evening.Call+Evening.Charge+Night.Minutes
             +Night.Calls+International.Minutes+International.Calls
             +Customer.Service.Calls,data = churn.train.balanced,family = binomial)
summary(glm.fit)
#see the value on the test set
glm.probs=predict(glm.fit,churn.test,type="response")
glm.pred=rep("No",nrow(test.churn))
glm.pred[glm.probs>.5]="Yes"
library(caret)
confusionMatrix(as.factor(glm.pred),churn.test$Churn)
#use diagnostic plot to check if there is any correlation
par(mfrow=c(2,2))
plot(glm.fit)
#use vif to detect colinearity and drop correlated term one by one untill vif is below 2
library(car)
vif(glm.fit)
