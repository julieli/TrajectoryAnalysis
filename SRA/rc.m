% Date:   2011-5-26
% Author: Julie(Ce) Li
% Reconstruction coefficient
%
%************ rc 函数*********************************************

%ver0.0求解重构系数w
%输入：train,,test
%输出：w
function w = rc(train,test)
[M,N]=size(train);
cvx_begin
    variable w(N);
    minimize(norm(w,1));
subject to
train*w == test;
cvx_end
end