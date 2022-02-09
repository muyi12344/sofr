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
M_.fname = 'model';
M_.dynare_version = '5.0';
oo_.dynare_version = '5.0';
options_.dynare_version = '5.0';
%
% Some global variables initialization
%
global_initialization;
M_.exo_names = {};
M_.exo_names_tex = {};
M_.exo_names_long = {};
M_.endo_names = cell(19,1);
M_.endo_names_tex = cell(19,1);
M_.endo_names_long = cell(19,1);
M_.endo_names(1) = {'r'};
M_.endo_names_tex(1) = {'r'};
M_.endo_names_long(1) = {'r'};
M_.endo_names(2) = {'rI'};
M_.endo_names_tex(2) = {'rI'};
M_.endo_names_long(2) = {'rI'};
M_.endo_names(3) = {'rL'};
M_.endo_names_tex(3) = {'rL'};
M_.endo_names_long(3) = {'rL'};
M_.endo_names(4) = {'rB'};
M_.endo_names_tex(4) = {'rB'};
M_.endo_names_long(4) = {'rB'};
M_.endo_names(5) = {'dD'};
M_.endo_names_tex(5) = {'dD'};
M_.endo_names_long(5) = {'dD'};
M_.endo_names(6) = {'dC'};
M_.endo_names_tex(6) = {'dC'};
M_.endo_names_long(6) = {'dC'};
M_.endo_names(7) = {'dF'};
M_.endo_names_tex(7) = {'dF'};
M_.endo_names_long(7) = {'dF'};
M_.endo_names(8) = {'I'};
M_.endo_names_tex(8) = {'I'};
M_.endo_names_long(8) = {'I'};
M_.endo_names(9) = {'B'};
M_.endo_names_tex(9) = {'B'};
M_.endo_names_long(9) = {'B'};
M_.endo_names(10) = {'L'};
M_.endo_names_tex(10) = {'L'};
M_.endo_names_long(10) = {'L'};
M_.endo_names(11) = {'K'};
M_.endo_names_tex(11) = {'K'};
M_.endo_names_long(11) = {'K'};
M_.endo_names(12) = {'w'};
M_.endo_names_tex(12) = {'w'};
M_.endo_names_long(12) = {'w'};
M_.endo_names(13) = {'C'};
M_.endo_names_tex(13) = {'C'};
M_.endo_names_long(13) = {'C'};
M_.endo_names(14) = {'gammaI'};
M_.endo_names_tex(14) = {'gammaI'};
M_.endo_names_long(14) = {'gammaI'};
M_.endo_names(15) = {'gammaL'};
M_.endo_names_tex(15) = {'gammaL'};
M_.endo_names_long(15) = {'gammaL'};
M_.endo_names(16) = {'D'};
M_.endo_names_tex(16) = {'D'};
M_.endo_names_long(16) = {'D'};
M_.endo_names(17) = {'AUX_ENDO_LEAD_71'};
M_.endo_names_tex(17) = {'AUX\_ENDO\_LEAD\_71'};
M_.endo_names_long(17) = {'AUX_ENDO_LEAD_71'};
M_.endo_names(18) = {'AUX_ENDO_LEAD_130'};
M_.endo_names_tex(18) = {'AUX\_ENDO\_LEAD\_130'};
M_.endo_names_long(18) = {'AUX_ENDO_LEAD_130'};
M_.endo_names(19) = {'AUX_ENDO_LAG_7_1'};
M_.endo_names_tex(19) = {'AUX\_ENDO\_LAG\_7\_1'};
M_.endo_names_long(19) = {'AUX_ENDO_LAG_7_1'};
M_.endo_partitions = struct();
M_.param_names = cell(9,1);
M_.param_names_tex = cell(9,1);
M_.param_names_long = cell(9,1);
M_.param_names(1) = {'G'};
M_.param_names_tex(1) = {'G'};
M_.param_names_long(1) = {'G'};
M_.param_names(2) = {'N'};
M_.param_names_tex(2) = {'N'};
M_.param_names_long(2) = {'N'};
M_.param_names(3) = {'T'};
M_.param_names_tex(3) = {'T'};
M_.param_names_long(3) = {'T'};
M_.param_names(4) = {'beta'};
M_.param_names_tex(4) = {'beta'};
M_.param_names_long(4) = {'beta'};
M_.param_names(5) = {'alpha'};
M_.param_names_tex(5) = {'alpha'};
M_.param_names_long(5) = {'alpha'};
M_.param_names(6) = {'theta'};
M_.param_names_tex(6) = {'theta'};
M_.param_names_long(6) = {'theta'};
M_.param_names(7) = {'xiC'};
M_.param_names_tex(7) = {'xiC'};
M_.param_names_long(7) = {'xiC'};
M_.param_names(8) = {'xiF'};
M_.param_names_tex(8) = {'xiF'};
M_.param_names_long(8) = {'xiF'};
M_.param_names(9) = {'delta'};
M_.param_names_tex(9) = {'delta'};
M_.param_names_long(9) = {'delta'};
M_.param_partitions = struct();
M_.exo_det_nbr = 0;
M_.exo_nbr = 0;
M_.endo_nbr = 19;
M_.param_nbr = 9;
M_.orig_endo_nbr = 16;
M_.aux_vars(1).endo_index = 17;
M_.aux_vars(1).type = 0;
M_.aux_vars(1).orig_expr = 'C(1)';
M_.aux_vars(2).endo_index = 18;
M_.aux_vars(2).type = 0;
M_.aux_vars(2).orig_expr = 'gammaL(1)';
M_.aux_vars(3).endo_index = 19;
M_.aux_vars(3).type = 1;
M_.aux_vars(3).orig_index = 8;
M_.aux_vars(3).orig_lead_lag = -1;
M_.aux_vars(3).orig_expr = 'I(-1)';
M_ = setup_solvers(M_);
M_.Sigma_e = zeros(0, 0);
M_.Correlation_matrix = eye(0, 0);
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
M_.nonzero_hessian_eqs = [1 2 4 5 6 7 8 9 11 12 14 15 16];
M_.hessian_eq_zero = isempty(M_.nonzero_hessian_eqs);
M_.orig_eq_nbr = 16;
M_.eq_nbr = 19;
M_.ramsey_eq_nbr = 0;
M_.set_auxiliary_variables = exist(['./+' M_.fname '/set_auxiliary_variables.m'], 'file') == 2;
M_.epilogue_names = {};
M_.epilogue_var_list_ = {};
M_.orig_maximum_endo_lag = 2;
M_.orig_maximum_endo_lead = 2;
M_.orig_maximum_exo_lag = 0;
M_.orig_maximum_exo_lead = 0;
M_.orig_maximum_exo_det_lag = 0;
M_.orig_maximum_exo_det_lead = 0;
M_.orig_maximum_lag = 2;
M_.orig_maximum_lead = 2;
M_.orig_maximum_lag_with_diffs_expanded = 2;
M_.lead_lag_incidence = [
 0 8 0;
 0 9 0;
 0 10 27;
 0 11 0;
 0 12 0;
 0 13 0;
 0 14 0;
 1 15 0;
 2 16 0;
 3 17 0;
 4 18 0;
 0 19 0;
 0 20 28;
 5 21 29;
 0 22 30;
 6 23 0;
 0 24 31;
 0 25 32;
 7 26 0;]';
