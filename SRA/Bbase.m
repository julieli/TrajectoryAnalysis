%2010.11.25 Julie(Ce�� Li
% function result = Bbase(i,m,tao,t)
%
% Date:   2010-11-25
% Author: Ce Li
%************m�ηǾ���B����������************
function result = Bbase(i,m,tao,t)

%��i��m��B������,Deboor���Ƶݹ��㷨
%tΪ����,tao(i)<=t<tao(i+1),m=0ʱresult=1;

if (m==1) 
    if tao(i)<=t && t<tao(i+1) %ע��1=u(i)<=t<u(i+1)=1ʱ�����,����Ҫ��t<=u(i+1);
        result=1;
        return;
    else
        result=0;
        return;
    end
end

    if (tao(i+m-1)-tao(i)==0) 
        alpha=0;
    else
        alpha=(t-tao(i))/(tao(i+m-1)-tao(i));
    end
    if (tao(i+m)-tao(i+1)==0)
         beta=0;
    else
        beta=(tao(i+m)-t)/(tao(i+m)-tao(i+1));
    end
result=alpha*Bbase(i,m-1,tao,t)+beta*Bbase(i+1,m-1,tao,t);
end