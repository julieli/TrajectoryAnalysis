function CXY = SSpline(data,p)
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