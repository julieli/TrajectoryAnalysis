% Date:   2011-5-24
% Author: Ce Li

%************画出部分训练轨迹************
  
tic;%程序运行计时
%mkdir([cd,'image\\train2200']); %新建存储结果目录
p=input('Please input p=');
for filenum=1:2240
    % filenum=input('Please input filenum=');
    %filenum=2200;   
    if filenum<20
        filePath=['G:\\CAVIAR\\3\\BMVC2008_caviar_data\\data2_uv\\anomalous_' num2str(filenum) '.txt'];
    else if filenum<41
            filePath=['G:\\CAVIAR\\3\\BMVC2008_caviar_data\\data2_uv\\normal_' num2str(filenum) '.txt'];
        else 
            filePath=['G:\\CAVIAR\\3\\BMVC2008_caviar_data\\data2_uv\\training_' num2str(filenum) '.txt'];
        end
    end
    data=load(filePath);    
    N=size(data);%数据维数，行列
    
    point=zeros(N(1),2);%轨迹点，x坐标 y坐标
    point=data;%data数据为两列时，轨迹点
    
    %初始化，关键
    total=0;%初始化弧长总值为0
    s=zeros(1,N(1));%弧长比向量
    pX=zeros(1,N(1));%轨迹长度为估计最大值，以免绘图时出错
    pY=zeros(1,N(1));
    CX=zeros(1,p);
    CY=zeros(1,p);
    
    %求解轨迹的总弧长
    for i=1:N(1)
        %point(i,1)=CAM11(i,2)+CAM11(i,4)/2;
        %point(i,2)=CAM11(i,3)+CAM11(i,5)/2;
        if(i>1)
            total=total+sqrt((point(i,1)-point(i-1,1))^2+(point(i,2)-point(i-1,2))^2);
        end
    end
    
    %计算弧长向量
    for i=2:N(1)
        tmp=0;
        for j=2:i
            tmp=tmp+sqrt((point(j,1)-point(j-1,1))^2+(point(j,2)-point(j-1,2))^2)
        end
        s(i)=tmp/total;
    end
    
    %求解变换矩阵fai
    c=1;
    %计算tao向量[0,0,0,0,...,1,1,1,1]
    for i=1:p+4
        if(i<5) tao(i)=0;
        else if (i>p) tao(i)=1;
            else
                tao(i)=c/(p-3);
                c=c+1;
            end
        end
    end
    fai=zeros(N(1),p);
    for n=1:N(1)
        for i=1:p
            %m=4;
            fai(n,i)=Bbase(i,4,tao,s(n));
        end
    end
    
    %求解CXY向量
    CXY=pinv(fai)*point; %pinv(fai),fai的伪逆
    
    %拟合点数据存储，CXY存入相应txt文件
     if filenum<20
        savef=['G:\\CAVIAR\\3\\BMVC2008_caviar_data\\data3_spline_p=' num2str(p) '\\anomalous_' num2str(filenum) '.txt'];
    else if filenum<41
            savef=['G:\\CAVIAR\\3\\BMVC2008_caviar_data\\data3_spline_p=' num2str(p) '\\normal_' num2str(filenum) '.txt'];
        else 
            savef=['G:\\CAVIAR\\3\\BMVC2008_caviar_data\\data3_spline_p=' num2str(p) '\training_' num2str(filenum) '.txt'];
        end
     end
    
    fidout = fopen(savef,'wt');
    if fidout<0
        disp('error can not open');
    else
        for i=1:p
            fprintf(fidout,'%f  %f\n',CXY(i,1),CXY(i,2));
        end
        fclose(fidout);
    end
%{  
%====  绘图 轨迹+样条控制点  ====
 
    %绘出轨迹和拟合点坐标
    %figure;
    bg=imread('G:\\CAVIAR\\3\\bg.jpg');
    clf;
    %%% fig=figure;
    imshow(bg);
    hold on;
    %绘制轨迹
    for i=1:N(1)
        pX(i)=point(i,1);
        pY(i)=point(i,2);
    end
    plot(pX,pY,'.');%绘制异常轨迹时用y（黄色）
    hold on;
    %绘制拟合点
    for i=1:p
        CX(i)=CXY(i,1);
        CY(i)=CXY(i,2);
    end
    plot(CX,CY,'rd');
    
    %%% saveas(fig,['G:\\CAVIAR\\3\\Data0419\\image\\train2200\\train_' num2str(filenum) '.jpg'],'jpg');
    %保存绘制图像
    set(gcf,'color',[1 1 1]);
    frame(i)=getframe(gcf);
    imwrite(frame(i).cdata,['G:\\CAVIAR\\3\\BMVC2008_caviar_data\\test_normal_21\\normal_' num2str(filenum) '.jpg']);
    disp('   saving image   ');
%}
end %文件遍历循环
toc;



   