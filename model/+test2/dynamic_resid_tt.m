function T = dynamic_resid_tt(T, y, x, params, steady_state, it_)
% function T = dynamic_resid_tt(T, y, x, params, steady_state, it_)
%
% File created by Dynare Preprocessor from .mod file
%
% Inputs:
%   T             [#temp variables by 1]     double  vector of temporary terms to be filled by function
%   y             [#dynamic variables by 1]  double  vector of endogenous variables in the order stored
%                                                    in M_.lead_lag_incidence; see the Manual
%   x             [nperiods by M_.exo_nbr]   double  matrix of exogenous variables (in declaration order)
%                                                    for all simulation periods
%   steady_state  [M_.endo_nbr by 1]         double  vector of steady state values
%   params        [M_.param_nbr by 1]        double  vector of parameter values in declaration order
%   it_           scalar                     double  time period for exogenous variables for which
%                                                    to evaluate the model
%
% Output:
%   T           [#temp variables by 1]       double  vector of temporary terms
%

assert(length(T) >= 9);

T(1) = params(3)/y(20);
T(2) = params(13)+params(7)*(1-params(13))*y(11)^(params(9)-1);
T(3) = 1/y(15);
T(4) = 1/(1+y(5))-params(5)/(1+y(7));
T(5) = params(13)+(1-params(13))*params(8)*y(11)^(params(10)-1)-params(5);
T(6) = y(14)^(params(4)-1);
T(7) = (1-params(12))*params(3)^2;
T(8) = y(14)^params(4);
T(9) = T(7)/y(21);

end
