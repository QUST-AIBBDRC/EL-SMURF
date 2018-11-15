%Draw the ROC curve and calculate the AUC value
function auc=AUC_number(scores,test_label)
dec=scores;
for i=1:length(test_label)
    switch test_label(i)
        case 1
            tar_label(i,:)=[1,0];
        case -1
            tar_label(i,:)=[0,1];
    end
end
[fpr,tpr,thresholds] =roc(tar_label(:,1)',dec(:,1)');
false=fpr;
positive=tpr;
x=false';
y=positive';
plot(x,y);
auc= sum((x(2:length(x),1)-x(1:length(x)-1,1)).*y(2:length(y),1));
