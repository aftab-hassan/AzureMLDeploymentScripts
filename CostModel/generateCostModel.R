#clear
rm(list=ls())

#required R packages
library(Cubist)
library(pROC)

#input file
inputFile = 'MHS_CHF_NONA.csv'
df        <- read.csv(inputFile)
df = df[sample(1:nrow(df)),]
#df = df[1:1000,]

#preds file
predsFile = 'cost_cols.csv'
preds     <- read.csv(predsFile)
preds = as.character(preds$x)

#response
responseVar = 'nextcost'

#test data
testdata = df[1:5,]

formula   <- as.formula(paste(responseVar,'~.',sep=''))

#model = cubist(data.train[,which(names(data.train) %in% preds)],data.train[,which(names(data.train)==responseVar)])
#pred = predict(model, newdata=data.test[,which(names(data.test) %in% preds)])

cat(paste0("Training model for ",responseVar,"\n"))
model = cubist(df[,which(names(df) %in% preds)],df[,which(names(df)==responseVar)])
saveRDS(model,paste0(responseVar,"cubist.RDS"))

cat(paste0("Doing a test prediction for ",responseVar,"\n"))
pred = predict(model, newdata=testdata[,which(names(testdata) %in% c(preds))])
print(pred)
