% Helper function to solve for dC, dF, L, gammaL, K in steady state
% var: dC, dF, C, gammaL, K
% para: N T G beta alpha theta omega xiC xiF delta sigma


function F=ss_help_fun(var, N, T, G, beta, alpha, theta, omega, xiC, xiF, delta)
r=1/beta-1;
B=xiC/(1-beta*theta);
I=B;
gammaI=(1-(T-G)*(1-beta*theta)/xiC+beta*(beta*theta-1))/(beta^2*theta);
rI=1/(beta*gammaI)-1;
rB=1/(beta*(gammaI-(1-gammaI)*(beta*theta-1)))-1;
D=I;
dD=((1-theta-beta)*gammaI+theta)*I+(beta-1)*D;
L=xiF;

% equation 2
F(1)=(1-beta)*D+(1-alpha)*(var(5)/N)^alpha*N+dD+var(1)+var(2)-var(3)-T;
% equation 9
F(2)=var(4)*L+(beta-1)*gammaI*I-L*beta*var(4)-theta*(1-gammaI)*I-xiC*(1-gammaI)+B-B/(1+rB)-var(1);
% equation 18
F(3)=1/beta*(beta-(1-delta)*beta^2)-alpha*(var(5)/N)^(alpha-1);
% equation 15
F(4)=beta*var(4)*L-delta*var(5);
% equation 16
F(5)=var(5)^alpha*N^(1-alpha)-(1-alpha)*(var(5)/N)^alpha*N-var(4)*L-xiF*(1-var(4));








