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
    T = test2.static_g1_tt(T, y, x, params);
end
g1 = zeros(15, 15);
g1(1,1)=(-y(11))/(y(11)*(1+y(1))*y(11)*(1+y(1)));
g1(1,7)=(-((1-params(13))*params(7)*T(9)*getPowerDeriv(y(7),params(9)-1,1)));
g1(1,11)=(-(1+y(1)))/(y(11)*(1+y(1))*y(11)*(1+y(1)))-(params(13)*(-params(3))/(y(11)*y(11))+T(2)*(1-params(13))*params(7)*(-T(3))/(y(11)*y(11)));
g1(2,1)=(-y(7))/((1+y(1))*(1+y(1)));
g1(2,4)=1;
g1(2,7)=(-(params(13)-1/(1+y(1))+(1-params(13))*params(7)/params(9)*getPowerDeriv(y(7),params(9),1)));
g1(3,1)=T(4)*(-1)/((1+y(1))*(1+y(1)));
g1(3,3)=T(4)*(-((-1)/((1+y(3))*(1+y(3)))));
g1(3,7)=(-((1-params(13))*params(8)*T(9)*getPowerDeriv(y(7),params(10)-1,1)));
g1(3,11)=T(5)*(-1)/(y(11)*y(11))-((params(13)-1)*(-params(3))/(y(11)*y(11))+T(6)*(1-params(13))*params(8)*(-T(3))/(y(11)*y(11)));
g1(4,7)=(-params(5));
g1(4,8)=1;
g1(5,1)=(-((-y(7))/((1+y(1))*(1+y(1)))));
g1(5,2)=(-y(9))/((1+y(2))*(1+y(2)));
g1(5,3)=(-y(8))/((1+y(3))*(1+y(3)));
g1(5,5)=1;
g1(5,7)=(-(1/(1+y(1))-params(13)-(1-params(13))*params(8)/params(10)*getPowerDeriv(y(7),params(10),1)));
g1(5,8)=(-(1-1/(1+y(3))));
g1(5,9)=(-(1-1/(1+y(2))));
g1(6,1)=(-1);
g1(6,2)=1;
g1(7,2)=(-(T(1)-T(3)*(1-params(12))/y(11)));
g1(7,10)=T(4)*y(12)*params(4)*getPowerDeriv(y(10),params(4)-1,1);
g1(7,11)=T(7)*params(4)*y(12)*(-1)/(y(11)*y(11))-((1+y(2))*(-params(3))/(y(11)*y(11))-(1+y(2))*(-(T(3)*(1-params(12))))/(y(11)*y(11)));
g1(7,12)=T(7)*T(4)*params(4);
g1(8,2)=(-((-y(9))/((1+y(2))*(1+y(2)))));
g1(8,9)=(-(1/(1+y(2))));
g1(8,10)=1-(1-params(12));
g1(9,6)=1;
g1(9,9)=1;
g1(9,10)=(-(y(12)*getPowerDeriv(y(10),params(4),1)));
g1(9,12)=(-T(8));
g1(10,4)=(-1);
g1(10,5)=(-1);
g1(10,6)=(-1);
g1(10,11)=1;
g1(11,3)=(-((-y(8))/((1+y(3))*(1+y(3)))));
g1(11,8)=1-1/(1+y(3));
g1(11,13)=1;
g1(12,13)=1;
g1(13,12)=1;
g1(14,11)=(-1);
g1(14,14)=1;
g1(15,7)=(-1);
g1(15,15)=1;
if ~isreal(g1)
    g1 = real(g1)+2*imag(g1);
end
end
