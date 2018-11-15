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
shu=mappedX;
testlabel=[];yucelabel=[];Scores=[];
for i=2:M-1
    test_shu(i,:)=shu(i,:);
    test_label(i)=label(i);
    a=shu(1:i-1,:);
    b=shu(i+1:end,:);
    train_shu=[a;b];
    c=label(1:i-1,:);
    d=label(i+1:end,:);
    train_label=[c;d]; 
    Factor = NaiveBayes.fit(train_shu,train_label);
    [Scores,predict_label(i)] = posterior(Factor, shu(i,:));
    yucelabel=[yucelabel;predict_label(i)];
    testlabel=[testlabel;test_label(i)];
end
Factor = NaiveBayes.fit(shu(2:M,:),label(2:M,:));
[Scores,predict_label(1)] = posterior(Factor, shu(1,:));
Factor = NaiveBayes.fit(shu(1:M-1,:),label(1:M-1,:));
[Scores,predict_label(M)] = posterior(Factor, shu(M,:));
yucelabel=[predict_label(1);yucelabel;predict_label(M)];
testlabel=[label(1);testlabel;label(M)];
[SE,PE,ACC,MCC,tp,tn]=VF(testlabel,yucelabel);

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
    model=svmtrain(train_label,train_shu,'-t 2 ');
   [predict_label(i)]=svmpredict( test_label(i),test_shu(i,:),model)
    yucelabel=[yucelabel;predict_label(i)];
    testlabel=[testlabel;test_label(i)];
end
model=svmtrain(label(2:M),shu(2:M,:),'-b 1');
[predict_label(1)]=svmpredict( label(1),shu(1,:),model);
model=svmtrain(label(1:M-1),shu(1:M-1,:),'-b 1');
[predict_label(M)]=svmpredict( label(M),shu(M,:),model);
yucelabel=[predict_label(1);yucelabel;predict_label(M)];
testlabel=[label(1);testlabel;label(M)];
[SE,SP,ACC,MCC,tp,tn]=VF(testlabel,yucelabel);

