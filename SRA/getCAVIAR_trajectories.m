%2013-11-25 Julie(Ce) Li
%##########################################################################
clear;clc;
%consists of 2221 normal and 19 abnormal
CAVIAR_trajectories=[];

% shortest length of test_normal
n_test_normal=9999;
% shortest length of train_normal
n_train_normal=9999;

%2200 normal for training, 21 normal and 19 abnormal for testing 
for filenum=1:2240
    if filenum<20 %19 abnormal for testing
        filePath=['F:\celia_工作集\CAVIAR\8\data2_uv\\anomalous_' num2str(filenum) '.txt'];
        data=load(filePath); 
        l=filenum;
        CAVIAR_trajectories.testing_anomalous{l}.track(:,1)=1:length(data);
        CAVIAR_trajectories.testing_anomalous{l}.track(:,2:3)=data; 
        CAVIAR_trajectories.testing_anomalous{l}.class='anomalous';
    elseif filenum<41 %21 normal for testing
        filePath=['F:\celia_工作集\CAVIAR\8\data2_uv\\normal_' num2str(filenum) '.txt'];
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
        filePath=['F:\celia_工作集\CAVIAR\8\data2_uv\\training_' num2str(filenum) '.txt'];
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

save('CAVIAR_trajectories.mat','CAVIAR_trajectories');
clear i j l filePath filenum data CAVIAR_trajectories;
