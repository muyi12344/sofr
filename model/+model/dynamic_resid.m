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
    T = model.dynamic_resid_tt(T, y, x, params, steady_state, it_);
end
residual = zeros(19, 1);
lhs = T(1);
rhs = params(4)*(1+y(8))*1/y(28);
residual(1) = lhs - rhs;
lhs = y(20)+y(23)/(1+y(8))+params(2);
rhs = y(19)*params(1)+y(6)+y(12)+y(13)+y(14);
residual(2) = lhs - rhs;
lhs = y(23);
rhs = y(15);
residual(3) = lhs - rhs;
lhs = 1/(y(20)*(1+y(9)));
rhs = T(2)*y(29);
residual(4) = lhs - rhs;
lhs = y(12);
rhs = y(23)/(1+y(8))+y(21)*y(1)-y(6)-y(15)/(1+y(9))+params(6)*(1-y(5))*y(7);
residual(5) = lhs - rhs;
lhs = T(1)*T(3);
rhs = T(2)*(y(29)-1)+(1-y(29))*params(6)*T(4)/y(31);
residual(6) = lhs - rhs;
lhs = 1/(y(20)*(1+y(10)));
rhs = T(2)*y(30);
residual(7) = lhs - rhs;
lhs = T(1)*(y(2)-params(8));
rhs = y(2)*T(2)*params(6);
residual(8) = lhs - rhs;
lhs = y(13);
rhs = y(2)+y(15)/(1+y(9))+y(22)*y(3)-y(21)*y(1)-y(17)/(1+y(10))-params(6)*(1-y(5))*y(7)-params(8)*(1-y(21))-y(16)/(1+y(11));
residual(9) = lhs - rhs;
lhs = y(15);
rhs = y(16);
residual(10) = lhs - rhs;
lhs = (1-params(5))*T(5)^params(5);
rhs = y(19);
residual(11) = lhs - rhs;
lhs = T(1)*params(5)*T(6);
rhs = y(30)*T(2)*(1+y(10))-(1+y(27))*T(4)*(1-params(10))/y(31)*y(32);
residual(12) = lhs - rhs;
lhs = params(9);
rhs = y(3);
residual(13) = lhs - rhs;
lhs = y(18);
rhs = y(17)/(1+y(10))+(1-params(10))*y(4);
residual(14) = lhs - rhs;
lhs = y(14);
rhs = y(18)^params(5)*T(7)-y(19)*params(1)-y(22)*y(3)-params(9)*(1-y(22));
residual(15) = lhs - rhs;
lhs = y(2)+params(3);
rhs = params(2)+y(16)/(1+y(11));
residual(16) = lhs - rhs;
lhs = y(24);
rhs = y(28);
residual(17) = lhs - rhs;
lhs = y(25);
rhs = y(30);
residual(18) = lhs - rhs;
lhs = y(26);
rhs = y(1);
residual(19) = lhs - rhs;

end
