% Date:   2011-5-24
% Author: Ce Li

%************��������ѵ���켣************
  
tic;%�������м�ʱ
%mkdir([cd,'image\\train2200']); %�½��洢���Ŀ¼
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
            tmp=tmp+sqrt((point(j,1)-point(j-1,1))^2+(point(j,2)-point(j-1,2))^2)
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
    fai=zeros(N(1),p);
    for n=1:N(1)
        for i=1:p
            %m=4;
            fai(n,i)=Bbase(i,4,tao,s(n));
        end
    end
    
    %���CXY����
    CXY=pinv(fai)*point; %pinv(fai),fai��α��
    
    %��ϵ����ݴ洢��CXY������Ӧtxt�ļ�
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
%====  ��ͼ �켣+�������Ƶ�  ====
 
    %����켣����ϵ�����
    %figure;
    bg=imread('G:\\CAVIAR\\3\\bg.jpg');
    clf;
    %%% fig=figure;
    imshow(bg);
    hold on;
    %���ƹ켣
    for i=1:N(1)
        pX(i)=point(i,1);
        pY(i)=point(i,2);
    end
    plot(pX,pY,'.');%�����쳣�켣ʱ��y����ɫ��
    hold on;
    %������ϵ�
    for i=1:p
        CX(i)=CXY(i,1);
        CY(i)=CXY(i,2);
    end
    plot(CX,CY,'rd');
    
    %%% saveas(fig,['G:\\CAVIAR\\3\\Data0419\\image\\train2200\\train_' num2str(filenum) '.jpg'],'jpg');
    %�������ͼ��
    set(gcf,'color',[1 1 1]);
    frame(i)=getframe(gcf);
    imwrite(frame(i).cdata,['G:\\CAVIAR\\3\\BMVC2008_caviar_data\\test_normal_21\\normal_' num2str(filenum) '.jpg']);
    disp('   saving image   ');
%}
end %�ļ�����ѭ��
toc;



   