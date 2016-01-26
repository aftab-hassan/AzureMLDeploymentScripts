#clear
rm(list=ls())

#required R packages
library(Cubist)
library(pROC)

#input file
inputFile = 'MHS_CHF.csv'
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
testdata = df

#read model
model = readRDS('cubist_cost_model.RDS')

cat(paste0("Doing prediction for ",responseVar,"\n"))
pred = predict(model, newdata=testdata[,which(names(testdata) %in% c(preds))])
testdata$PredictedCost = pred;

write.csv(testdata,'CostCubist.csv',row.names=FALSE)
