%--------------------------------------------------------------------------
% Edited by bbl
% Date: 2022-07-12(yyyy-mm-dd)
% UL分解
%--------------------------------------------------------------------------
% 分析频率点
freq = logspace(log10(1e-2), log10(10), 20);
NN   = length(freq);
xd0  = [];xd1  = [];xd2  = [];xd3  = [];xd4  = [];xd5  = [];xd6  = [];xd7  = [];
for kk=1:NN
    f  = freq(kk);
    % 输入参数
    R1 = 1;
    C2 = 1;
    L3 = 2;
    C4 = 1;
    R5 = 1;
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
%     fprintf('Vo = %0.3f V\n', Vo);
    xd0(kk) = (Vo);
    %% 最速下降
    Err = 1e-7;
    A   = Z;
    b   = V;
    x1 = cgs(A,b,Err);
    xd1(kk) = abs(x1(end));
    xd1(xd1==0) = 1e-7;
%     x2 = pcg(A,b,Err);
%     xd2(xd2==0) = 1e-7;
%     xd2(kk) = abs(x2(end));
    x3 = bicg(A,b,Err);
    xd3(kk) = abs(x3(end));
    xd3(xd3==0) = 1e-7;
    x4 = bicgstab(A,b,Err);
    xd4(kk) = abs(x4(end));
    xd4(xd4==0) = 1e-7;
    x5 = bicgstabl(A,b,Err);
    xd5(kk) = abs(x5(end));
    xd5(xd5==0) = 1e-7;
    x0 = zeros(length(b), 1);
    [x6] = funBiConjugateGradients(x0, A, b, Err);
    xd6(kk) = abs(x6(end));
    xd6(xd6==0) = 1e-7;
%     %% CG迭代
    semilogx(freq(1:kk), 20*log10(xd0(1:kk)), '-^k', 'LineWidth', 1);
    hold on;
    semilogx(freq(1:kk), 20*log10(xd1(1:kk)), '-*r', 'LineWidth', 1);
%     semilogx(freq(1:kk), 20*log10(xd2(1:kk)), '-+b', 'LineWidth', 1);
    semilogx(freq(1:kk), 20*log10(xd3(1:kk)), '-om', 'LineWidth', 1);
    semilogx(freq(1:kk), 20*log10(xd4(1:kk)), '-<g', 'LineWidth', 1);
    semilogx(freq(1:kk), 20*log10(xd5(1:kk)), '--c', 'LineWidth', 1);
    semilogx(freq(1:kk), 20*log10(xd6(1:kk)), '-y', 'LineWidth', 1);
%     semilogx(freq(1:kk), 20*log10(xd6(1:kk)), '->k', 'LineWidth', 1);
%     semilogx(freq(1:kk), 20*log10(xd7(1:kk)), '-y', 'LineWidth', 1);
    hold off;
    grid on;
    xlabel('Freq/Hz');
    ylabel('Mag/dB');
    title('Mag VS. Freq');
    legend({'UL','cgs', 'bicg', 'bicgstab', 'bicgstab1', 'mybicg'}, 'location', 'northeast');
%     ylim([min(20*log10(xd0(1:kk))), 0]);
    drawnow;
end

