%--------------------------------------------------------------------------
% Edited by bbl
% Date: 2022-07-13(yyyy-mm-dd)
% 双共轭梯度
%--------------------------------------------------------------------------
function [xmin] = funBiConjugateGradients(x, A, b, Err)
% ----------------------------双共轭梯度法----------------------------
r  = b-A*x;
rr = r;
p  = r;
pp = r;
delta_n = r'*r;
norm_n  = delta_n;
N = length(b);
xmin      = x; % 记录最小返回值
delta_min = norm_n; % 记录最小范数
for ii=1:N
    q  = A*p;
    qq = A'*pp;
    alpha = delta_n/(pp'*q);
    x = x + alpha*p;
%     r = b - A*x;
    r  = r  - alpha*q;
    rr = rr - conj(alpha)*qq;
    delta_o = delta_n;
    delta_n = rr'*r;
    norm_n  = sqrt(r'*r);
    % 记录最小误差对应的x值
    if norm_n < delta_min
        delta_min = norm_n;
        xmin      = x;
    end
    if norm_n < Err
        break;
    end
    beta = delta_n/delta_o;
    p  = r  + beta*p;
    pp = rr + conj(beta)*pp;
end
