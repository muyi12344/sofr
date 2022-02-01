function T = dynamic_g2_tt(T, y, x, params, steady_state, it_)
% function T = dynamic_g2_tt(T, y, x, params, steady_state, it_)
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

assert(length(T) >= 19);

T = model.dynamic_g1_tt(T, y, x, params, steady_state, it_);

T(14) = (y(20)+y(20))/(y(20)*y(20)*y(20)*y(20));
T(15) = (-((-y(23))*(1+y(8)+1+y(8))))/((1+y(8))*(1+y(8))*(1+y(8))*(1+y(8)));
T(16) = (-((-params(4))*(y(28)+y(28))))/(y(28)*y(28)*y(28)*y(28));
T(17) = (-((-y(15))*(1+y(9)+1+y(9))))/((1+y(9))*(1+y(9))*(1+y(9))*(1+y(9)));
T(18) = (-((-y(17))*(1+y(10)+1+y(10))))/((1+y(10))*(1+y(10))*(1+y(10))*(1+y(10)));
T(19) = (-((-y(16))*(1+y(11)+1+y(11))))/((1+y(11))*(1+y(11))*(1+y(11))*(1+y(11)));

end
