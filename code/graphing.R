figure1 <- read.csv(file="C:\\Users\\62563\\Desktop\\Book1(1).csv",sep=",")
colnames(figure1) <- c('Methods', 'Datasets','Result','Value')
figure1$Value <- as.numeric(figure1$Value)

library(ggplot2)
figure1$Methods <- factor(figure1$Methods, levels = c('CRF','DC-RF-RUS-PF','LORIS',"PSIVER",'SPRINGS','SPPIDER','SSWRF','EL-SMURF'))
#figure1$Methods <- factor(figure1$Methods, levels = c('Origin','MDS','LPP','LLE',"FA"))



figure1$Datasets <- factor(figure1$Datasets, levels = c('Dset186','Dtestset72','PDBtestset164'))
figure1$Result <- factor(figure1$Result, levels = c('ACC','Se','Sp','Pr','F-measure','MCC'))

ggplot(figure1, aes(x=Result,y=Value,fill=Methods)) +
  geom_bar(stat="identity",position=position_dodge()) +
  facet_wrap(vars(Datasets),ncol = 1) +
  scale_y_continuous("Percentage", 
    sec.axis = sec_axis(~ . / 100, name = "Score")) +
  #coord_cartesian(ylim = c(0,100)) +
  scale_fill_manual(breaks = figure1$Methods, 
                  values=c("#F496AA","#C1693C","#533487","#7B90D2","#FC9F4D","#0D68FA","#CDD719","#038E73","red"))


