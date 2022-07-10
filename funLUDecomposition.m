%--------------------------------------------------------------------------
% Edited by bbl
% Date: 2022-06-12(yyyy-mm-dd)
% UL分解
%--------------------------------------------------------------------------
function [L, U] = funLUDecomposition(A)
[m, n] = size(A);
U = A;
L = zeros(m,n);
% 高斯消元法
for kk=1:m
    akk = U(kk,kk);
    for jj=kk:n
        U(kk, jj) = U(kk, jj)/akk;
    end
    L(kk, kk) = akk;
    for ii=(kk+1):m
        aik = U(ii,kk);
        for jj=kk:n
            U(ii,jj)=U(ii,jj)-aik*U(kk, jj);
        end
        L(ii, kk) = aik;
    end
end
end