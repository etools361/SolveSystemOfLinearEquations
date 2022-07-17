%--------------------------------------------------------------------------
% Edited by bbl
% Date: 2022-07-13(yyyy-mm-dd)
% 共轭梯度
%--------------------------------------------------------------------------
function [xmin] = funConjugateGradients(x, A, b, Err)
% ----------------------------共轭梯度法----------------------------
r = b-A*x;
d = r;
delta_n = r'*r;
N = length(b);
xmin      = x; % 记录最小返回值
delta_min = delta_n; % 记录最小范数
for ii=1:N
    q = A*d;
    alpha = delta_n/(d'*q);
    x = x + alpha*d;
%     r = b - A*x;
    r = r - alpha*q;
    delta_o = delta_n;
    delta_n = r'*r;
    % 记录最小误差对应的x值
    if delta_n < delta_min
        delta_min = delta_n;
        xmin      = x;
    end
    if delta_n < Err
        break;
    end
    beta = delta_n/delta_o;
    d = r + beta*d;
end
