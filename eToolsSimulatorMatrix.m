%--------------------------------------------------------------------------
% Edited by bbl
% Date: 2022-05-29(yyyy-mm-dd)
% AC仿真器,SolveSystemOfLinearEquations
%--------------------------------------------------------------------------
tic;
% 参数配置
R0 = 1;
V0 = 1;
L1 = 0.77;
C2 = 1.85;
L3 = 1.85;
C4 = 0.77;
RL = 1;
N = 300;% 扫描点数
f0 = logspace(log10(1e-3), log10(1e1), N);
Vo = [];
for ii=1:N
    % 频率计算
    f  = f0(ii);
    w  = 2.*pi.*f;
    s  = 1i.*w;
    % 阻抗计算
    Z1 = R0+s*L1;
    Z2 = 1/(s*C2);
    Z3 = s*L3;
    Z4 = 1/(s*C4);
    Z5 = RL;
    % 构造Z矩阵
    Z = [Z1+Z2,-Z2,0;-Z2,Z2+Z3+Z4,-Z4;0,-Z4,Z4+Z5];
    b = [V0;0;0];
    % UL分解，前向代换和回代
    [L, U] = funLUDecomposition(Z);
    [z]    = funUpsub(L, b);
    [Io]   = funBacksub(U, z);
%     Io = Z^(-1)*b;
    Vo(ii) = abs(Io(3)*RL);
end
% 绘图显示
semilogx(f0, 20.*log10(Vo), '-r', 'LineWidth', 2);
grid on;
ylim([-20, 0]);
xlabel('Freq/Hz');
ylabel('Mag/dB');

toc;

