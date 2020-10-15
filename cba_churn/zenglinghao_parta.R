churn<-read.csv(file.choose(),header = T)
#summary of the dataset
summary(churn)
#check string data to see if it is binary
#Internation Plan
sum(churn$International.Plan=="Yes" | churn$International.Plan=="No")
#voice mail plan
sum(churn$Voice.Mail.Plan=="Yes" | churn$Voice.Mail.Plan=="No")
#churn mail plan
sum(churn$Churn=="Yes" | churn$Churn=="No")
#voice mail plan contains non-binary values
churn[(churn$Voice.Mail.Plan!="Yes" & churn$Voice.Mail.Plan!="No"),]
churn[1269,"Voice.Mail.Plan"]='No'
churn[2001,"Voice.Mail.Plan"]=NA
#do a scatter matrix on the numerical columns
names(churn)
churn.num<-churn[,c(1,2,5,6,7,8,9,10,11,12,13,14,15,16,17,18)]
#check if all numeric coulumns contain only numeric numbers
col.names<-names(churn.num)
columns<-rep(0,16)
for (i in 1:16){
  columns[i]=is.numeric(churn.num[,col.names[i]])
  print(col.names[i])
  print(columns[i])
}
plot(churn.num)
summary(churn.num)
#from the scatter matrix, there is a significant outlier in international charge
plot(churn.num$International.Charge~churn.num$Customer)
summary(churn.num$International.Charge)
churn[churn[,"International.Charge"]==301,]
#apply na value to the international charge 301
churn[65,"International.Charge"]=NA
#there also appears to be a na valye in Day.calls
plot(churn.num$Day.Calls~churn.num$Customer)
summary(churn.num$Day.Calls)
churn[is.na(churn$Day.Calls),]
##apply the mean to the missing value
summary(churn)
#check if all voice mail plan logic is consistent
sum(churn[churn$Voice.Mail.Plan=="No",5]==0)
#leave out the customer column
churn<-churn[,-1]
#factor the string variables
churn[,"Voice.Mail.Plan"]=as.factor(churn[,"Voice.Mail.Plan"])
churn[,"International.Plan"]=as.factor(churn[,"International.Plan"])
churn[,"Churn"]=as.factor(churn[,"Churn"])
#create a summary table
summary(churn)
summary(churn[churn[,"Churn"]=="Yes",])
summary(churn[churn[,"Churn"]=="No",])
