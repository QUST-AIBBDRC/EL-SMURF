%Extracting effective information
clear all
clc
for i=1:72
    sign=num2str(i);
    path=[sign,'.itf'];
    data_{i}=importdata(path);
end 
for i=1:72
    A=data_{i};
shu=A.textdata;
data=shu(:,3);
addition=shu(:,2);
n=1;
obtain=[];obtain_1=[];
for j=1:numel(data)
    if (data{j}=='+')
        obtain(n)=str2num(addition{j});
       n=n+1;
    end
    
end
obtain_positive{i}=obtain;
n=1;
for j=1:numel(data)
    if (data{j}=='-')
        obtain_1(n)=str2num(addition{j});
       n=n+1;
    end
    
end
obtain_negative{i}=obtain_1;
end


save positive_negative.mat obtain_positive obtain_negative

