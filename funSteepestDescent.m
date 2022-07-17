%--------------------------------------------------------------------------
% Edited by bbl
% Date: 2022-07-13(yyyy-mm-dd)
% 梯度下降
%--------------------------------------------------------------------------
function [xh] = funSteepestDescent(x0, A, b, Err)
% ----------------------------梯度下降法----------------------------
x  = x0;
xh = x;
r  = b-A*x;
dt = r'*r;
% d0 = dt;
iimax = 50;
for ii = 1:iimax
    q  = A*r;
    a  = dt/(r'*q);
    x  = x + a*r;
    xh = x;
    r  = b - A*x;
    dt = r'*r;
    if dt < Err
        break;
    end
end

