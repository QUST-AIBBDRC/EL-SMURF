%Extracting feature information from sliding window 
clear all
clc
data_red=xlsread('DATA72.xlsx','Sheet3');
data_red=data_red(:,1:2:end);
load('positive_negative.mat');
for i=1:72
    sign=num2str(i);
    path=[sign,'.pssm'];
    A{i}=importdata(path);    
    data_pssm=A{i}.data; 
    positive=obtain_positive{i};
    negative=obtain_negative{i};
    number=max([positive(end),negative(end)]);
    h_sign=[];
    for h=1:length(positive)
            if positive(h)>number-5
               h_sign=[h_sign,h];
            end
    end
    positive(h_sign)=[];
        if positive (5)<6
           H=positive (:,6:end);
        elseif positive (4)<6
               H=positive (:,5:end);
        elseif positive (3)<6
               H=positive (:,4:end);
        elseif positive (2)<6
               H=positive (:,3:end);
        elseif positive (1)<6
               H=positive (:,2:end);
        else
               H=positive ;
        end 
    
    for h=1:length(positive)
        for m=1:length(H)
            H1=H(m)-5;
            H2=H(m)+5;
            data1=data_pssm(H1:H2,1:20);
            data2=data_red(H1:H2,i)
            data=[data1,data2];
            data=data';
            data_pssm_positive{m,1}=[reshape(data,1,11*21),1];  
        end

    end
          data_shu{i}=data_pssm_positive;
          clear data_pssm_positive
              
          
           h_sign=[];
          for k=1:length(negative)
              if negative(k)>number-5
                 h_sign=[h_sign,h];
              end
          end
          negative(h_sign)=[];
              if negative(5)<6
                 H=negative(:,6:end);
              elseif negative(4)<6
                     H=negative(:,5:end);
              elseif negative(3)<6
                     H=negative(:,4:end);
              elseif negative(2)<6
                     H=negative(:,3:end);
              elseif negative(1)<6
                     H=negative(:,2:end);
              else
                     H=negative;
              end
                  for b=1:length(H)
                      H1=H(b)-5;
                      H2=H(b)+5;
                      data3=data_pssm(H1:H2,1:20);
                      data4=data_red(H1:H2,i)
                      data_=[data3,data4];
                      data_=data_';
                      data_pssm_negative{b,1}=[reshape(data_,1,11*21),-1];  
                  end
             
              data_shu1{i}=data_pssm_negative;
              clear data_pssm_negative
end

