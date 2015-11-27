% Date:   2014-5-25
% Author: Ce Li

%************将Bspline数据集合存储.mat格式************
load('CarparkTrajectories.mat');
p=input('Please input p=');

n_test_normal=999;%to caculate the shortest length of test_normal
n_train_normal=999;%to caculate the shortest length of train_normal

test_anomalous=zeros(2*p,7);
test_normal=zeros(2*p,27);
training_trajectory_spline=zeros(2*p,235);
 
 for filenum=1:269
    if filenum<8 %7 abnormal for testing
        l=filenum;
        data=CarparkTrajectories.testing_anomalous{1,l}.track(:,2:3);
        CXY=SSpline(data,p);
        test_anomalous(1:p,l)=CXY(:,1);
        test_anomalous(p+1:2*p,l)=CXY(:,2);
    elseif filenum<35 %27 normal for testing
        l=filenum-7;
        data=CarparkTrajectories.testing_normal{1,l}.track(:,2:3);
        CXY=SSpline(data,p);
        test_normal(1:p,l)=CXY(:,1);
        test_normal(p+1:2*p,l)=CXY(:,2);
        
        %for caculate the shortest length of test_normal
        if length(data)<n_test_normal
            n_test_normal=length(data);%135
        end
            
    else %2200 normal for training
        l=filenum-34;
        data=CarparkTrajectories.training{l}.track(:,2:3);
        CXY=SSpline(data,p);
        training_trajectory_spline(1:p,l)=CXY(:,1);
        training_trajectory_spline(p+1:2*p,l)=CXY(:,2);
                
        %for caculate the shortest length of train_normal
        if length(data)<n_train_normal
            n_train_normal=length(data);%94
        end
        
    end
 end
 
 save TrajectorySplineSet_p=24.mat test_normal test_anomalous training_trajectory_spline;

 
 
 
 