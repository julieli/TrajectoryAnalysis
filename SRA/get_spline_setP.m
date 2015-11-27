% Date:   2014-5-25
% Author: Ce Li

%************��Bspline���ݼ��ϴ洢.mat��ʽ************
load('CAVIAR_trajectories.mat');
p=input('Please input p=');

 test_anomalous=zeros(2*p,19);
 test_normal=zeros(2*p,21);
 training_trajectory_spline=zeros(2*p,2200);
 
 for filenum=1:2240
    if filenum<20 %19 abnormal for testing
        data=CAVIAR_trajectories.testing_anomalous{l}.track(:,2:3); 
        CXY=Spline(data);
        test_anomalous
        CAVIAR_trajectories.testing_anomalous{l}.class='anomalous';
    elseif filenum<41 %21 normal for testing
        filePath=['F:\celia_������\CAVIAR\8\data2_uv\\normal_' num2str(filenum) '.txt'];
        data=load(filePath); 
        l=filenum-19;
        CAVIAR_trajectories.testing_normal{l}.track(:,1)=1:length(data);
        CAVIAR_trajectories.testing_normal{l}.track(:,2:3)=data;  
        CAVIAR_trajectories.testing_normal{l}.class='normal';
        
        %for caculate the shortest length of test_normal
        if length(data)<n_test_normal
            n_test_normal=length(data);%135
        end
            
    else %2200 normal for training
        filePath=['F:\celia_������\CAVIAR\8\data2_uv\\training_' num2str(filenum) '.txt'];
        data=load(filePath); 
        l=filenum-40;
        CAVIAR_trajectories.training{l}.track(:,1)=1:length(data);
        CAVIAR_trajectories.training{l}.track(:,2:3)=data; 
        CAVIAR_trajectories.training{l}.class='normal';
                
        %for caculate the shortest length of train_normal
        if length(data)<n_train_normal
            n_train_normal=length(data);%94
        end
        
    end
 end

 function CXY = Spline(data)
     N=size(data);%����ά��������
    
    point=zeros(N(1),2);%�켣�㣬x���� y����
    point=data;%data����Ϊ����ʱ���켣��
    
    %��ʼ�����ؼ�
    total=0;%��ʼ��������ֵΪ0
    s=zeros(1,N(1));%����������
    pX=zeros(1,N(1));%�켣����Ϊ�������ֵ�������ͼʱ����
    pY=zeros(1,N(1));
    CX=zeros(1,p);
    CY=zeros(1,p);
        
    %���켣���ܻ���
    for i=1:N(1)
        %point(i,1)=CAM11(i,2)+CAM11(i,4)/2;
        %point(i,2)=CAM11(i,3)+CAM11(i,5)/2;
        if(i>1)
            total=total+sqrt((point(i,1)-point(i-1,1))^2+(point(i,2)-point(i-1,2))^2);
        end
    end
    
    %���㻡������
    for i=2:N(1)
        tmp=0;
        for j=2:i
            tmp=tmp+sqrt((point(j,1)-point(j-1,1))^2+(point(j,2)-point(j-1,2))^2);
        end
        s(i)=tmp/total;
    end
    
    %���任����fai
    c=1;
    %����tao����[0,0,0,0,...,1,1,1,1]
    for i=1:p+4
        if(i<5) tao(i)=0;
        else if (i>p) tao(i)=1;
            else
                tao(i)=c/(p-3);
                c=c+1;
            end
        end
    end
    phi=zeros(N(1),p);
    for n=1:N(1)
        for i=1:p
            %m=4;
            phi(n,i)=Bbase(i,4,tao,s(n));
        end
    end
    
    %���CXY����
    CXY=pinv(phi)*point; %pinv(phi),fai��α��
 end
 
 
 