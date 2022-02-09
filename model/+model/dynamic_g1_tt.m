function T = dynamic_g1_tt(T, y, x, params, steady_state, it_)
% function T = dynamic_g1_tt(T, y, x, params, steady_state, it_)
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

assert(length(T) >= 13);

T = model.dynamic_resid_tt(T, y, x, params, steady_state, it_);

T(8) = (-1)/((1+y(9))*(1+y(9)));
T(9) = (-((-1)/((1+y(11))*(1+y(11)))));
T(10) = 1/params(2);
T(11) = T(10)*getPowerDeriv(T(5),params(5)-1,1);
T(12) = (-1)/(y(20)*y(20));
T(13) = (-params(4))/(y(28)*y(28));

end
