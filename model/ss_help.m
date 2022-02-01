% Solve for  dC, dF, L, gammaL, K in steady state

function [dC, dF, C, gammaL, K]=ss_help(dC0, dF0, C0, gammaL0, K0,  N, T, G, beta, alpha, theta, omega, xiC, xiF, delta)
fun=@(var)ss_help_fun(var,  N, T, G, beta, alpha, theta, omega, xiC, xiF, delta)
x0=[dC0, dF0, C0, gammaL0, K0];
lb=[-Inf,-Inf,0,0,0];
ub=[Inf, Inf, Inf, 1, Inf];
var=lsqnonlin(fun,x0,lb,ub);
dC=var(1);
dF=var(2);
C=var(3);
gammaL=var(4);
K=var(5);