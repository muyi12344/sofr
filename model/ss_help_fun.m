% Helper function to solve for dC, dF, L, gammaL, K in steady state
% var: dC, dF, C, gammaL, K
% para: N T G beta alpha theta omega xiC xiF delta sigma


function F=ss_help_fun(var, D, T, beta, alpha, phi, omega, thetaD, thetaC, lambdaD, lambdaC, xiC, delta, gammaI, Abar, Gbar)
rI=var(1);
rL=var(2);
rB=var(3);
dD=var(4);
dC=var(5);
dF=var(6);
I=var(7);
B=var(8);
L=var(9); 
K=var(10);
C=var(11);
A=var(12);
G=var(13);
% equation 1
F(1)=beta*gammaI+beta^2*thetaD*(1-gammaI)*I^(lambdaD-1)-1/(1+rI);
% equation 2
F(2)=gammaI*I-I/(1+rI)+thetaD/lambdaD*(1-gammaI)*I^lambdaD-dD;
% equation 3
F(3)=beta*(gammaI-1)+beta^2*thetaC*(1-gammaI)*I^(lambdaC-1)-1/(1+rI)+1/(1+rB);
% equation 4
F(4)=phi*I-B;
% equation 5
F(5)=I/(1+rI)-gammaI*I-thetaC/lambdaC*(1-gammaI)*I^lambdaC-xiC*(1-gammaI)+L-L/(1+rL)+B-B/(1+rB)-dC;
% equation 6
F(6)=rI+omega-rL;
% equation 7
F(7)=beta*(1+rL)-(1-delta)*beta^2*(1+rL)-A*alpha*K^(alpha-1);
% equation 8
F(8)=L/(1+rL)-delta*K;
% equation 9
F(9)=A*K^alpha-L-dF;
% equation 10
F(10)=dD+dC+dF+D-T-C;
% equation 11
F(11)=G+B-B/(1+rB)-T;
% equation 12
F(12)=A-Abar;
% equation 13
F(13)=G-Gbar;








