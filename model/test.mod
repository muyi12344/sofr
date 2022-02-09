var rI rB dD dC I B C G;
varexo eg;

parameters D T beta thetaD thetaC sigmag gammaI;

//initialization of parameters
D=0.5;
T=0.25;
beta=0.9963;
thetaD=0.2;
thetaC=0.1;
sigmag=0.05;
gammaI=0.9;



model;
C+T=dD+dC+D;
1/(C*(1+rI))=beta*1/C(+1)*gammaI+beta^2/C(+2)*thetaD*(1-gammaI)^(1/2)*I^(-1/2);
dD=gammaI*I(-1)-I/(1+rI)+2*thetaD*((1-gammaI)*I(-2))^(1/2);
1/C*(1/(1+rI)-1/(1+rB))=beta*1/C(+1)*(gammaI-1)+beta^2*1/C(+2)*thetaC*(1-gammaI)^2*I;
dC=I/(1+rI)-gammaI*I(-1)-1/2*thetaC*((1-gammaI)*I(-2))^(2)+B(-1)-B/(1+rB);
I=B;
G+B(-1)=B/(1+rB)+T;
G=0.2+eg;
end;

shocks;
var eg;
stderr sigmag;
end;



initval;

rI=0.08;
rB=0.03;
dD=0.03; 
dC=-0.01;
I=0.5;
B=0.5;
C=0.9;

end;









steady(maxit=10000);
check;
stoch_simul;
