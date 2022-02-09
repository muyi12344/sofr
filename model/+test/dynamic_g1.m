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
    T = test.dynamic_g1_tt(T, y, x, params, steady_state, it_);
end
g1 = zeros(10, 16);
g1(1,6)=(-1);
g1(1,7)=(-1);
g1(1,10)=1;
g1(2,4)=(-y(10))/(y(10)*(1+y(4))*y(10)*(1+y(4)));
g1(2,8)=(-(T(7)*T(11)));
g1(2,10)=(-(1+y(4)))/(y(10)*(1+y(4))*y(10)*(1+y(4)));
g1(2,14)=(-(params(7)*(-params(3))/(y(14)*y(14))));
g1(2,15)=(-(T(3)*params(4)*T(2)));
g1(3,4)=(-y(8))/((1+y(4))*(1+y(4)));
g1(3,6)=1;
g1(3,1)=(-params(7));
g1(3,8)=1/(1+y(4));
g1(3,3)=(-(2*params(4)*(1-params(7))*0.5*((1-params(7))*y(3))^(-0.5)));
g1(4,4)=T(4)*T(9);
g1(4,5)=T(4)*T(10);
g1(4,8)=(-T(8));
g1(4,10)=T(5)*(-1)/(y(10)*y(10));
g1(4,14)=(-((params(7)-1)*(-params(3))/(y(14)*y(14))));
g1(4,15)=(-(y(8)*params(5)*T(6)));
g1(5,4)=(-((-y(8))/((1+y(4))*(1+y(4)))));
g1(5,5)=(-y(9))/((1+y(5))*(1+y(5)));
g1(5,7)=1;
g1(5,1)=params(7);
g1(5,8)=(-(1/(1+y(4))));
g1(5,2)=(-1);
g1(5,9)=1/(1+y(5));
g1(5,3)=0.5*params(5)*(1-params(7))*2*(1-params(7))*y(3);
g1(6,8)=1;
g1(6,9)=(-1);
g1(7,5)=(-((-y(9))/((1+y(5))*(1+y(5)))));
g1(7,2)=1;
g1(7,9)=(-(1/(1+y(5))));
g1(7,11)=1;
g1(8,11)=1;
g1(8,16)=(-1);
g1(9,14)=(-((-T(1))/(y(14)*y(14))));
g1(9,12)=1;
g1(10,1)=(-1);
g1(10,13)=1;

end
