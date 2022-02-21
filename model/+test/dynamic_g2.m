function g2 = dynamic_g2(T, y, x, params, steady_state, it_, T_flag)
% function g2 = dynamic_g2(T, y, x, params, steady_state, it_, T_flag)
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
%   g2
%

if T_flag
    T = test.dynamic_g2_tt(T, y, x, params, steady_state, it_);
end
g2_i = zeros(53,1);
g2_j = zeros(53,1);
g2_v = zeros(53,1);

g2_i(1)=1;
g2_i(2)=1;
g2_i(3)=1;
g2_i(4)=1;
g2_i(5)=1;
g2_i(6)=1;
g2_i(7)=1;
g2_i(8)=1;
g2_i(9)=2;
g2_i(10)=2;
g2_i(11)=2;
g2_i(12)=2;
g2_i(13)=3;
g2_i(14)=3;
g2_i(15)=3;
g2_i(16)=3;
g2_i(17)=3;
g2_i(18)=3;
g2_i(19)=3;
g2_i(20)=3;
g2_i(21)=3;
g2_i(22)=3;
g2_i(23)=3;
g2_i(24)=5;
g2_i(25)=5;
g2_i(26)=5;
g2_i(27)=5;
g2_i(28)=5;
g2_i(29)=5;
g2_i(30)=5;
g2_i(31)=5;
g2_i(32)=5;
g2_i(33)=5;
g2_i(34)=7;
g2_i(35)=7;
g2_i(36)=7;
g2_i(37)=7;
g2_i(38)=7;
g2_i(39)=7;
g2_i(40)=7;
g2_i(41)=7;
g2_i(42)=7;
g2_i(43)=7;
g2_i(44)=7;
g2_i(45)=8;
g2_i(46)=8;
g2_i(47)=8;
g2_i(48)=9;
g2_i(49)=9;
g2_i(50)=9;
g2_i(51)=13;
g2_i(52)=13;
g2_i(53)=13;
g2_j(1)=89;
g2_j(2)=99;
g2_j(3)=299;
g2_j(4)=221;
g2_j(5)=228;
g2_j(6)=368;
g2_j(7)=309;
g2_j(8)=375;
g2_j(9)=89;
g2_j(10)=95;
g2_j(11)=215;
g2_j(12)=1;
g2_j(13)=89;
g2_j(14)=99;
g2_j(15)=299;
g2_j(16)=133;
g2_j(17)=141;
g2_j(18)=301;
g2_j(19)=221;
g2_j(20)=228;
g2_j(21)=368;
g2_j(22)=309;
g2_j(23)=375;
g2_j(24)=89;
g2_j(25)=95;
g2_j(26)=215;
g2_j(27)=111;
g2_j(28)=118;
g2_j(29)=258;
g2_j(30)=133;
g2_j(31)=138;
g2_j(32)=238;
g2_j(33)=1;
g2_j(34)=123;
g2_j(35)=363;
g2_j(36)=287;
g2_j(37)=288;
g2_j(38)=308;
g2_j(39)=289;
g2_j(40)=329;
g2_j(41)=309;
g2_j(42)=310;
g2_j(43)=330;
g2_j(44)=375;
g2_j(45)=111;
g2_j(46)=118;
g2_j(47)=258;
g2_j(48)=287;
g2_j(49)=289;
g2_j(50)=329;
g2_j(51)=123;
g2_j(52)=363;
g2_j(53)=375;
g2_v(1)=(-((-y(15))*(y(15)*y(15)*(1+y(5))+y(15)*y(15)*(1+y(5)))))/(y(15)*(1+y(5))*y(15)*(1+y(5))*y(15)*(1+y(5))*y(15)*(1+y(5)));
g2_v(2)=((-(y(15)*(1+y(5))*y(15)*(1+y(5))))-(-y(15))*((1+y(5))*y(15)*(1+y(5))+(1+y(5))*y(15)*(1+y(5))))/(y(15)*(1+y(5))*y(15)*(1+y(5))*y(15)*(1+y(5))*y(15)*(1+y(5)));
g2_v(3)=g2_v(2);
g2_v(4)=(-(T(1)*params(6)*(1-params(12))*getPowerDeriv(y(11),params(8)-1,2)));
g2_v(5)=(-(T(11)*T(16)));
g2_v(6)=g2_v(5);
g2_v(7)=(-((-(1+y(5)))*((1+y(5))*y(15)*(1+y(5))+(1+y(5))*y(15)*(1+y(5)))))/(y(15)*(1+y(5))*y(15)*(1+y(5))*y(15)*(1+y(5))*y(15)*(1+y(5)));
g2_v(8)=(-(T(2)*T(17)));
g2_v(9)=T(18);
g2_v(10)=T(10);
g2_v(11)=g2_v(10);
g2_v(12)=(-((1-params(12))*params(6)/params(8)*getPowerDeriv(y(1),params(8),2)));
g2_v(13)=T(3)*(1+y(5)+1+y(5))/((1+y(5))*(1+y(5))*(1+y(5))*(1+y(5)));
g2_v(14)=T(10)*T(15);
g2_v(15)=g2_v(14);
g2_v(16)=T(3)*(-((-((-params(4))*(1+y(7)+1+y(7))))/((1+y(7))*(1+y(7))*(1+y(7))*(1+y(7)))));
g2_v(17)=(-((-params(4))/((1+y(7))*(1+y(7)))))*T(15);
g2_v(18)=g2_v(17);
g2_v(19)=(-(T(1)*(1-params(12))*params(7)*getPowerDeriv(y(11),params(9)-1,2)));
g2_v(20)=(-(T(12)*T(16)));
g2_v(21)=g2_v(20);
g2_v(22)=T(4)*(y(15)+y(15))/(y(15)*y(15)*y(15)*y(15));
g2_v(23)=(-(T(5)*T(17)));
g2_v(24)=(-T(18));
g2_v(25)=(-T(10));
g2_v(26)=g2_v(25);
g2_v(27)=T(19);
g2_v(28)=(-1)/((1+y(6))*(1+y(6)));
g2_v(29)=g2_v(28);
g2_v(30)=(-((-y(12))*(1+y(7)+1+y(7))))/((1+y(7))*(1+y(7))*(1+y(7))*(1+y(7)));
g2_v(31)=(-1)/((1+y(7))*(1+y(7)));
g2_v(32)=g2_v(31);
g2_v(33)=(1-params(12))*params(7)/params(9)*getPowerDeriv(y(1),params(9),2);
g2_v(34)=(-T(16));
g2_v(35)=g2_v(34);
g2_v(36)=T(3)*y(16)*params(3)*getPowerDeriv(y(14),params(3)-1,2);
g2_v(37)=T(13)*params(3)*y(16)*T(15);
g2_v(38)=g2_v(37);
g2_v(39)=T(13)*T(3)*params(3);
g2_v(40)=g2_v(39);
g2_v(41)=T(6)*params(3)*y(16)*(y(15)+y(15))/(y(15)*y(15)*y(15)*y(15));
g2_v(42)=T(6)*params(3)*T(15);
g2_v(43)=g2_v(42);
g2_v(44)=(-((1+y(6))*T(17)));
g2_v(45)=(-T(19));
g2_v(46)=(-((-1)/((1+y(6))*(1+y(6)))));
g2_v(47)=g2_v(46);
g2_v(48)=(-(y(16)*getPowerDeriv(y(14),params(3),2)));
g2_v(49)=(-T(14));
g2_v(50)=g2_v(49);
g2_v(51)=(-((-T(7))/(y(18)*y(18))));
g2_v(52)=g2_v(51);
g2_v(53)=(-((1+y(6))*(-((-T(7))*(y(18)+y(18))))/(y(18)*y(18)*y(18)*y(18))));
g2 = sparse(g2_i,g2_j,g2_v,13,441);
end
