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
residual = zeros(10, 1);
lhs = y(7)+params(2);
rhs = y(3)+y(4)+params(1);
residual(1) = lhs - rhs;
lhs = 1/(y(7)*(1+y(1)));
rhs = params(3)/y(7)*params(7)+T(1)*T(7);
residual(2) = lhs - rhs;
lhs = y(3);
rhs = params(7)*y(5)-y(5)/(1+y(1))+2*params(4)*(y(5)*(1-params(7)))^0.5;
residual(3) = lhs - rhs;
lhs = 1/y(7)*T(3);
rhs = params(3)/y(7)*(params(7)-1)+y(5)*T(8);
residual(4) = lhs - rhs;
lhs = y(4);
rhs = y(6)+y(5)/(1+y(1))-params(7)*y(5)-0.5*params(5)*(y(5)*(1-params(7)))^2-y(6)/(1+y(2));
residual(5) = lhs - rhs;
lhs = y(5);
rhs = y(6);
residual(6) = lhs - rhs;
lhs = y(6)+y(8);
rhs = params(2)+y(6)/(1+y(2));
residual(7) = lhs - rhs;
lhs = y(8);
rhs = 0.2+x(1);
residual(8) = lhs - rhs;
lhs = y(9);
rhs = T(6);
residual(9) = lhs - rhs;
lhs = y(10);
rhs = y(5);
residual(10) = lhs - rhs;
if ~isreal(residual)
  residual = real(residual)+imag(residual).^2;
end
end
