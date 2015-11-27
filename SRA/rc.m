% Date:   2011-5-26
% Author: Julie(Ce) Li
% Reconstruction coefficient
%
%************ rc ����*********************************************

%ver0.0����ع�ϵ��w
%���룺train,,test
%�����w
function w = rc(train,test)
[M,N]=size(train);
cvx_begin
    variable w(N);
    minimize(norm(w,1));
subject to
train*w == test;
cvx_end
end