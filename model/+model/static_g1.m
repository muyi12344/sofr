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
    T = model.static_g1_tt(T, y, x, params);
end
g1 = zeros(19, 19);
g1(1,1)=(-(T(1)*params(4)));
g1(1,13)=T(8)-params(4)*(1+y(1))*T(8);
g1(2,1)=(-y(16))/((1+y(1))*(1+y(1)));
g1(2,5)=(-1);
g1(2,6)=(-1);
g1(2,7)=(-1);
g1(2,12)=(-params(1));
g1(2,13)=1;
g1(2,16)=1/(1+y(1))-1;
g1(3,8)=(-1);
g1(3,16)=1;
g1(4,2)=(-y(13))/(y(13)*(1+y(2))*y(13)*(1+y(2)));
g1(4,13)=(-(1+y(2)))/(y(13)*(1+y(2))*y(13)*(1+y(2)))-y(14)*T(9);
g1(4,14)=(-T(2));
g1(5,1)=(-((-y(16))/((1+y(1))*(1+y(1)))));
g1(5,2)=(-y(8))/((1+y(2))*(1+y(2)));
g1(5,5)=1;
g1(5,8)=(-(params(6)*(1-y(14))+y(14)-1/(1+y(2))));
g1(5,14)=(-(y(8)+y(8)*(-params(6))));
g1(5,16)=(-(1/(1+y(1))-1));
g1(6,2)=T(1)*(-1)/((1+y(2))*(1+y(2)));
g1(6,4)=T(1)*(-((-1)/((1+y(4))*(1+y(4)))));
g1(6,13)=T(3)*T(8)-((y(14)-1)*T(9)+(1-y(14))*params(6)*(-T(4))/(y(13)*y(13)));
g1(6,14)=(-(T(2)-params(6)*T(4)/y(13)));
g1(7,3)=(-y(13))/(y(13)*(1+y(3))*y(13)*(1+y(3)));
g1(7,13)=(-(1+y(3)))/(y(13)*(1+y(3))*y(13)*(1+y(3)))-y(15)*T(9);
g1(7,15)=(-T(2));
g1(8,9)=T(1)-T(2)*params(6);
g1(8,13)=(y(9)-params(8))*T(8)-y(9)*params(6)*T(9);
g1(9,2)=(-((-y(8))/((1+y(2))*(1+y(2)))));
g1(9,3)=(-y(10))/((1+y(3))*(1+y(3)));
g1(9,4)=(-y(9))/((1+y(4))*(1+y(4)));
g1(9,6)=1;
g1(9,8)=(-(1/(1+y(2))-y(14)-params(6)*(1-y(14))));
g1(9,9)=(-(1-1/(1+y(4))));
g1(9,10)=(-(y(15)-1/(1+y(3))));
g1(9,14)=(-(params(8)+(-y(8))-y(8)*(-params(6))));
g1(9,15)=(-y(10));
g1(10,8)=1;
g1(10,9)=(-1);
g1(11,11)=(1-params(5))*1/params(1)*getPowerDeriv(T(5),params(5),1);
g1(11,12)=(-1);
g1(12,3)=(-(T(2)*y(15)-y(15)*T(4)*(1-params(10))/y(13)));
g1(12,11)=T(1)*params(5)*1/params(1)*getPowerDeriv(T(5),params(5)-1,1);
g1(12,13)=T(6)*params(5)*T(8)-(y(15)*(1+y(3))*T(9)-y(15)*(1+y(3))*(-(T(4)*(1-params(10))))/(y(13)*y(13)));
g1(12,15)=(-(T(2)*(1+y(3))-(1+y(3))*T(4)*(1-params(10))/y(13)));
g1(13,10)=(-1);
g1(14,3)=(-((-y(10))/((1+y(3))*(1+y(3)))));
g1(14,10)=(-(1/(1+y(3))));
g1(14,11)=1-(1-params(10));
g1(15,7)=1;
g1(15,10)=y(15);
g1(15,11)=(-(T(7)*getPowerDeriv(y(11),params(5),1)));
g1(15,12)=params(1);
g1(15,15)=(-(params(9)-y(10)));
g1(16,4)=(-((-y(9))/((1+y(4))*(1+y(4)))));
g1(16,9)=1-1/(1+y(4));
g1(17,13)=(-1);
g1(17,17)=1;
g1(18,15)=(-1);
g1(18,18)=1;
g1(19,8)=(-1);
g1(19,19)=1;
if ~isreal(g1)
    g1 = real(g1)+2*imag(g1);
end
end
