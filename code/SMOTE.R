#SMOTE
VnewData <- SMOTE(cla ~ ., X164ub, perc.over = 100,perc.under=200)
table(VnewData$cla)
