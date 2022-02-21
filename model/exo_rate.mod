var rI rL rB dD dC dF I B L K Y C A;
varexo ea eb;
parameters beta alpha phi thetaD thetaC lambdaD lambdaC xiC delta gammaI gammaL omega Abar Bbar Ibar rhoB rhoA sigmaB sigmaA;

//initialization of parameters
beta=0.998;
alpha=0.33;
phi=5;
thetaD=0.6;
thetaC=0.1;
lambdaD=1/2;
lambdaC=3/2;
xiC=0.3;
delta=0.03;
gammaI=0.99;
gammaL=0.9;
omega=0.009;
Abar=0.1;
Bbar=0.1;
Ibar=1;
rhoA=0.9;
rhoB=0.9;
sigmaA=0.01;
sigmaB=0.01;



model;
% interbank lending rate
1/(C*(1+rI))=beta/C(+1)*(gammaI+thetaD*(1-gammaI)*I^(lambdaD-1));
% deposit bank profit
dD=gammaI*I(-1)-I/(1+rI)+thetaD/lambdaD*(1-gammaI)*I(-1)^lambdaD;
% government bond rate
1/C*(1/(1+rI)-phi/(1+rB))=beta/C(+1)*(gammaI+thetaC*(1-gammaI)*I^(lambdaC-1)-phi);
% collareral requirement
B=phi*(I-Ibar);
% commercial bank profit
dC=I/(1+rI)-gammaI*I(-1)-thetaC/lambdaC*(1-gammaI)*I(-1)^lambdaC-xiC*(1-gammaI)+gammaL*L(-1)-L/(1+rL)+B(-1)-B/(1+rB);
% business loan demand
1/C*A*alpha*K^(alpha-1)=gammaL*beta/C(+1)*(1+rL)-gammaL*(1-delta)*beta^2/C(+2)*(1+rL(+1));
% capital accumulation
K=(1-delta)*K(-1)+L/(1+rL);
% business loan rate
rL=rI+omega;
% firm profit
dF=A*K^alpha-L(-1);
% consumption
C=dD+dC+dF;
% output
Y=A*K^alpha;
% govt bond
B=Bbar+rhoB*B(-1)+eb;
% productivity
A=Abar+rhoA*A(-1)+ea;
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
Y=12;
end;


shocks;
var eb;
stderr sigmaB;
var ea;
stderr sigmaA;
end;




options_.dynatol.f=0.0001;

steady(solve_algo = 0, maxit=10000);
check;
stoch_simul(irf=30, irf_shocks=(eb), order=1);





