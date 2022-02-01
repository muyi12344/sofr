function residual = static_resid(T, y, x, params, T_flag)
% function residual = static_resid(T, y, x, params, T_flag)
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
%   residual
%

if T_flag
    T = model.static_resid_tt(T, y, x, params);
end
residual = zeros(19, 1);
lhs = T(1);
rhs = T(1)*params(4)*(1+y(1));
residual(1) = lhs - rhs;
lhs = y(13)+y(16)/(1+y(1))+params(2);
rhs = y(16)+y(12)*params(1)+y(5)+y(6)+y(7);
residual(2) = lhs - rhs;
lhs = y(16);
rhs = y(8);
residual(3) = lhs - rhs;
lhs = 1/(y(13)*(1+y(2)));
rhs = T(2)*y(14);
residual(4) = lhs - rhs;
lhs = y(5);
rhs = y(16)/(1+y(1))+y(8)*y(14)-y(16)-y(8)/(1+y(2))+y(8)*params(6)*(1-y(14));
residual(5) = lhs - rhs;
lhs = T(1)*T(3);
rhs = T(2)*(y(14)-1)+(1-y(14))*params(6)*T(4)/y(13);
residual(6) = lhs - rhs;
lhs = 1/(y(13)*(1+y(3)));
rhs = T(2)*y(15);
residual(7) = lhs - rhs;
lhs = T(1)*(y(9)-params(8));
rhs = y(9)*T(2)*params(6);
residual(8) = lhs - rhs;
lhs = y(6);
rhs = y(9)+y(8)/(1+y(2))+y(15)*y(10)-y(8)*y(14)-y(10)/(1+y(3))-y(8)*params(6)*(1-y(14))-(1-y(14))*params(8)-y(9)/(1+y(4));
residual(9) = lhs - rhs;
lhs = y(8);
rhs = y(9);
residual(10) = lhs - rhs;
lhs = (1-params(5))*T(5)^params(5);
rhs = y(12);
residual(11) = lhs - rhs;
lhs = T(1)*params(5)*T(6);
rhs = y(15)*T(2)*(1+y(3))-y(15)*(1+y(3))*T(4)*(1-params(10))/y(13);
residual(12) = lhs - rhs;
lhs = params(9);
rhs = y(10);
residual(13) = lhs - rhs;
lhs = y(11);
rhs = y(10)/(1+y(3))+y(11)*(1-params(10));
residual(14) = lhs - rhs;
lhs = y(7);
rhs = y(11)^params(5)*T(7)-y(12)*params(1)-y(15)*y(10)-params(9)*(1-y(15));
residual(15) = lhs - rhs;
lhs = y(9)+params(3);
rhs = params(2)+y(9)/(1+y(4));
residual(16) = lhs - rhs;
lhs = y(17);
rhs = y(13);
residual(17) = lhs - rhs;
lhs = y(18);
rhs = y(15);
residual(18) = lhs - rhs;
lhs = y(19);
rhs = y(8);
residual(19) = lhs - rhs;
if ~isreal(residual)
  residual = real(residual)+imag(residual).^2;
end
end
