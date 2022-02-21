var r rI rL rB dD dC dF I B L K C Y A multi multi2;
varexo ea eb;
parameters beta alpha phi thetaD thetaC thetaF thetaB lambdaD lambdaC lambdaF lambdaB etaB etaL etaI xiC delta gammaI gammaL Abar Bbar Lbar Ibar rhoB rhoA sigmaB sigmaA;

//initialization of parameters
beta=0.998;
alpha=0.4328;
phi=0.7;
thetaD=0.6;
thetaC=1;
thetaF=0.6;
thetaB=0.6;
lambdaD=1/2;
lambdaC=2;
lambdaF=1/2;
lambdaB=2;
etaB=1;
etaL=0.5;
etaI=0.8;
xiC=0.2;
delta=0.03;
gammaI=0.99;
gammaL=0.9;
Abar=0.1;
Bbar=0.1;
Lbar=2;
Ibar=0.5;
rhoA=0.9;
rhoB=0.9;
sigmaA=0.01;
sigmaB=0.01;



model;
% interbank lending rate
1/(C*(1+rI))=beta/C(+1)*(gammaI+thetaD*(1-gammaI)*I^(lambdaD-1));
% deposit bank profit
dD=gammaI*I(-1)-I/(1+rI)+thetaD/lambdaD*(1-gammaI)*I(-1)^lambdaD;
% business loan rate
1/C*multi-beta/C(+1)*etaL*gammaL*multi(+1)=(gammaL+thetaF*(1-gammaL)*L^(lambdaF-1))*beta/C(+1)-1/C*1/(1+rL);
% govt bond rate
beta/C(+1)*multi(+1)*(etaI*gammaI-etaB*phi/(1+rI))=1/C*(1/(1+rI)-phi/((1+rB)*(1+rI)))-beta/C(+1)*(gammaI+thetaC*(1-gammaI)*I^(lambdaC-1)-phi);
% collareral requirement
B=phi*(I/(1+rI)-Ibar);
% capital requirement
L=etaL*gammaL*L(-1)+etaB*B(-1)-etaI*gammaI*I(-1)+Lbar;
% commercial bank profit
dC=I/(1+rI)-gammaI*I(-1)-thetaC/lambdaC*(1-gammaI)*I(-1)^lambdaC-xiC*(1-gammaI)+gammaL*L(-1)-L/(1+rL)+thetaF/lambdaF*(1-gammaL)*L(-1)^lambdaF+B(-1)-B/(1+rB);
% capital demand
1/C*multi2*1/(1+rL)=beta/C(+1)*(gammaL+thetaB*(1-gammaL)*L^(lambdaB-1));
1/C*A*alpha*K^(alpha-1)+beta/C(+1)*multi2(+1)*(1-delta)=1/C*multi2;
% capital accumulation
K=(1-delta)*K(-1)+L/(1+rL);
% firm profit
dF=A*K^alpha-L(-1)-thetaB/lambdaB*(1-gammaL)*L(-1)^lambdaB;
% consumption
C=dD+dC+dF;
% govt bond
B=Bbar+rhoB*B(-1)+eb;
% productivity
A=Abar+rhoA*A(-1)+ea;
% output
Y=A*K^alpha;
% risk-free rate
1/C=beta/C(+1)*(1+r);
end;


steady_state_model;
B=1;
A=1;
I=ss_I(beta, phi, thetaD, lambdaD, gammaI, Ibar, B);
rI=ss_rI(beta, phi, thetaD, lambdaD, gammaI, Ibar, B);
L=(etaB*B-etaI*gammaI*I+Lbar)/(1-gammaL*etaL);
dD=(gammaI-1/(1+rI))*I+thetaD/lambdaD*(1-gammaI)*I^(lambdaD);
K=(L*beta*(gammaL+thetaB*(1-gammaL)*L^(lambdaB-1))*(1-beta*(1-delta))/(alpha*delta))^(1/alpha);
rL=L/(delta*K)-1;
multi2=(1+rL)*beta*(gammaL+thetaB*(1-gammaL)*L^(lambdaB-1));
multi=((gammaL+thetaF*(1-gammaL)*L^(lambdaF-1))*beta-1/(1+rL))/(1-beta*etaL*gammaL);
rB=phi/((1+rI)*(1/(1+rI)-beta*(gammaI+thetaC*(1-gammaI)*I^(lambdaC-1)-phi)-beta*multi*(etaI*gammaI-etaB*phi/(1+rI))))-1;
dC=I/(1+rI)-gammaI*I-thetaC/lambdaC*(1-gammaI)*I^lambdaC-xiC*(1-gammaI)+gammaL*L-L/(1+rL)+thetaF/lambdaF*(1-gammaL)*L^lambdaF+B-B/(1+rB);
dF=K^alpha-L-thetaB/lambdaB*(1-gammaL)*L^lambdaB;
C=dD+dC+dF;
Y=K^alpha;
r=1/beta-1;
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
multi=1;
multi2=1;
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





