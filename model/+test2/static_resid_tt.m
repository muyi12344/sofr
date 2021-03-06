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

assert(length(T) >= 9);

T(1) = params(3)/y(11);
T(2) = params(13)+params(7)*(1-params(13))*y(7)^(params(9)-1);
T(3) = 1/y(11);
T(4) = 1/(1+y(1))-params(5)/(1+y(3));
T(5) = params(13)+(1-params(13))*params(8)*y(7)^(params(10)-1)-params(5);
T(6) = y(10)^(params(4)-1);
T(7) = (1-params(12))*params(3)^2;
T(8) = y(10)^params(4);
T(9) = T(7)/y(11);

end
