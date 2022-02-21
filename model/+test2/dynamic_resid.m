function residual = dynamic_resid(T, y, x, params, steady_state, it_, T_flag)
% function residual = dynamic_resid(T, y, x, params, steady_state, it_, T_flag)
%
% File created by Dynare Preprocessor from .mod file
%
% Inputs:
%   T             [#temp variables by 1]     double   vector of temporary terms to be filled by function
%   y             [#dynamic variables by 1]  double   vector of endogenous variables in the order stored
%                                                     in M_.lead_lag_incidence; see the Manual
%   x             [nperiods by M_.exo_nbr]   double   matrix of exogenous variables (in declaration order)
%                                                     for all simulation periods
%   steady_state  [M_.endo_nbr by 1]         double   vector of steady state values
%   params        [M_.param_nbr by 1]        double   vector of parameter values in declaration order
%   it_           scalar                     double   time period for exogenous variables for which
%                                                     to evaluate the model
%   T_flag        boolean                    boolean  flag saying whether or not to calculate temporary terms
%
% Output:
%   residual
%

if T_flag
    T = test2.dynamic_resid_tt(T, y, x, params, steady_state, it_);
end
residual = zeros(14, 1);
lhs = 1/(y(15)*(1+y(5)));
rhs = T(1)*T(2);
residual(1) = lhs - rhs;
lhs = y(8);
rhs = params(13)*y(1)-y(11)/(1+y(5))+(1-params(13))*params(7)/params(9)*y(1)^params(9);
residual(2) = lhs - rhs;
lhs = T(3)*T(4);
rhs = T(1)*T(5);
residual(3) = lhs - rhs;
lhs = y(12);
rhs = y(11)*params(5);
residual(4) = lhs - rhs;
lhs = y(9);
rhs = y(11)/(1+y(5))-params(13)*y(1)-(1-params(13))*params(8)/params(10)*y(1)^params(10)-(1-params(13))*params(11)+y(3)-y(13)/(1+y(6))+y(2)-y(12)/(1+y(7));
residual(5) = lhs - rhs;
lhs = y(6);
rhs = y(5)+params(6);
residual(6) = lhs - rhs;
lhs = T(3)*y(16)*params(4)*T(6);
rhs = T(1)*(1+y(6))-(1+y(19))*T(9);
residual(7) = lhs - rhs;
lhs = y(14);
rhs = y(13)/(1+y(6))+(1-params(12))*y(4);
residual(8) = lhs - rhs;
lhs = y(10);
rhs = y(16)*T(8)-y(3);
residual(9) = lhs - rhs;
lhs = y(15);
rhs = y(10)+y(8)+y(9)+params(2)-params(1);
residual(10) = lhs - rhs;
lhs = y(2)+y(17);
rhs = y(12)/(1+y(7))+params(1);
residual(11) = lhs - rhs;
lhs = y(17);
rhs = params(15)+x(it_, 2);
residual(12) = lhs - rhs;
lhs = y(16);
rhs = params(14)+x(it_, 1);
residual(13) = lhs - rhs;
lhs = y(18);
rhs = y(20);
residual(14) = lhs - rhs;

end