M_.nstatic = 7;
M_.nfwrd   = 5;
M_.npred   = 6;
M_.nboth   = 1;
M_.nsfwrd   = 6;
M_.nspred   = 7;
M_.ndynamic   = 12;
M_.dynamic_tmp_nbr = [7; 6; 6; 0; ];
M_.model_local_variables_dynamic_tt_idxs = {
};
M_.equations_tags = {
  1 , 'name' , 'equation 3' ;
  2 , 'name' , 'equation 2' ;
  3 , 'name' , 'equation 6' ;
  4 , 'name' , 'equation 7' ;
  5 , 'name' , 'equation 5' ;
  6 , 'name' , 'equation 11' ;
  7 , 'name' , 'equation 12' ;
  8 , 'name' , 'equation 13' ;
  9 , 'name' , 'equation 9' ;
  10 , 'name' , 'equation 10' ;
  11 , 'name' , 'equation 17' ;
  12 , 'name' , 'equation 18' ;
  13 , 'name' , 'equation 19' ;
  14 , 'name' , 'equation 15' ;
  15 , 'name' , 'equation 16' ;
  16 , 'name' , 'equation 20' ;
};
M_.mapping.r.eqidx = [1 2 5 ];
M_.mapping.rI.eqidx = [4 5 6 9 ];
M_.mapping.rL.eqidx = [7 9 12 14 ];
M_.mapping.rB.eqidx = [6 9 16 ];
M_.mapping.dD.eqidx = [2 5 ];
M_.mapping.dC.eqidx = [2 9 ];
M_.mapping.dF.eqidx = [2 15 ];
M_.mapping.I.eqidx = [3 5 9 10 ];
M_.mapping.B.eqidx = [8 9 10 16 ];
M_.mapping.L.eqidx = [9 13 14 15 ];
M_.mapping.K.eqidx = [11 12 14 15 ];
M_.mapping.w.eqidx = [2 11 15 ];
M_.mapping.C.eqidx = [1 2 4 6 7 8 12 ];
M_.mapping.gammaI.eqidx = [4 5 6 9 ];
M_.mapping.gammaL.eqidx = [7 9 12 15 ];
M_.mapping.D.eqidx = [2 3 5 ];
M_.static_and_dynamic_models_differ = false;
M_.has_external_function = false;
M_.state_var = [8 9 10 11 14 16 19 ];
M_.exo_names_orig_ord = [1:0];
M_.maximum_lag = 1;
M_.maximum_lead = 1;
M_.maximum_endo_lag = 1;
M_.maximum_endo_lead = 1;
oo_.steady_state = zeros(19, 1);
M_.maximum_exo_lag = 0;
M_.maximum_exo_lead = 0;
oo_.exo_steady_state = zeros(0, 1);
M_.params = NaN(9, 1);
M_.endo_trends = struct('deflator', cell(19, 1), 'log_deflator', cell(19, 1), 'growth_factor', cell(19, 1), 'log_growth_factor', cell(19, 1));
M_.NNZDerivatives = [85; 93; -1; ];
M_.static_tmp_nbr = [7; 2; 0; 0; ];
M_.model_local_variables_static_tt_idxs = {
};
M_.params(1) = 0.2;
G = M_.params(1);
M_.params(2) = 0.7;
N = M_.params(2);
M_.params(3) = 0.23;
T = M_.params(3);
M_.params(4) = 0.9963;
beta = M_.params(4);
M_.params(5) = 0.33;
alpha = M_.params(5);
M_.params(6) = 0.8;
theta = M_.params(6);
M_.params(7) = 0.1;
xiC = M_.params(7);
M_.params(8) = 0.15;
xiF = M_.params(8);
M_.params(9) = 0.9;
delta = M_.params(9);
%
% INITVAL instructions
%
options_.initval_file = false;
oo_.steady_state(1) = 0.03;
oo_.steady_state(2) = 0.08;
oo_.steady_state(3) = 0.09;
oo_.steady_state(4) = 0.06;
oo_.steady_state(5) = 0.03;
oo_.steady_state(6) = (-0.01);
oo_.steady_state(7) = (-0.01);
oo_.steady_state(8) = 0.5;
oo_.steady_state(9) = 0.5;
oo_.steady_state(10) = 0.15;
oo_.steady_state(11) = 0.15;
oo_.steady_state(12) = 0.4;
oo_.steady_state(13) = 0.9;
oo_.steady_state(14) = 0.9;
oo_.steady_state(15) = 0.9;
oo_.steady_state(16) = 0.5;
oo_.steady_state(17)=oo_.steady_state(13);
oo_.steady_state(18)=oo_.steady_state(15);
oo_.steady_state(19)=oo_.steady_state(8);
if M_.exo_nbr > 0
	oo_.exo_simul = ones(M_.maximum_lag,1)*oo_.exo_steady_state';
