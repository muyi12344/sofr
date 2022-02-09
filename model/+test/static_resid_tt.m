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

assert(length(T) >= 8);

T(1) = y(5)^(-0.5);
T(2) = (1-params(7))^0.5;
T(3) = 1/(1+y(1))-1/(1+y(2));
T(4) = (1-params(7))^2;
T(5) = params(3)^2;
T(6) = T(5)/y(7);
T(7) = T(2)*params(4)*T(6);
T(8) = T(4)*params(5)*T(6);

end
