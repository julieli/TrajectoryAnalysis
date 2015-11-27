%2010.11.25 Julie(Ce） Li
% function result = Bbase(i,m,tao,t)
%
% Date:   2010-11-25
% Author: Ce Li
%************m次非均匀B样条基函数************
function result = Bbase(i,m,tao,t)

%第i段m次B样条基,Deboor递推递归算法
%t为变量,tao(i)<=t<tao(i+1),m=0时result=1;

if (m==1) 
    if tao(i)<=t && t<tao(i+1) %注意1=u(i)<=t<u(i+1)=1时的情况,这里要用t<=u(i+1);
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