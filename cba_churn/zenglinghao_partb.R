#train-test split
train<-sample(1:nrow(churn),nrow(churn)*0.8)
test<--train
churn.train<-churn[train,]
churn.test<-churn[test,]
#check the balance between the data sest
sum(churn.train$Churn=="Yes")
sum(churn.train$Churn=="No")
churn.train.yes<-churn.train[churn.train[,"Churn"]=="Yes",]
churn.train.no<-churn.train[churn.train[,"Churn"]=="No",]
#balance the training set by duplicating the Yes so the ratio is 0.5
chosen<-sample(seq(1:nrow(churn.train.yes)),size = nrow(churn.train.no),replace = TRUE)
churn.train.balanced<-rbind(churn.train.yes[chosen,],churn.train.no)