end
if M_.exo_det_nbr > 0
	oo_.exo_det_simul = ones(M_.maximum_lag,1)*oo_.exo_det_steady_state';
end
options_.steady.maxit = 10000;
steady;
oo_.dr.eigval = check(M_,options_,oo_);
model_diagnostics(M_,options_,oo_);


oo_.time = toc(tic0);
disp(['Total computing time : ' dynsec2hms(oo_.time) ]);
if ~exist([M_.dname filesep 'Output'],'dir')
    mkdir(M_.dname,'Output');
end
save([M_.dname filesep 'Output' filesep 'model_results.mat'], 'oo_', 'M_', 'options_');
if exist('estim_params_', 'var') == 1
  save([M_.dname filesep 'Output' filesep 'model_results.mat'], 'estim_params_', '-append');
end
if exist('bayestopt_', 'var') == 1
  save([M_.dname filesep 'Output' filesep 'model_results.mat'], 'bayestopt_', '-append');
end
if exist('dataset_', 'var') == 1
  save([M_.dname filesep 'Output' filesep 'model_results.mat'], 'dataset_', '-append');
end
if exist('estimation_info', 'var') == 1
  save([M_.dname filesep 'Output' filesep 'model_results.mat'], 'estimation_info', '-append');
end
if exist('dataset_info', 'var') == 1
  save([M_.dname filesep 'Output' filesep 'model_results.mat'], 'dataset_info', '-append');
end
if exist('oo_recursive_', 'var') == 1
  save([M_.dname filesep 'Output' filesep 'model_results.mat'], 'oo_recursive_', '-append');
end
if ~isempty(lastwarn)
  disp('Note: warning(s) encountered in MATLAB/Octave code')
end
