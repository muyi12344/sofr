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
    T = test.static_resid_tt(T, y, x, params);
end
residual = zeros(13, 1);
lhs = 1/(y(11)*(1+y(1)));
rhs = T(1)*T(2);
residual(1) = lhs - rhs;
lhs = y(4);
rhs = params(12)*y(7)-y(7)/(1+y(1))+(1-params(12))*params(6)/params(8)*y(7)^params(8);
residual(2) = lhs - rhs;
lhs = T(3)*T(4);
rhs = T(1)*T(5);
residual(3) = lhs - rhs;
lhs = y(8);
rhs = y(7)*params(4);
residual(4) = lhs - rhs;
lhs = y(5);
rhs = y(8)+y(7)/(1+y(1))-params(12)*y(7)-(1-params(12))*params(7)/params(9)*y(7)^params(9)-(1-params(12))*params(10)+y(9)-y(9)/(1+y(2))-y(8)/(1+y(3));
residual(5) = lhs - rhs;
lhs = y(2);
rhs = y(1)+params(5);
residual(6) = lhs - rhs;
lhs = T(3)*y(12)*params(3)*T(6);
rhs = T(1)*(1+y(2))-T(10);
residual(7) = lhs - rhs;
lhs = y(10);
rhs = y(9)/(1+y(2))+y(10)*(1-params(11));
residual(8) = lhs - rhs;
lhs = y(6);
rhs = y(12)*T(7)-y(9);
residual(9) = lhs - rhs;
lhs = y(11);
rhs = y(6)+y(4)+y(5);
residual(10) = lhs - rhs;
lhs = y(8);
rhs = params(14)+x(2);
residual(11) = lhs - rhs;
lhs = y(12);
rhs = params(13)+x(1);
residual(12) = lhs - rhs;
lhs = y(13);
rhs = T(10);
residual(13) = lhs - rhs;
if ~isreal(residual)
  residual = real(residual)+imag(residual).^2;
end
end
