#clear
rm(list=ls())

#required R packages
library(ada)
library(pROC)

#input file
inputFile = 'MHS_CHF.csv'
df        <- read.csv(inputFile)
df = df[sample(1:nrow(df)),]

#preds file
predsFile = 'readmit_cols.csv'
preds     <- read.csv(predsFile)
preds = as.character(preds$x)

#response
responseVararray = c('thirtyday','sixtyday','ninetyday','two_LOS','four_LOS','six_LOS','three_mortality','six_mortality','nine_mortality','twelve_mortality')

#test data
testdata = df[1:5,]

#for(i in 2:length(responseVararray))
for(i in 1:length(responseVararray))
{
	responseVar = responseVararray[i]
	formula   <- as.formula(paste(responseVar,'~.',sep=''))

	cat(paste0(i,".Training model for ",responseVar,"\n"))
	model = ada(formula, data = df[,which(names(df) %in% c(responseVar, preds))])
	saveRDS(model,paste0(responseVar,"ada.RDS"))

	cat(paste0(i,".Doing a test prediction for ",responseVar,"\n"))
	pred = predict(model, newdata=testdata[,which(names(testdata) %in% c(responseVar,preds))], type='prob')[, 2]
	print(pred)

	cat(paste("\n"))
}
