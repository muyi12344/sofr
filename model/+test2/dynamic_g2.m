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
    T = test2.dynamic_g2_tt(T, y, x, params, steady_state, it_);
end
g2_i = zeros(58,1);
g2_j = zeros(58,1);
g2_v = zeros(58,1);

g2_i(1)=1;
g2_i(2)=1;
g2_i(3)=1;
g2_i(4)=1;
g2_i(5)=1;
g2_i(6)=1;
g2_i(7)=1;
g2_i(8)=1;
g2_i(9)=1;
g2_i(10)=2;
g2_i(11)=2;
g2_i(12)=2;
g2_i(13)=2;
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
g2_i(24)=3;
g2_i(25)=3;
g2_i(26)=5;
g2_i(27)=5;
g2_i(28)=5;
g2_i(29)=5;
g2_i(30)=5;
g2_i(31)=5;
g2_i(32)=5;
g2_i(33)=5;
g2_i(34)=5;
g2_i(35)=5;
g2_i(36)=7;
g2_i(37)=7;
g2_i(38)=7;
g2_i(39)=7;
g2_i(40)=7;
g2_i(41)=7;
g2_i(42)=7;
g2_i(43)=7;
g2_i(44)=7;
g2_i(45)=7;
g2_i(46)=7;
g2_i(47)=7;
g2_i(48)=7;
g2_i(49)=7;
g2_i(50)=8;
g2_i(51)=8;
g2_i(52)=8;
g2_i(53)=9;
g2_i(54)=9;
g2_i(55)=9;
g2_i(56)=11;
g2_i(57)=11;
g2_i(58)=11;
g2_j(1)=131;
g2_j(2)=141;
g2_j(3)=381;
g2_j(4)=287;
g2_j(5)=298;
g2_j(6)=562;
g2_j(7)=391;
g2_j(8)=547;
g2_j(9)=573;
g2_j(10)=131;
g2_j(11)=137;
g2_j(12)=281;
g2_j(13)=105;
g2_j(14)=131;
g2_j(15)=141;
g2_j(16)=381;
g2_j(17)=183;
g2_j(18)=191;
g2_j(19)=383;
g2_j(20)=287;
g2_j(21)=298;
g2_j(22)=562;
g2_j(23)=391;
g2_j(24)=547;
g2_j(25)=573;
g2_j(26)=131;
g2_j(27)=137;
g2_j(28)=281;
g2_j(29)=157;
g2_j(30)=164;
g2_j(31)=332;
g2_j(32)=183;
g2_j(33)=188;
g2_j(34)=308;
g2_j(35)=105;
g2_j(36)=172;
g2_j(37)=532;
g2_j(38)=523;
g2_j(39)=571;
g2_j(40)=365;
g2_j(41)=366;
g2_j(42)=390;
g2_j(43)=367;
g2_j(44)=415;
g2_j(45)=391;
g2_j(46)=392;
g2_j(47)=416;
g2_j(48)=547;
g2_j(49)=573;
g2_j(50)=157;
g2_j(51)=164;
g2_j(52)=332;
g2_j(53)=365;
g2_j(54)=367;
g2_j(55)=415;
g2_j(56)=183;
g2_j(57)=188;
g2_j(58)=308;
g2_v(1)=(-((-y(16))*(y(16)*y(16)*(1+y(6))+y(16)*y(16)*(1+y(6)))))/(y(16)*(1+y(6))*y(16)*(1+y(6))*y(16)*(1+y(6))*y(16)*(1+y(6)));
g2_v(2)=((-(y(16)*(1+y(6))*y(16)*(1+y(6))))-(-y(16))*((1+y(6))*y(16)*(1+y(6))+(1+y(6))*y(16)*(1+y(6))))/(y(16)*(1+y(6))*y(16)*(1+y(6))*y(16)*(1+y(6))*y(16)*(1+y(6)));
g2_v(3)=g2_v(2);
g2_v(4)=(-((1-params(13))*params(7)*T(9)*getPowerDeriv(y(12),params(9)-1,2)));
g2_v(5)=(-(T(12)*(1-params(13))*params(7)*(-T(2))/(y(23)*y(23))));
g2_v(6)=g2_v(5);
g2_v(7)=(-((-(1+y(6)))*((1+y(6))*y(16)*(1+y(6))+(1+y(6))*y(16)*(1+y(6)))))/(y(16)*(1+y(6))*y(16)*(1+y(6))*y(16)*(1+y(6))*y(16)*(1+y(6)));
g2_v(8)=(-(params(13)*T(18)));
g2_v(9)=(-(T(3)*(1-params(13))*params(7)*(-((-T(2))*(y(23)+y(23))))/(y(23)*y(23)*y(23)*y(23))));
g2_v(10)=T(19);
g2_v(11)=T(10);
g2_v(12)=g2_v(11);
g2_v(13)=(-((1-params(13))*params(7)/params(9)*getPowerDeriv(y(5),params(9),2)));
g2_v(14)=T(4)*(1+y(6)+1+y(6))/((1+y(6))*(1+y(6))*(1+y(6))*(1+y(6)));
g2_v(15)=T(10)*T(16);
g2_v(16)=g2_v(15);
g2_v(17)=T(4)*(-((1+y(8)+1+y(8))/((1+y(8))*(1+y(8))*(1+y(8))*(1+y(8)))));
g2_v(18)=T(11)*T(16);
g2_v(19)=g2_v(18);
g2_v(20)=(-((1-params(13))*params(8)*T(9)*getPowerDeriv(y(12),params(10)-1,2)));
g2_v(21)=(-(T(13)*(1-params(13))*params(8)*(-T(2))/(y(23)*y(23))));
g2_v(22)=g2_v(21);
g2_v(23)=T(5)*(y(16)+y(16))/(y(16)*y(16)*y(16)*y(16));
g2_v(24)=(-((params(13)-1)*T(18)));
g2_v(25)=(-(T(6)*(1-params(13))*params(8)*(-((-T(2))*(y(23)+y(23))))/(y(23)*y(23)*y(23)*y(23))));
g2_v(26)=(-T(19));
g2_v(27)=(-T(10));
g2_v(28)=g2_v(27);
g2_v(29)=T(20);
g2_v(30)=(-1)/((1+y(7))*(1+y(7)));
g2_v(31)=g2_v(30);
g2_v(32)=T(21);
g2_v(33)=(-1)/((1+y(8))*(1+y(8)));
g2_v(34)=g2_v(33);
g2_v(35)=(1-params(13))*params(8)/params(10)*getPowerDeriv(y(5),params(10),2);
g2_v(36)=(-T(17));
g2_v(37)=g2_v(36);
g2_v(38)=(-(T(2)*(1-params(12))))/(y(23)*y(23));
g2_v(39)=g2_v(38);
g2_v(40)=T(4)*y(17)*params(4)*getPowerDeriv(y(15),params(4)-1,2);
g2_v(41)=T(14)*params(4)*y(17)*T(16);
g2_v(42)=g2_v(41);
g2_v(43)=T(14)*T(4)*params(4);
g2_v(44)=g2_v(43);
g2_v(45)=T(7)*params(4)*y(17)*(y(16)+y(16))/(y(16)*y(16)*y(16)*y(16));
g2_v(46)=T(7)*params(4)*T(16);
g2_v(47)=g2_v(46);
g2_v(48)=(-((1+y(7))*T(18)));
g2_v(49)=(1+y(21))*(-((-(T(2)*(1-params(12))))*(y(23)+y(23))))/(y(23)*y(23)*y(23)*y(23));
g2_v(50)=(-T(20));
g2_v(51)=(-((-1)/((1+y(7))*(1+y(7)))));
g2_v(52)=g2_v(51);
g2_v(53)=(-(y(17)*getPowerDeriv(y(15),params(4),2)));
g2_v(54)=(-T(15));
g2_v(55)=g2_v(54);
g2_v(56)=(-T(21));
g2_v(57)=T(11);
g2_v(58)=g2_v(57);
g2 = sparse(g2_i,g2_j,g2_v,15,625);
end
