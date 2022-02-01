% Equations to solve for dC, dF, L, gammaL, K in steady state
% var: dC, dF, L, gammaL, K
% para: N T G beta alpha theta omega xiC xiF delta sigma

function F=ss_help_fun(var, para)
N=para(1);
T=para(2);
G=para(3);
beta=para(4);
alpha=para(5);
theta=para(6);
omega=para(7);
xiC=para(8);
xiF=para(9);
delta=para(10);
sigma=para(11);

B=xiC/(1-beta*theta);
I=xiC/(1-beta*theta);
D=xiC/(1-beta*theta);
gammaI=(1-(T-G)*(1-beta*theta)/xiC)/(beta^2*theta*(1-beta*theta));
dD=((1-theta-beta)*gammaI+theta)*I+(beta-1)*D;


% equation 2
F(1)=(1-beta)*D+(1-alpha)*(var(5)/N)^alpha*N+dD+var(1)+var(2)-var(3)/xiF-T;
% equation 9
F(2)=(1-beta)*var(3)*gammaL+(beta-1)*I*gammaI-(1-gammaI)*(theta*I+xiC)+(1-beta*(gammaI-(1-gammaI)*(beta*theta-1)))*B-dC;
% equation 18
F(3)=(1+1/(beta*var(4))-1)*var(4)*(beta-(1-delta)*beta^2)-alpha*(var(5)/N)^(alpha-1);
% equation 15
F(4)=beta*var(4)*var(3)-delta*var(5);
% equation 16
F(5)=var(5)^alpha*N^(1-alpha)-(1-alpha)*(var(5)/N)^alpha*N-(xiF+delta*var(5)*(var(3)-xiF)/(beta*var(3)))-var(2);








