function g1 = static_g1(T, y, x, params, T_flag)
% function g1 = static_g1(T, y, x, params, T_flag)
%
% File created by Dynare Preprocessor from .mod file
%
% Inputs:
%   T         [#temp variables by 1]  double   vector of temporary terms to be filled by function
%   y         [M_.endo_nbr by 1]      double   vector of endogenous variables in declaration order
%   x         [M_.exo_nbr by 1]       double   vector of exogenous variables in declaration order
%   params    [M_.param_nbr by 1]     double   vector of parameter values in declaration order
%                                              to evaluate the model
%   T_flag    boolean                 boolean  flag saying whether or not to calculate temporary terms
%
% Output:
%   g1
%

if T_flag
    T = test.static_g1_tt(T, y, x, params);
end
g1 = zeros(10, 10);
g1(1,3)=(-1);
g1(1,4)=(-1);
g1(1,7)=1;
g1(2,1)=(-y(7))/(y(7)*(1+y(1))*y(7)*(1+y(1)));
g1(2,5)=(-(T(7)*getPowerDeriv(y(5),(-0.5),1)));
g1(2,7)=(-(1+y(1)))/(y(7)*(1+y(1))*y(7)*(1+y(1)))-(params(7)*(-params(3))/(y(7)*y(7))+T(1)*T(2)*params(4)*(-T(5))/(y(7)*y(7)));
g1(3,1)=(-y(5))/((1+y(1))*(1+y(1)));
g1(3,3)=1;
g1(3,5)=(-(params(7)-1/(1+y(1))+2*params(4)*(1-params(7))*0.5*(y(5)*(1-params(7)))^(-0.5)));
g1(4,1)=1/y(7)*(-1)/((1+y(1))*(1+y(1)));
g1(4,2)=1/y(7)*(-((-1)/((1+y(2))*(1+y(2)))));
g1(4,5)=(-T(8));
g1(4,7)=T(3)*(-1)/(y(7)*y(7))-((params(7)-1)*(-params(3))/(y(7)*y(7))+y(5)*T(4)*params(5)*(-T(5))/(y(7)*y(7)));
g1(5,1)=(-((-y(5))/((1+y(1))*(1+y(1)))));
g1(5,2)=(-y(6))/((1+y(2))*(1+y(2)));
g1(5,4)=1;
g1(5,5)=(-(1/(1+y(1))-params(7)-0.5*params(5)*(1-params(7))*2*y(5)*(1-params(7))));
g1(5,6)=(-(1-1/(1+y(2))));
g1(6,5)=1;
g1(6,6)=(-1);
g1(7,2)=(-((-y(6))/((1+y(2))*(1+y(2)))));
g1(7,6)=1-1/(1+y(2));
g1(7,8)=1;
g1(8,8)=1;
g1(9,7)=(-((-T(5))/(y(7)*y(7))));
g1(9,9)=1;
g1(10,5)=(-1);
g1(10,10)=1;
if ~isreal(g1)
    g1 = real(g1)+2*imag(g1);
end
end
