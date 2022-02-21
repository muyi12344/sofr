function g1 = dynamic_g1(T, y, x, params, steady_state, it_, T_flag)
% function g1 = dynamic_g1(T, y, x, params, steady_state, it_, T_flag)
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
%   g1
%

if T_flag
    T = test2.dynamic_g1_tt(T, y, x, params, steady_state, it_);
end
g1 = zeros(14, 23);
g1(1,5)=(-y(15))/(y(15)*(1+y(5))*y(15)*(1+y(5)));
g1(1,11)=(-(T(1)*T(11)));
g1(1,15)=(-(1+y(5)))/(y(15)*(1+y(5))*y(15)*(1+y(5)));
g1(1,20)=(-(T(2)*T(16)));
g1(2,5)=(-y(11))/((1+y(5))*(1+y(5)));
g1(2,8)=1;
g1(2,1)=(-(params(13)+(1-params(13))*params(7)/params(9)*getPowerDeriv(y(1),params(9),1)));
g1(2,11)=1/(1+y(5));
g1(3,5)=T(3)*T(10);
g1(3,7)=T(3)*(-((-params(5))/((1+y(7))*(1+y(7)))));
g1(3,11)=(-(T(1)*T(12)));
g1(3,15)=T(4)*T(15);
g1(3,20)=(-(T(5)*T(16)));
g1(4,11)=(-params(5));
g1(4,12)=1;
g1(5,5)=(-((-y(11))/((1+y(5))*(1+y(5)))));
g1(5,6)=(-y(13))/((1+y(6))*(1+y(6)));
g1(5,7)=(-y(12))/((1+y(7))*(1+y(7)));
g1(5,9)=1;
g1(5,1)=(-((-params(13))-(1-params(13))*params(8)/params(10)*getPowerDeriv(y(1),params(10),1)));
g1(5,11)=(-(1/(1+y(5))));
g1(5,2)=(-1);
g1(5,12)=1/(1+y(7));
g1(5,3)=(-1);
g1(5,13)=1/(1+y(6));
g1(6,5)=(-1);
g1(6,6)=1;
g1(7,6)=(-T(1));
g1(7,19)=T(9);
g1(7,14)=T(3)*y(16)*params(4)*T(13);
g1(7,15)=T(6)*params(4)*y(16)*T(15);
g1(7,20)=(-((1+y(6))*T(16)));
g1(7,16)=T(6)*T(3)*params(4);
g1(7,21)=(1+y(19))*(-T(7))/(y(21)*y(21));
g1(8,6)=(-((-y(13))/((1+y(6))*(1+y(6)))));
g1(8,13)=(-(1/(1+y(6))));
g1(8,4)=(-(1-params(12)));
g1(8,14)=1;
g1(9,10)=1;
g1(9,3)=1;
g1(9,14)=(-(y(16)*T(14)));
g1(9,16)=(-T(8));
g1(10,8)=(-1);
g1(10,9)=(-1);
g1(10,10)=(-1);
g1(10,15)=1;
g1(11,7)=(-((-y(12))/((1+y(7))*(1+y(7)))));
g1(11,2)=1;
g1(11,12)=(-(1/(1+y(7))));
g1(11,17)=1;
g1(12,17)=1;
g1(12,23)=(-1);
g1(13,16)=1;
g1(13,22)=(-1);
g1(14,20)=(-1);
g1(14,18)=1;

end
