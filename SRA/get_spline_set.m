% Date:   2012-11-25
% Author: Ce Li

%************��Bspline���ݼ��ϴ洢.mat��ʽ************

%���룺spline���ݣ�CXY��ϵ㣩(�漰������p)
%�����test_anomalous,test_normal, training_trajectory_spline.mat
 %test_anomalous_SE=zeros(4,19);
 p=input('Please input p=');
 
 %2p
 test_anomalous=zeros(2*p,19);
 test_normal=zeros(2*p,21);
 training_trajectory_spline=zeros(2*p,2200);
 
 %2p+2
 
 %2p+4

for filenum=41:2240
    %filePath=['G:\\CAVIAR\\3\\BMVC2008_caviar_data\\data3_spline_p=' num2str(p) '\\anomalous_' num2str(filenum) '.txt'];
    if filenum<20
        filePath=['F:\cluster-based LCKSVD\dataset\CAVIAR\\spline_p=' num2str(p) '\anomalous_' num2str(filenum) '.txt'];
            else if filenum<41
                     filePath=['F:\cluster-based LCKSVD\dataset\CAVIAR\\spline_p=' num2str(p) '\normal_' num2str(filenum) '.txt'];
                else
                     filePath=['F:\cluster-based LCKSVD\dataset\CAVIAR\\spline_p=' num2str(p) '\training_' num2str(filenum) '.txt'];
                end
            end
    data=load(filePath);
    N=size(data);
  
    %2pά
    if(N(1) == p)
        for i=1:N(1)     
            if filenum<20
                test_anomalous(i,filenum)=data(i,1);
                test_anomalous(i+p,filenum)=data(i,2);
            else if filenum<39
                test_normal(i,filenum-19)=data(i,1);
                test_normal(i+p,filenum-19)=data(i,2);
                else
                    training_trajectory_spline(i,filenum-40)=data(i,1);
                    training_trajectory_spline(i+p,filenum-40)=data(i,2);
                end
            end
            

        end
    end
    %}
    
    %2p+2ά��ʼ�ձ�ţ�
    %{
    training_trajectory_spline=[training_trajectory_spline
    training_label];
    test_anomalous=[test_anomalous
    test_anomalous_label];
    test_normal=[test_normal
    test_normal_label];    
    %}
    
    %2p+4ά��ʼ�����꣩
    %{
    %p=input('Please input p=');
    training_trajectory_spline=[training_trajectory_spline
    train_SE];
    test_anomalous=[test_anomalous
    test_anomalous_SE];
    test_normal=[test_normal
    test_normal_SE];    
    
    %}
    
end
%savename=['my' num2str(1) 'TrajectorySplineSet'];
    save TrajectorySplineSet2 training_trajectory_spline test_normal test_anomalous;
    disp('Julie is Fighting~~');