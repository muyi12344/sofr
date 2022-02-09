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
g2_i = zeros(33,1);
g2_j = zeros(33,1);
g2_v = zeros(33,1);

g2_i(1)=2;
g2_i(2)=2;
g2_i(3)=2;
g2_i(4)=2;
g2_i(5)=2;
g2_i(6)=2;
g2_i(7)=2;
g2_i(8)=2;
g2_i(9)=3;
g2_i(10)=3;
g2_i(11)=3;
g2_i(12)=3;
g2_i(13)=4;
g2_i(14)=4;
g2_i(15)=4;
g2_i(16)=4;
g2_i(17)=4;
g2_i(18)=4;
g2_i(19)=4;
g2_i(20)=4;
g2_i(21)=4;
g2_i(22)=4;
g2_i(23)=5;
g2_i(24)=5;
g2_i(25)=5;
g2_i(26)=5;
g2_i(27)=5;
g2_i(28)=5;
g2_i(29)=5;
g2_i(30)=7;
g2_i(31)=7;
g2_i(32)=7;
g2_i(33)=9;
g2_j(1)=52;
g2_j(2)=58;
g2_j(3)=148;
g2_j(4)=120;
g2_j(5)=127;
g2_j(6)=232;
g2_j(7)=154;
g2_j(8)=222;
g2_j(9)=52;
g2_j(10)=56;
g2_j(11)=116;
g2_j(12)=35;
g2_j(13)=52;
g2_j(14)=58;
g2_j(15)=148;
g2_j(16)=69;
g2_j(17)=74;
g2_j(18)=149;
g2_j(19)=127;
g2_j(20)=232;
g2_j(21)=154;
g2_j(22)=222;
g2_j(23)=52;
g2_j(24)=56;
g2_j(25)=116;
g2_j(26)=69;
g2_j(27)=73;
g2_j(28)=133;
g2_j(29)=35;
g2_j(30)=69;
g2_j(31)=73;
g2_j(32)=133;
g2_j(33)=222;
g2_v(1)=(-((-y(10))*(y(10)*y(10)*(1+y(4))+y(10)*y(10)*(1+y(4)))))/(y(10)*(1+y(4))*y(10)*(1+y(4))*y(10)*(1+y(4))*y(10)*(1+y(4)));
g2_v(2)=((-(y(10)*(1+y(4))*y(10)*(1+y(4))))-(-y(10))*((1+y(4))*y(10)*(1+y(4))+(1+y(4))*y(10)*(1+y(4))))/(y(10)*(1+y(4))*y(10)*(1+y(4))*y(10)*(1+y(4))*y(10)*(1+y(4)));
g2_v(3)=g2_v(2);
g2_v(4)=(-(T(7)*getPowerDeriv(y(8),(-0.5),2)));
g2_v(5)=(-(T(11)*params(4)*T(2)));
g2_v(6)=g2_v(5);
g2_v(7)=(-((-(1+y(4)))*((1+y(4))*y(10)*(1+y(4))+(1+y(4))*y(10)*(1+y(4)))))/(y(10)*(1+y(4))*y(10)*(1+y(4))*y(10)*(1+y(4))*y(10)*(1+y(4)));
g2_v(8)=(-(params(7)*(-((-params(3))*(y(14)+y(14))))/(y(14)*y(14)*y(14)*y(14))));
g2_v(9)=T(12);
g2_v(10)=T(9);
g2_v(11)=g2_v(10);
g2_v(12)=(-(2*params(4)*(1-params(7))*0.5*(1-params(7))*getPowerDeriv((1-params(7))*y(3),(-0.5),1)));
g2_v(13)=T(4)*(1+y(4)+1+y(4))/((1+y(4))*(1+y(4))*(1+y(4))*(1+y(4)));
g2_v(14)=T(9)*(-1)/(y(10)*y(10));
g2_v(15)=g2_v(14);
g2_v(16)=T(4)*(-((1+y(5)+1+y(5))/((1+y(5))*(1+y(5))*(1+y(5))*(1+y(5)))));
g2_v(17)=T(10)*(-1)/(y(10)*y(10));
g2_v(18)=g2_v(17);
g2_v(19)=(-(params(5)*T(6)));
g2_v(20)=g2_v(19);
g2_v(21)=T(5)*(y(10)+y(10))/(y(10)*y(10)*y(10)*y(10));
g2_v(22)=(-((params(7)-1)*(-((-params(3))*(y(14)+y(14))))/(y(14)*y(14)*y(14)*y(14))));
g2_v(23)=(-T(12));
g2_v(24)=(-T(9));
g2_v(25)=g2_v(24);
g2_v(26)=T(13);
g2_v(27)=(-1)/((1+y(5))*(1+y(5)));
g2_v(28)=g2_v(27);
g2_v(29)=0.5*params(5)*(1-params(7))*2*(1-params(7));
g2_v(30)=(-T(13));
g2_v(31)=T(10);
g2_v(32)=g2_v(31);
g2_v(33)=(-((-((-T(1))*(y(14)+y(14))))/(y(14)*y(14)*y(14)*y(14))));
g2 = sparse(g2_i,g2_j,g2_v,10,256);
end
