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
g2_i = zeros(56,1);
g2_j = zeros(56,1);
g2_v = zeros(56,1);

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
g2_i(45)=7;
g2_i(46)=7;
g2_i(47)=7;
g2_i(48)=8;
g2_i(49)=8;
g2_i(50)=8;
g2_i(51)=9;
g2_i(52)=9;
g2_i(53)=9;
g2_i(54)=11;
g2_i(55)=11;
g2_i(56)=11;
g2_j(1)=97;
g2_j(2)=107;
g2_j(3)=327;
g2_j(4)=241;
g2_j(5)=250;
g2_j(6)=448;
g2_j(7)=337;
g2_j(8)=457;
g2_j(9)=97;
g2_j(10)=103;
g2_j(11)=235;
g2_j(12)=1;
g2_j(13)=97;
g2_j(14)=107;
g2_j(15)=327;
g2_j(16)=145;
g2_j(17)=153;
g2_j(18)=329;
g2_j(19)=241;
g2_j(20)=250;
g2_j(21)=448;
g2_j(22)=337;
g2_j(23)=457;
g2_j(24)=97;
g2_j(25)=103;
g2_j(26)=235;
g2_j(27)=121;
g2_j(28)=128;
g2_j(29)=282;
g2_j(30)=145;
g2_j(31)=150;
g2_j(32)=260;
g2_j(33)=1;
g2_j(34)=135;
g2_j(35)=443;
g2_j(36)=435;
g2_j(37)=479;
g2_j(38)=313;
g2_j(39)=314;
g2_j(40)=336;
g2_j(41)=315;
g2_j(42)=359;
g2_j(43)=337;
g2_j(44)=338;
g2_j(45)=360;
g2_j(46)=457;
g2_j(47)=481;
g2_j(48)=121;
g2_j(49)=128;
g2_j(50)=282;
g2_j(51)=313;
g2_j(52)=315;
g2_j(53)=359;
g2_j(54)=145;
g2_j(55)=150;
g2_j(56)=260;
g2_v(1)=(-((-y(15))*(y(15)*y(15)*(1+y(5))+y(15)*y(15)*(1+y(5)))))/(y(15)*(1+y(5))*y(15)*(1+y(5))*y(15)*(1+y(5))*y(15)*(1+y(5)));
g2_v(2)=((-(y(15)*(1+y(5))*y(15)*(1+y(5))))-(-y(15))*((1+y(5))*y(15)*(1+y(5))+(1+y(5))*y(15)*(1+y(5))))/(y(15)*(1+y(5))*y(15)*(1+y(5))*y(15)*(1+y(5))*y(15)*(1+y(5)));
g2_v(3)=g2_v(2);
g2_v(4)=(-(T(1)*params(7)*(1-params(13))*getPowerDeriv(y(11),params(9)-1,2)));
g2_v(5)=(-(T(11)*T(16)));
g2_v(6)=g2_v(5);
g2_v(7)=(-((-(1+y(5)))*((1+y(5))*y(15)*(1+y(5))+(1+y(5))*y(15)*(1+y(5)))))/(y(15)*(1+y(5))*y(15)*(1+y(5))*y(15)*(1+y(5))*y(15)*(1+y(5)));
g2_v(8)=(-(T(2)*T(17)));
g2_v(9)=T(18);
g2_v(10)=T(10);
g2_v(11)=g2_v(10);
g2_v(12)=(-((1-params(13))*params(7)/params(9)*getPowerDeriv(y(1),params(9),2)));
g2_v(13)=T(3)*(1+y(5)+1+y(5))/((1+y(5))*(1+y(5))*(1+y(5))*(1+y(5)));
g2_v(14)=T(10)*T(15);
g2_v(15)=g2_v(14);
g2_v(16)=T(3)*(-((-((-params(5))*(1+y(7)+1+y(7))))/((1+y(7))*(1+y(7))*(1+y(7))*(1+y(7)))));
g2_v(17)=(-((-params(5))/((1+y(7))*(1+y(7)))))*T(15);
g2_v(18)=g2_v(17);
g2_v(19)=(-(T(1)*(1-params(13))*params(8)*getPowerDeriv(y(11),params(10)-1,2)));
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
g2_v(30)=T(20);
g2_v(31)=(-1)/((1+y(7))*(1+y(7)));
g2_v(32)=g2_v(31);
g2_v(33)=(1-params(13))*params(8)/params(10)*getPowerDeriv(y(1),params(10),2);
g2_v(34)=(-T(16));
g2_v(35)=g2_v(34);
g2_v(36)=(-T(7))/(y(21)*y(21));
g2_v(37)=g2_v(36);
g2_v(38)=T(3)*y(16)*params(4)*getPowerDeriv(y(14),params(4)-1,2);
g2_v(39)=T(13)*params(4)*y(16)*T(15);
g2_v(40)=g2_v(39);
g2_v(41)=T(13)*T(3)*params(4);
g2_v(42)=g2_v(41);
g2_v(43)=T(6)*params(4)*y(16)*(y(15)+y(15))/(y(15)*y(15)*y(15)*y(15));
g2_v(44)=T(6)*params(4)*T(15);
g2_v(45)=g2_v(44);
g2_v(46)=(-((1+y(6))*T(17)));
g2_v(47)=(1+y(19))*(-((-T(7))*(y(21)+y(21))))/(y(21)*y(21)*y(21)*y(21));
g2_v(48)=(-T(19));
g2_v(49)=(-((-1)/((1+y(6))*(1+y(6)))));
g2_v(50)=g2_v(49);
g2_v(51)=(-(y(16)*getPowerDeriv(y(14),params(4),2)));
g2_v(52)=(-T(14));
g2_v(53)=g2_v(52);
g2_v(54)=(-T(20));
g2_v(55)=(-((-1)/((1+y(7))*(1+y(7)))));
g2_v(56)=g2_v(55);
g2 = sparse(g2_i,g2_j,g2_v,14,529);
end
