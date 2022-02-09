var r rI rL rB dD dC dF I B L K w C gammaI gammaL D;

parameters G N T beta alpha theta xiC xiF delta;

//initialization of parameters
G=0.2;
N=0.7;
T=0.23;
beta=0.9963;
alpha=0.33;
theta=0.8;
xiC=0.1;
xiF=0.15;
delta=0.9;



model;

[name='equation 3']
1/C=beta*(1+r)*(1/C(+1));
[name='equation 2']
C+D/(1+r)+T=w*N+D(-1)+dD+dC+dF;
[name='equation 6']
D=I;
[name='equation 7']
1/(C*(1+rI))=beta*1/C(+1)*gammaI(+1);
[name='equation 5']
dD=gammaI*I(-1)+D/(1+r)-D(-1)-I/(1+rI)+theta*(1-gammaI(-1))*I(-2);
[name='equation 11']
1/C*(1/(1+rI)-1/(1+rB))=beta*1/C(+1)*(gammaI(+1)-1)+beta^2*1/C(+2)*theta*(1-gammaI(+1));
[name='equation 12']
1/(C*(1+rL))=beta*1/C(+1)*gammaL(+1);
[name='equation 13']
1/C*(B(-1)-xiC)=(beta*1/C(+1)*theta*B(-1));
[name='equation 9']
dC=gammaL*L(-1)+I/(1+rI)-gammaI*I(-1)-L/(1+rL)-theta*(1-gammaI(-1))*I(-2)-xiC*(1-gammaI)+B(-1)-B/(1+rB);
[name='equation 10']
I=B;
[name='equation 17']
(1-alpha)*(K/N)^alpha=w;
[name='equation 18']
1/C*alpha*(K/N)^(alpha-1)=beta*1/C(+1)*(1+rL)*gammaL(+1)-(1-delta)*beta^2*1/C(+2)*(1+rL(+1))*gammaL(+2);
[name='equation 19']
xiF=L(-1);
[name='equation 15']
K=(1-delta)*K(-1)+L/(1+rL);
[name='equation 16']
dF=K^alpha*N^(1-alpha)-w*N-gammaL*L(-1)-xiF*(1-gammaL);
[name='equation 20']
G+B(-1)=B/(1+rB)+T;
end;




initval;

r=0.03;
rI=0.08;
rL=0.09;
rB=0.06;
dD=0.03; 
dC=-0.01;
dF=-0.01;
I=0.5;
B=0.5;
L=0.15;
K=0.15;
w=0.4;
C=0.9;
gammaI=0.9;
gammaL=0.9;
D=0.5;

end;


steady_state_model;

G=0.2;
r=1/beta-1;
B=xiC/(1-beta*theta);
I=B;
gammaI=(1-(T-G)*(1-beta*theta)/xiC+beta*(beta*theta-1))/(beta^2*theta);
rI=1/(beta*gammaI)-1;
rB=1/(beta*(1-beta*theta*(1-gammaI)))-1;
D=I;
dD=((1-theta-beta)*gammaI+theta)*I+(beta-1)*D;
L=xiF;
K=((1-(1-delta)*beta)/alpha)^(1/(alpha-1))*N;
gammaL=delta*K/(beta*L);

%[dC, dF, C, gammaL, K]=ss_help(0.1, 0.1, 0.2, 0.9, 0.9,  N, T, G, beta, alpha, theta, omega, xiC, xiF, delta);

rL=1/(beta*gammaL)-1;
w=(1-alpha)*(K/N)^alpha;
dC=gammaL*L+(beta-1)*gammaI*I-L*beta*gammaL-theta*(1-gammaI)*I-xiC*(1-gammaI)+B-B/(1+rB);
dF=K^alpha*N^(1-alpha)-w*N-gammaL*L-xiF*(1-gammaL);
C=(1-beta)*D+w*N+dD+dC+dF-T;

end;









steady(maxit=10000);
check;
model_diagnostics;


