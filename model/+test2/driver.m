%
% Status : main Dynare file
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

if isoctave || matlab_ver_less_than('8.6')
    clear all
else
    clearvars -global
    clear_persistent_variables(fileparts(which('dynare')), false)
end
tic0 = tic;
% Define global variables.
global M_ options_ oo_ estim_params_ bayestopt_ dataset_ dataset_info estimation_info ys0_ ex0_
options_ = [];
M_.fname = 'test2';
M_.dynare_version = '5.0';
oo_.dynare_version = '5.0';
options_.dynare_version = '5.0';
%
% Some global variables initialization
%
global_initialization;
M_.exo_names = cell(2,1);
M_.exo_names_tex = cell(2,1);
M_.exo_names_long = cell(2,1);
M_.exo_names(1) = {'ea'};
M_.exo_names_tex(1) = {'ea'};
M_.exo_names_long(1) = {'ea'};
M_.exo_names(2) = {'eg'};
M_.exo_names_tex(2) = {'eg'};
M_.exo_names_long(2) = {'eg'};
M_.endo_names = cell(14,1);
M_.endo_names_tex = cell(14,1);
M_.endo_names_long = cell(14,1);
M_.endo_names(1) = {'rI'};
M_.endo_names_tex(1) = {'rI'};
M_.endo_names_long(1) = {'rI'};
M_.endo_names(2) = {'rL'};
M_.endo_names_tex(2) = {'rL'};
M_.endo_names_long(2) = {'rL'};
M_.endo_names(3) = {'rB'};
M_.endo_names_tex(3) = {'rB'};
M_.endo_names_long(3) = {'rB'};
M_.endo_names(4) = {'dD'};
M_.endo_names_tex(4) = {'dD'};
M_.endo_names_long(4) = {'dD'};
M_.endo_names(5) = {'dC'};
M_.endo_names_tex(5) = {'dC'};
M_.endo_names_long(5) = {'dC'};
M_.endo_names(6) = {'dF'};
M_.endo_names_tex(6) = {'dF'};
M_.endo_names_long(6) = {'dF'};
M_.endo_names(7) = {'I'};
M_.endo_names_tex(7) = {'I'};
M_.endo_names_long(7) = {'I'};
M_.endo_names(8) = {'B'};
M_.endo_names_tex(8) = {'B'};
M_.endo_names_long(8) = {'B'};
M_.endo_names(9) = {'L'};
M_.endo_names_tex(9) = {'L'};
M_.endo_names_long(9) = {'L'};
M_.endo_names(10) = {'K'};
M_.endo_names_tex(10) = {'K'};
M_.endo_names_long(10) = {'K'};
M_.endo_names(11) = {'C'};
M_.endo_names_tex(11) = {'C'};
M_.endo_names_long(11) = {'C'};
M_.endo_names(12) = {'A'};
M_.endo_names_tex(12) = {'A'};
M_.endo_names_long(12) = {'A'};
M_.endo_names(13) = {'G'};
M_.endo_names_tex(13) = {'G'};
M_.endo_names_long(13) = {'G'};
M_.endo_names(14) = {'AUX_ENDO_LEAD_99'};
M_.endo_names_tex(14) = {'AUX\_ENDO\_LEAD\_99'};
M_.endo_names_long(14) = {'AUX_ENDO_LEAD_99'};
M_.endo_partitions = struct();
M_.param_names = cell(15,1);
M_.param_names_tex = cell(15,1);
M_.param_names_long = cell(15,1);
M_.param_names(1) = {'T'};
M_.param_names_tex(1) = {'T'};
M_.param_names_long(1) = {'T'};
M_.param_names(2) = {'D'};
M_.param_names_tex(2) = {'D'};
M_.param_names_long(2) = {'D'};
M_.param_names(3) = {'beta'};
M_.param_names_tex(3) = {'beta'};
M_.param_names_long(3) = {'beta'};
M_.param_names(4) = {'alpha'};
M_.param_names_tex(4) = {'alpha'};
M_.param_names_long(4) = {'alpha'};
M_.param_names(5) = {'phi'};
M_.param_names_tex(5) = {'phi'};
M_.param_names_long(5) = {'phi'};
M_.param_names(6) = {'omega'};
M_.param_names_tex(6) = {'omega'};
M_.param_names_long(6) = {'omega'};
M_.param_names(7) = {'thetaD'};
M_.param_names_tex(7) = {'thetaD'};
M_.param_names_long(7) = {'thetaD'};
M_.param_names(8) = {'thetaC'};
M_.param_names_tex(8) = {'thetaC'};
M_.param_names_long(8) = {'thetaC'};
M_.param_names(9) = {'lambdaD'};
M_.param_names_tex(9) = {'lambdaD'};
M_.param_names_long(9) = {'lambdaD'};
M_.param_names(10) = {'lambdaC'};
M_.param_names_tex(10) = {'lambdaC'};
M_.param_names_long(10) = {'lambdaC'};
M_.param_names(11) = {'xiC'};
M_.param_names_tex(11) = {'xiC'};
M_.param_names_long(11) = {'xiC'};
M_.param_names(12) = {'delta'};
M_.param_names_tex(12) = {'delta'};
M_.param_names_long(12) = {'delta'};
M_.param_names(13) = {'gammaI'};
M_.param_names_tex(13) = {'gammaI'};
M_.param_names_long(13) = {'gammaI'};
M_.param_names(14) = {'Abar'};
M_.param_names_tex(14) = {'Abar'};
M_.param_names_long(14) = {'Abar'};
M_.param_names(15) = {'Gbar'};
M_.param_names_tex(15) = {'Gbar'};
M_.param_names_long(15) = {'Gbar'};
M_.param_partitions = struct();
M_.exo_det_nbr = 0;
M_.exo_nbr = 2;
M_.endo_nbr = 14;
M_.param_nbr = 15;
M_.orig_endo_nbr = 13;
M_.aux_vars(1).endo_index = 14;
M_.aux_vars(1).type = 0;
M_.aux_vars(1).orig_expr = 'C(1)';
M_ = setup_solvers(M_);
M_.Sigma_e = zeros(2, 2);
M_.Correlation_matrix = eye(2, 2);
M_.H = 0;
M_.Correlation_matrix_ME = 1;
M_.sigma_e_is_diagonal = true;
M_.det_shocks = [];
M_.surprise_shocks = [];
M_.heteroskedastic_shocks.Qvalue_orig = [];
M_.heteroskedastic_shocks.Qscale_orig = [];
options_.linear = false;
options_.block = false;
options_.bytecode = false;
options_.use_dll = false;
M_.nonzero_hessian_eqs = [1 2 3 5 7 8 9 11];
M_.hessian_eq_zero = isempty(M_.nonzero_hessian_eqs);
M_.orig_eq_nbr = 13;
M_.eq_nbr = 14;
M_.ramsey_eq_nbr = 0;
M_.set_auxiliary_variables = exist(['./+' M_.fname '/set_auxiliary_variables.m'], 'file') == 2;
M_.epilogue_names = {};
M_.epilogue_var_list_ = {};
M_.orig_maximum_endo_lag = 1;
M_.orig_maximum_endo_lead = 2;
M_.orig_maximum_exo_lag = 0;
M_.orig_maximum_exo_lead = 0;
M_.orig_maximum_exo_det_lag = 0;
M_.orig_maximum_exo_det_lead = 0;
M_.orig_maximum_lag = 1;
M_.orig_maximum_lead = 2;
M_.orig_maximum_lag_with_diffs_expanded = 1;
M_.lead_lag_incidence = [
 0 5 0;
 0 6 19;
 0 7 0;
 0 8 0;
 0 9 0;
 0 10 0;
 1 11 0;
 2 12 0;
 3 13 0;
 4 14 0;
 0 15 20;
 0 16 0;
 0 17 0;
 0 18 21;]';
