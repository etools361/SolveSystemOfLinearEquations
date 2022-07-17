%--------------------------------------------------------------------------
% Edited by bbl
% Date: 2022-07-17(yyyy-mm-dd)
% 各种迭代方法求解对比，单频率点
%--------------------------------------------------------------------------
% 分析频率点
f  = 1/2/pi;
fprintf('freq = %0.4f Hz\n', f);
% 输入参数
R1 = 1;
C2 = 1;
L3 = 2;
C4 = 1;
R5 = 1;
fprintf('RS = %0.3f Ohm\n', R1);
fprintf('C2 = %0.3f F\n', C2);
fprintf('L3 = %0.3f H\n', L3);
fprintf('C4 = %0.3f F\n', C4);
fprintf('RL = %0.3f Ohm\n', R5);
% 参数计算
w  = 2.*pi.*f;
s  = 1i.*w;
Z1 = R1;
Z2 = 1/(s*C2);
Z3 = s*L3;
Z4 = 1/(s*C4);
Z5 = R5;
% 构造矩阵 V, Z matrix
V  = [1;0;0];
Z  = [Z1+Z2,-Z2,0;-Z2,Z2+Z3+Z4,-Z4;0,-Z4,Z4+Z5];
% Z  = [Z1+Z2,-Z2,-1;Z2,Z2+Z3+Z4,-Z4;0,Z4,Z4+Z5];
%% UL分解
% Z*Io=E,矩阵计算,UL分解
[L, U] = funLUDecomposition(Z);
[z]    = funUpsub(L, V);
[Io]   = funBacksub(U, z);
Vo     = abs(Io(3)*1);
fprintf('Vo(UL)        = %0.3f V\n', Vo);
%% 最速下降
Err = 1e-6;
A   = Z;
b   = V;
x0  = [0; 0; 0];
[x1,~] = cgs(A,b,Err);
fprintf('Vo(CGS)       = %0.3f V\n', abs(x1(3)*1));
[x2,~] = pcg(A,b,Err,100);
fprintf('Vo(PCG)       = %0.3f V\n', abs(x2(3)*1));
[x3,~] = bicg(A,b,Err);
fprintf('Vo(BiCG)      = %0.3f V\n', abs(x3(3)*1));
[x4,~] = bicgstab(A,b,Err);
fprintf('Vo(BiCGSTAB)  = %0.3f V\n', abs(x4(3)*1));
[x5,~] = bicgstabl(A,b,Err);
fprintf('Vo(BiCGSTAB1) = %0.3f V\n', abs(x5(3)*1));
%% My CG迭代
[xh2] = funBiConjugateGradients(x0, A, b, Err);
fprintf('Vo(myBiCG)    = %0.3f V\n', abs(xh2(3)));


