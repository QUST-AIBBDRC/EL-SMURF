%% 
clear all
clc
data=xlsread('balance164.xlsx','data164');
X=data(:,1:end-1);
label=data(:,end);
no_dims = round(intrinsic_dim(X, 'MLE'));
disp(['MLE estimate of intrinsic dimensionality: ' num2str(no_dims)]);
[mappedX, mapping] = compute_mapping(X, 'MDS', no_dims);
data_1=[mappedX,label];
[M,N]=size(data_1);
shu=mappedX
testlabel=[];yucelabel=[];
for i=2:M-1
    test_shu(i,:)=shu(i,:);
    test_label(i)=label(i);
    a=shu(1:i-1,:);
    b=shu(i+1:end,:);
    train_shu=[a;b];
    c=label(1:i-1,:);
    d=label(i+1:end,:);
    train_label=[c;d]; 
    [predict_label(i),score]=ensemble_learn5(train_shu,train_label,test_shu(i,:),test_label(i));
     testlabel=[testlabel;test_label(i)];
     yucelabel=[yucelabel;predict_label(i)];
end
  [predict_label(1),score]=ensemble_learn5(shu(2:M,:),label(2:M,:),shu(1,:),label(1,:))
  [predict_label(M),score]=ensemble_learn5(shu(1:M-1,:),label(1:M-1,:),shu(M,:),label(M,:))
   testlabel=[label(1);testlabel;label(M)];
   yucelabel=[predict_label(1);yucelabel;predict_label(M)];
  [SE,PE,ACC,MCC,tp,tn]=VF(testlabel,yucelabel);

 


 