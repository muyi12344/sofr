var rI rL rB dD dC dF I B L K C A G;
varexo ea eg;
parameters T D beta alpha phi omega thetaD thetaC lambdaD lambdaC xiC delta gammaI Abar Gbar;

//initialization of parameters
D=0;
T=0.2052;
beta=0.9963;
alpha=0.4;
phi=1;
omega=0.009;
thetaD=0.6;
lambdaD=2/3;
thetaC=0.5;
lambdaC=1;
xiC=0.2;
delta=0.005;
gammaI=0.99;
Abar=1;
Gbar=0.2;



model;
% equation 1
1/(C*(1+rI))=beta/C(+1)*gammaI+beta^2/C(+2)*thetaD*(1-gammaI)*I^(lambdaD-1);
% equation 2
dD=gammaI*I(-1)-I/(1+rI)+thetaD/lambdaD*(1-gammaI)*I(-2)^lambdaD;
% equation 3
1/C*(1/(1+rI)-1/(1+rB))=beta/C(+1)*(gammaI-1)+beta^2/C(+2)*thetaC*(1-gammaI)*I^(lambdaC-1);
% equation 4
B=phi*I;
% equation 5
dC=I/(1+rI)-gammaI*I(-1)-thetaC/lambdaC*(1-gammaI)*I(-2)^lambdaC-xiC*(1-gammaI)+L(-1)-L/(1+rL)+B(-1)-B/(1+rB);
% equation 6
rL=rI+omega;
% equation 7
1/C*A*alpha*K^(alpha-1)=beta/C(+1)*(1+rL)-(1-delta)*beta^2/C(+2)*(1+rL(+1));
% equation 8
K=(1-delta)*K(-1)+L/(1+rL);
% equation 9
dF=A*K^alpha-L(-1);
% equation 10
C=dD+dC+dF+D-T;
% equation 11
G+B(-1)=B/(1+rB)+T;
% equation 12
G=Gbar+eg;
% equation 13
A=Abar+ea;
end;



initval;
rI=0.0086;
rL=0.0176;
rB=0.004;
dD=0; 
dC=0.058;
dF=9.8;
I=1.1;
B=1.1;
L=2.946;
K=579;
C=9.6488;
end;


shocks;
var eg;
stderr 0.001;
var ea;
stderr 0.001;
end;




options_.dynatol.f=0.0001;

steady(solve_algo = 0, maxit=10000);
check;