M_.nstatic = 7;
M_.nfwrd   = 3;
M_.npred   = 4;
M_.nboth   = 0;
M_.nsfwrd   = 3;
M_.nspred   = 4;
M_.ndynamic   = 7;
M_.dynamic_tmp_nbr = [9; 7; 4; 0; ];
M_.model_local_variables_dynamic_tt_idxs = {
};
M_.equations_tags = {
  1 , 'name' , '1' ;
  2 , 'name' , 'dD' ;
  3 , 'name' , '3' ;
  4 , 'name' , 'B' ;
  5 , 'name' , 'dC' ;
  6 , 'name' , 'rL' ;
  7 , 'name' , '7' ;
  8 , 'name' , 'K' ;
  9 , 'name' , 'dF' ;
  10 , 'name' , 'C' ;
  11 , 'name' , '11' ;
  12 , 'name' , 'G' ;
  13 , 'name' , 'A' ;
};
M_.mapping.rI.eqidx = [1 2 3 5 6 ];
M_.mapping.rL.eqidx = [5 6 7 8 ];
M_.mapping.rB.eqidx = [3 5 11 ];
M_.mapping.dD.eqidx = [2 10 ];
M_.mapping.dC.eqidx = [5 10 ];
M_.mapping.dF.eqidx = [9 10 ];
M_.mapping.I.eqidx = [1 2 3 4 5 ];
M_.mapping.B.eqidx = [4 5 11 ];
M_.mapping.L.eqidx = [5 8 9 ];
M_.mapping.K.eqidx = [7 8 9 ];
M_.mapping.C.eqidx = [1 3 7 10 ];
M_.mapping.A.eqidx = [7 9 13 ];
M_.mapping.G.eqidx = [11 12 ];
M_.mapping.ea.eqidx = [13 ];
M_.mapping.eg.eqidx = [12 ];
M_.static_and_dynamic_models_differ = false;
M_.has_external_function = false;
M_.state_var = [7 8 9 10 ];
M_.exo_names_orig_ord = [1:2];
M_.maximum_lag = 1;
M_.maximum_lead = 1;
M_.maximum_endo_lag = 1;
M_.maximum_endo_lead = 1;
oo_.steady_state = zeros(14, 1);
M_.maximum_exo_lag = 0;
M_.maximum_exo_lead = 0;
oo_.exo_steady_state = zeros(2, 1);
M_.params = NaN(15, 1);
M_.endo_trends = struct('deflator', cell(14, 1), 'log_deflator', cell(14, 1), 'growth_factor', cell(14, 1), 'log_growth_factor', cell(14, 1));
M_.NNZDerivatives = [56; 56; -1; ];
M_.static_tmp_nbr = [9; 0; 0; 0; ];
M_.model_local_variables_static_tt_idxs = {
};
M_.params(2) = 0;
D = M_.params(2);
M_.params(1) = 1.0002;
T = M_.params(1);
M_.params(3) = 0.997;
beta = M_.params(3);
M_.params(4) = 0.4;
alpha = M_.params(4);
M_.params(5) = 2;
phi = M_.params(5);
M_.params(6) = 0.009;
omega = M_.params(6);
M_.params(7) = 0.6;
thetaD = M_.params(7);
M_.params(9) = 1;
lambdaD = M_.params(9);
M_.params(8) = 0.5;
thetaC = M_.params(8);
M_.params(10) = 2;
lambdaC = M_.params(10);
M_.params(11) = 0.2;
xiC = M_.params(11);
M_.params(12) = 0.03;
delta = M_.params(12);
M_.params(13) = 0.99;
gammaI = M_.params(13);
M_.params(14) = 1;
Abar = M_.params(14);
M_.params(15) = 1;
Gbar = M_.params(15);
%
% INITVAL instructions
%
options_.initval_file = false;
oo_.steady_state(1) = 0.0086;
oo_.steady_state(2) = 0.0176;
oo_.steady_state(3) = 0.004;
oo_.steady_state(4) = 0;
oo_.steady_state(5) = 0.058;
oo_.steady_state(6) = 9.8;
oo_.steady_state(7) = 1.1;
oo_.steady_state(8) = 1.1;
oo_.steady_state(9) = 2.946;
oo_.steady_state(10) = 579;
oo_.steady_state(11) = 9.6488;
oo_.steady_state(14)=oo_.steady_state(11);
if M_.exo_nbr > 0
	oo_.exo_simul = ones(M_.maximum_lag,1)*oo_.exo_steady_state';
