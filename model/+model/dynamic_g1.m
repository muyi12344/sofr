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
    T = model.dynamic_g1_tt(T, y, x, params, steady_state, it_);
end
g1 = zeros(19, 32);
g1(1,8)=(-(params(4)*1/y(28)));
g1(1,20)=T(12);
g1(1,28)=(-(params(4)*(1+y(8))*(-1)/(y(28)*y(28))));
g1(2,8)=(-y(23))/((1+y(8))*(1+y(8)));
g1(2,12)=(-1);
g1(2,13)=(-1);
g1(2,14)=(-1);
g1(2,19)=(-params(2));
g1(2,20)=1;
g1(2,6)=(-1);
g1(2,23)=1/(1+y(8));
g1(3,15)=(-1);
g1(3,23)=1;
g1(4,9)=(-y(20))/(y(20)*(1+y(9))*y(20)*(1+y(9)));
g1(4,20)=(-(1+y(9)))/(y(20)*(1+y(9))*y(20)*(1+y(9)));
g1(4,28)=(-(y(29)*T(13)));
g1(4,29)=(-T(2));
g1(5,8)=(-((-y(23))/((1+y(8))*(1+y(8)))));
g1(5,9)=(-y(15))/((1+y(9))*(1+y(9)));
g1(5,12)=1;
g1(5,1)=(-y(21));
g1(5,15)=1/(1+y(9));
g1(5,5)=(-(y(7)*(-params(6))));
g1(5,21)=(-y(1));
g1(5,6)=1;
g1(5,23)=(-(1/(1+y(8))));
g1(5,7)=(-(params(6)*(1-y(5))));
g1(6,9)=T(1)*T(8);
g1(6,11)=T(1)*T(9);
g1(6,20)=T(3)*T(12);
g1(6,28)=(-((y(29)-1)*T(13)));
g1(6,29)=(-(T(2)-params(6)*T(4)/y(31)));
g1(6,31)=(-((1-y(29))*params(6)*(-T(4))/(y(31)*y(31))));
g1(7,10)=(-y(20))/(y(20)*(1+y(10))*y(20)*(1+y(10)));
g1(7,20)=(-(1+y(10)))/(y(20)*(1+y(10))*y(20)*(1+y(10)));
g1(7,28)=(-(y(30)*T(13)));
g1(7,30)=(-T(2));
g1(8,2)=T(1)-T(2)*params(6);
g1(8,20)=(y(2)-params(7))*T(12);
g1(8,28)=(-(y(2)*params(6)*T(13)));
g1(9,9)=(-((-y(15))/((1+y(9))*(1+y(9)))));
g1(9,10)=(-y(17))/((1+y(10))*(1+y(10)));
g1(9,11)=(-y(16))/((1+y(11))*(1+y(11)));
g1(9,13)=1;
g1(9,1)=y(21);
g1(9,15)=(-(1/(1+y(9))));
g1(9,2)=(-1);
g1(9,16)=1/(1+y(11));
g1(9,3)=(-y(22));
g1(9,17)=1/(1+y(10));
g1(9,5)=y(7)*(-params(6));
g1(9,21)=(-(params(7)-y(1)));
g1(9,22)=(-y(3));
g1(9,7)=params(6)*(1-y(5));
g1(10,15)=1;
g1(10,16)=(-1);
g1(11,18)=(1-params(5))*T(10)*getPowerDeriv(T(5),params(5),1);
g1(11,19)=(-1);
g1(12,10)=(-(T(2)*y(30)));
g1(12,27)=T(4)*(1-params(9))/y(31)*y(32);
g1(12,18)=T(1)*params(5)*T(11);
g1(12,20)=T(6)*params(5)*T(12);
g1(12,28)=(-(y(30)*(1+y(10))*T(13)));
g1(12,30)=(-(T(2)*(1+y(10))));
g1(12,31)=y(32)*(1+y(27))*(-(T(4)*(1-params(9))))/(y(31)*y(31));
g1(12,32)=(1+y(27))*T(4)*(1-params(9))/y(31);
g1(13,17)=(-1);
g1(14,10)=(-((-y(17))/((1+y(10))*(1+y(10)))));
g1(14,17)=(-(1/(1+y(10))));
g1(14,4)=(-(1-params(9)));
g1(14,18)=1;
g1(15,14)=1;
g1(15,3)=y(22);
g1(15,18)=(-(T(7)*getPowerDeriv(y(18),params(5),1)));
g1(15,19)=params(2);
g1(15,22)=(-(params(8)-y(3)));
g1(16,11)=(-((-y(16))/((1+y(11))*(1+y(11)))));
g1(16,2)=1;
g1(16,16)=(-(1/(1+y(11))));
g1(17,28)=(-1);
g1(17,24)=1;
g1(18,30)=(-1);
g1(18,25)=1;
g1(19,1)=(-1);
g1(19,26)=1;

end
