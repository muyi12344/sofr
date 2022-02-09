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
g1 = zeros(15, 25);
g1(1,6)=(-y(16))/(y(16)*(1+y(6))*y(16)*(1+y(6)));
g1(1,12)=(-((1-params(13))*params(7)*T(9)*T(12)));
g1(1,16)=(-(1+y(6)))/(y(16)*(1+y(6))*y(16)*(1+y(6)));
g1(1,22)=(-(params(13)*T(17)));
g1(1,23)=(-(T(3)*(1-params(13))*params(7)*(-T(2))/(y(23)*y(23))));
g1(2,6)=(-y(12))/((1+y(6))*(1+y(6)));
g1(2,9)=1;
g1(2,1)=(-params(13));
g1(2,12)=1/(1+y(6));
g1(2,5)=(-((1-params(13))*params(7)/params(9)*getPowerDeriv(y(5),params(9),1)));
g1(3,6)=T(4)*T(10);
g1(3,8)=T(4)*T(11);
g1(3,12)=(-((1-params(13))*params(8)*T(9)*T(13)));
g1(3,16)=T(5)*T(16);
g1(3,22)=(-((params(13)-1)*T(17)));
g1(3,23)=(-(T(6)*(1-params(13))*params(8)*(-T(2))/(y(23)*y(23))));
g1(4,12)=(-params(5));
g1(4,13)=1;
g1(5,6)=(-((-y(12))/((1+y(6))*(1+y(6)))));
g1(5,7)=(-y(14))/((1+y(7))*(1+y(7)));
g1(5,8)=(-y(13))/((1+y(8))*(1+y(8)));
g1(5,10)=1;
g1(5,1)=params(13);
g1(5,12)=(-(1/(1+y(6))));
g1(5,2)=(-1);
g1(5,13)=1/(1+y(8));
g1(5,3)=(-1);
g1(5,14)=1/(1+y(7));
g1(5,5)=(1-params(13))*params(8)/params(10)*getPowerDeriv(y(5),params(10),1);
g1(6,6)=(-1);
g1(6,7)=1;
g1(7,7)=(-T(1));
g1(7,21)=T(2)*(1-params(12))/y(23);
g1(7,15)=T(4)*y(17)*params(4)*T(14);
g1(7,16)=T(7)*params(4)*y(17)*T(16);
g1(7,22)=(-((1+y(7))*T(17)));
g1(7,17)=T(7)*T(4)*params(4);
g1(7,23)=(1+y(21))*(-(T(2)*(1-params(12))))/(y(23)*y(23));
g1(8,7)=(-((-y(14))/((1+y(7))*(1+y(7)))));
g1(8,14)=(-(1/(1+y(7))));
g1(8,4)=(-(1-params(12)));
g1(8,15)=1;
g1(9,11)=1;
g1(9,3)=1;
g1(9,15)=(-(y(17)*T(15)));
g1(9,17)=(-T(8));
g1(10,9)=(-1);
g1(10,10)=(-1);
g1(10,11)=(-1);
g1(10,16)=1;
g1(11,8)=(-((-y(13))/((1+y(8))*(1+y(8)))));
g1(11,2)=1;
g1(11,13)=(-(1/(1+y(8))));
g1(11,18)=1;
g1(12,18)=1;
g1(12,25)=(-1);
g1(13,17)=1;
g1(13,24)=(-1);
g1(14,22)=(-1);
g1(14,19)=1;
g1(15,1)=(-1);
g1(15,20)=1;

end