end
if M_.exo_det_nbr > 0
	oo_.exo_det_simul = ones(M_.maximum_lag,1)*oo_.exo_det_steady_state';
end
%
% SHOCKS instructions
%
M_.exo_det_length = 0;
M_.Sigma_e(1, 1) = (0.001)^2;
M_.Sigma_e(2, 2) = (0.001)^2;
options_.dynatol.f=0.0001;
options_.solve_algo = 0;
options_.steady.maxit = 10000;
steady;
oo_.dr.eigval = check(M_,options_,oo_);


oo_.time = toc(tic0);
disp(['Total computing time : ' dynsec2hms(oo_.time) ]);
if ~exist([M_.dname filesep 'Output'],'dir')
    mkdir(M_.dname,'Output');
end
save([M_.dname filesep 'Output' filesep 'test2_results.mat'], 'oo_', 'M_', 'options_');
if exist('estim_params_', 'var') == 1
  save([M_.dname filesep 'Output' filesep 'test2_results.mat'], 'estim_params_', '-append');
end
if exist('bayestopt_', 'var') == 1
  save([M_.dname filesep 'Output' filesep 'test2_results.mat'], 'bayestopt_', '-append');
end
if exist('dataset_', 'var') == 1
  save([M_.dname filesep 'Output' filesep 'test2_results.mat'], 'dataset_', '-append');
end
if exist('estimation_info', 'var') == 1
  save([M_.dname filesep 'Output' filesep 'test2_results.mat'], 'estimation_info', '-append');
end
if exist('dataset_info', 'var') == 1
  save([M_.dname filesep 'Output' filesep 'test2_results.mat'], 'dataset_info', '-append');
end
if exist('oo_recursive_', 'var') == 1
  save([M_.dname filesep 'Output' filesep 'test2_results.mat'], 'oo_recursive_', '-append');
end
if ~isempty(lastwarn)
  disp('Note: warning(s) encountered in MATLAB/Octave code')
end
