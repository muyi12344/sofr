function T = static_resid_tt(T, y, x, params)
% function T = static_resid_tt(T, y, x, params)
%
% File created by Dynare Preprocessor from .mod file
%
% Inputs:
%   T         [#temp variables by 1]  double   vector of temporary terms to be filled by function
%   y         [M_.endo_nbr by 1]      double   vector of endogenous variables in declaration order
%   x         [M_.exo_nbr by 1]       double   vector of exogenous variables in declaration order
%   params    [M_.param_nbr by 1]     double   vector of parameter values in declaration order
%
% Output:
%   T         [#temp variables by 1]  double   vector of temporary terms
%

assert(length(T) >= 10);

T(1) = params(2)/y(11);
T(2) = params(12)+params(6)*(1-params(12))*y(7)^(params(8)-1);
T(3) = 1/y(11);
T(4) = 1/(1+y(1))-params(4)/(1+y(3));
T(5) = params(12)+(1-params(12))*params(7)*y(7)^(params(9)-1)-params(4);
T(6) = y(10)^(params(3)-1);
T(7) = y(10)^params(3);
T(8) = (1-params(11))*params(2)^2;
T(9) = T(8)/y(11);
T(10) = (1+y(2))*T(9);

end
