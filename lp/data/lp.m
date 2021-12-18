%% Extra Crowding Out of SOFR %%
%% Time Series Analysis
%% Qian Wu %%
clear variables;
close all;
userpath('clear');
clc;
cd '/Users/mac/Desktop//Research/sofr/lp';


%% Identify Government Debt Shock

% Read data
addpath('data');
shock=readtable('shock_data.csv');
log_debt=log(shock{:,3});
log_output=log(shock{:,4});
log_stock=log(shock{:,5});
shock_data=[log_debt log_output log_stock];

% Identify Debt shock 
shock_lag=lagmatrix(shock_data, [1 2 3 4 5 6]);
cont=zeros(203, 1)+1;
t=linspace(1, 203, 203);
t2=t.^2;
shock_x=[shock_lag t' cont];
shock_x=shock_x(7:end,:);
est_6=inv(shock_x'*shock_x)*shock_x'*log_debt(7:end);

debt_shock_6=log_debt(7:end)-shock_x*est_6;


shock_lag=lagmatrix(shock_data, [1 2 3 4 5 6 7 8 9 10 11 12]);
cont=zeros(203, 1)+1;
t=linspace(1, 203, 203);
t2=t.^2;
shock_x=[shock_lag t' cont];
shock_x=shock_x(13:end,:);
est_12=inv(shock_x'*shock_x)*shock_x'*log_debt(13:end);

debt_shock_12=log_debt(13:end)-shock_x*est_12;

% Plot Debt Shock
plot(debt_shock_6(7:end))
hold on
plot(debt_shock_12)

% Save Debt Shock
debt_shock_6=[zeros(6, 1); debt_shock_6];
debt_shock_12=[zeros(12, 1); debt_shock_12];
year=shock{:,1};
month=shock{:,2};
debt_shock=table(year, month, debt_shock_6, debt_shock_12);
writetable(debt_shock, 'results/debt_shock.csv');



%% Local Projection

% Read data
lp=readtable('data/lp_data.csv');
libor_spread=lp{:,3}-lp{:,5};
sofr_spread=lp{:,4}-lp{:,5};
diff=sofr_spread-libor_spread;
log_debt=log(lp{:,6});
log_ip=log(lp{:,7});

% Use BVAR toolbox
addpath('BVAR_-master-2');
addpath('BVAR_-master-2/cmintools', 'BVAR_-master-2/v4.1');

% Local projection with IV
y=[log_debt sofr_spread libor_spread];
options.proxy=debt_shock_6(139:end);
options.varnames={'debt' 'sofr' 'libor'};
lags=3;
options.hor=12;
dm=directmethods(y, lags, options);
plot_irfs_(dm.irproxy_lp(:,:,1,:), options)
print -depsc results/LP.eps;

% One variable at a time
y1=[sofr_spread];
options1.proxy=debt_shock_6(139:end);
options1.varnames={'sofr'};
lags=3;
options1.hor=12;
dm1=directmethods(y1, lags, options1);
plot_irfs_(dm1.irproxy_lp(:,:,1,:), options1)
print -depsc results/LP1.eps;

y2=[libor_spread];
options2.proxy=debt_shock_6(139:end);
options2.varnames={'libor'};
lags=3;
options2.hor=12;
dm2=directmethods(y2, lags, options2)
plot_irfs_(dm2.irproxy_lp(:,:,1,:), options2)
print -depsc results/LP2.eps;










