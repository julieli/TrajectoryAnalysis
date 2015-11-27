%
% Date:   2011-5-24
% Author: Ce Li
%Sparse Reconstruction Analysis��������
%L1-norm�����б�������,��������쳣�켣
%training_trajectory_spline  K=100 J=22 P=7
tic;
clear;
clc;
%get_spline_set;
cvx_setup;
J=22;
K=100%20%30%40%60%70;%80%90;%100%75%25%50;%100;
%ÿ�ֵ�������K��, ά��*22*K �ļ���
load label;
load TrajectorySplineSet;
%���10��ʵ�飬ȡ���ƽ��ֵ
Trials=zeros(10,5);
Mean_DACC=0;
Mean_CCR=0;
Mean_Precision=0;
Mean_Recall=0;
Mean_F1=0;
for do=1:10
    %ÿ��ʵ�鿪ʼ
    weidu=size(training_trajectory_spline);
    train=zeros(weidu(1),J*K);
%%{
%�����ѡK������
R=unifrnd(1,100,K,1);%1-100��ѡK����K��1��
R=round(R);
for i=1:J
    for j=1:K
        si=100*(i-1)+R(j);
        train(:,K*(i-1)+j)=training_trajectory_spline(:,si);
    end
end
%}
%{
%��������K��
for i=1:22*K
    si=round(i*(100/K));
    train(:,i)=training_trajectory_spline(:,si);
end
%}

% ѡȡѵ������ÿ�ֵ�������100����14*2200����
%%load training_trajectory_spline;
%train=training_trajectory_spline;
w=zeros(J*K,1);
for T=1:2

    if T==1
        %%==================��������==================%%
        testsize=size(test_normal);
    else
        %%==================��������==================%%
        testsize=size(test_anomalous);
    end
    test=zeros(weidu(1),1);%��ʼ��һ����������
    result=zeros(testsize(2),2);
    max_p=zeros(testsize(2),1);
    min_p=zeros(testsize(2),1);
    
    for i=1:testsize(2)
        if T==1
            %%==================��������==================%%
            test=test_normal(:,i);
        else
            %%==================��������==================%%
            test=test_anomalous(:,i);
        end
        
        %�ع�ϵ��
        %fai(:,i)=rc(train,test); %���в����������ع�ϵ��
        w=rc(train,test);

        %��������
        for j=1:J
            for k=1:J*K;
                lower=(j-1)*K;
                upper=j*K;
                if(k>lower && k<=upper)
                    delta(k,j)=w(k);
                else
                    delta(k,j)=0;
                end
            end
        end
        %��С�ع����
        min=9999999;
        max=-9999999;
        tmp=0;
        for j=1:J
            r(j)=norm(test-train*delta(:,j),2);
            if r(j)<min
                min=r(j);
                tmp=j;
            end
            if r(j)>max
                max=r(j);
            end
        end
        
        %%{
        %�ع������С����
        result(i,1)=tmp;%��¼��i�����������ķ���
        result(i,2)=r(tmp);%�����i��������������С�ع����
        %%}
        
        %����ع�����
        sum=0;
        for j=1:J
            sum=sum+(1/r(j));
        end
        max_p(i,1)=(1/r(tmp))/sum;
        
        %��С�ع�����    
        min_p(i,1)=(1/max)/sum;    
        test=zeros(weidu(1),1);
    end
    
    if T==1
        %%==================�����������==================%%
        normal_array=[result,max_p,min_p];        
    else
        %%==================���������==================%%
        anomalous_array=[result,max_p,min_p];
    end
    
    result=zeros(testsize(2),2);
    max_p=zeros(testsize(2),1);
    min_p=zeros(testsize(2),1);
    
end

%����DACC��CCRֵ
TP=0;
TN=0;
DACC=0;
CCR=0;
Precision=0;
Recall=0;
F1=0;
for i=1:21
    if normal_array(i,4)>0.03
        TP=TP+1;
    else if normal_array(i,4)==0.03
            TP=TP+1;
        end
    end
    if normal_array(i,1)== label(i)
        CCR=CCR+1;
    end
end
CCR=CCR/21;
for i=1:19
    if anomalous_array(i,4)<0.03
        TN=TN+1;
    end
end
DACC=(TP+TN)/40;
Precision=TP/(TP+19-TN);
Recall=TP/21;
F1=2*Precision*Recall/(Precision+Recall);
    
    %ÿ��ʵ�����
    Trials(do,1)=DACC;
    Mean_DACC=Mean_DACC+DACC;
    Trials(do,2)=CCR;
    Mean_CCR=Mean_CCR+CCR;   
    Trials(do,3)=Precision;
    Mean_Precision=Mean_Precision+Precision;  
    Trials(do,4)=Recall;
    Mean_Recall=Mean_Recall+Recall;  
    Trials(do,5)=F1;
    Mean_F1=Mean_F1+F1;  
end
Mean_DACC=Mean_DACC/10;
Mean_CCR=Mean_CCR/10;
Mean_Precision=Mean_Precision/10;
Mean_Recall=Mean_Recall/10;
Mean_F1=Mean_F1/10;
toc;
        



