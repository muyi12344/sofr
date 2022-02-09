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
M_.fname = 'test';
M_.dynare_version = '5.0';
oo_.dynare_version = '5.0';
options_.dynare_version = '5.0';
%
% Some global variables initialization
%
global_initialization;
M_.exo_names = cell(1,1);
M_.exo_names_tex = cell(1,1);
M_.exo_names_long = cell(1,1);
M_.exo_names(1) = {'eg'};
M_.exo_names_tex(1) = {'eg'};
M_.exo_names_long(1) = {'eg'};
M_.endo_names = cell(10,1);
M_.endo_names_tex = cell(10,1);
M_.endo_names_long = cell(10,1);
M_.endo_names(1) = {'rI'};
M_.endo_names_tex(1) = {'rI'};
M_.endo_names_long(1) = {'rI'};
M_.endo_names(2) = {'rB'};
M_.endo_names_tex(2) = {'rB'};
M_.endo_names_long(2) = {'rB'};
M_.endo_names(3) = {'dD'};
M_.endo_names_tex(3) = {'dD'};
M_.endo_names_long(3) = {'dD'};
M_.endo_names(4) = {'dC'};
M_.endo_names_tex(4) = {'dC'};
M_.endo_names_long(4) = {'dC'};
M_.endo_names(5) = {'I'};
M_.endo_names_tex(5) = {'I'};
M_.endo_names_long(5) = {'I'};
M_.endo_names(6) = {'B'};
M_.endo_names_tex(6) = {'B'};
M_.endo_names_long(6) = {'B'};
M_.endo_names(7) = {'C'};
M_.endo_names_tex(7) = {'C'};
M_.endo_names_long(7) = {'C'};
M_.endo_names(8) = {'G'};
M_.endo_names_tex(8) = {'G'};
M_.endo_names_long(8) = {'G'};
M_.endo_names(9) = {'AUX_ENDO_LEAD_29'};
M_.endo_names_tex(9) = {'AUX\_ENDO\_LEAD\_29'};
M_.endo_names_long(9) = {'AUX_ENDO_LEAD_29'};
M_.endo_names(10) = {'AUX_ENDO_LAG_4_1'};
M_.endo_names_tex(10) = {'AUX\_ENDO\_LAG\_4\_1'};
M_.endo_names_long(10) = {'AUX_ENDO_LAG_4_1'};
M_.endo_partitions = struct();
M_.param_names = cell(7,1);
M_.param_names_tex = cell(7,1);
M_.param_names_long = cell(7,1);
M_.param_names(1) = {'D'};
M_.param_names_tex(1) = {'D'};
M_.param_names_long(1) = {'D'};
M_.param_names(2) = {'T'};
M_.param_names_tex(2) = {'T'};
M_.param_names_long(2) = {'T'};
M_.param_names(3) = {'beta'};
M_.param_names_tex(3) = {'beta'};
M_.param_names_long(3) = {'beta'};
M_.param_names(4) = {'thetaD'};
M_.param_names_tex(4) = {'thetaD'};
M_.param_names_long(4) = {'thetaD'};
M_.param_names(5) = {'thetaC'};
M_.param_names_tex(5) = {'thetaC'};
M_.param_names_long(5) = {'thetaC'};
M_.param_names(6) = {'sigmag'};
M_.param_names_tex(6) = {'sigmag'};
M_.param_names_long(6) = {'sigmag'};
M_.param_names(7) = {'gammaI'};
M_.param_names_tex(7) = {'gammaI'};
M_.param_names_long(7) = {'gammaI'};
M_.param_partitions = struct();
M_.exo_det_nbr = 0;
M_.exo_nbr = 1;
M_.endo_nbr = 10;
M_.param_nbr = 7;
M_.orig_endo_nbr = 8;
M_.aux_vars(1).endo_index = 9;
M_.aux_vars(1).type = 0;
M_.aux_vars(1).orig_expr = 'beta^2/C(1)';
M_.aux_vars(2).endo_index = 10;
M_.aux_vars(2).type = 1;
M_.aux_vars(2).orig_index = 5;
M_.aux_vars(2).orig_lead_lag = -1;
M_.aux_vars(2).orig_expr = 'I(-1)';
M_ = setup_solvers(M_);
M_.Sigma_e = zeros(1, 1);
M_.Correlation_matrix = eye(1, 1);
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
M_.nonzero_hessian_eqs = [2 3 4 5 7 9];
M_.hessian_eq_zero = isempty(M_.nonzero_hessian_eqs);
M_.orig_eq_nbr = 8;
M_.eq_nbr = 10;
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
 0 4 0;
 0 5 0;
 0 6 0;
 0 7 0;
 1 8 0;
 2 9 0;
 0 10 14;
 0 11 0;
 0 12 15;
 3 13 0;]';
M_.nstatic = 5;
M_.nfwrd   = 2;
M_.npred   = 3;
M_.nboth   = 0;
M_.nsfwrd   = 2;
M_.nspred   = 3;
M_.ndynamic   = 5;
M_.dynamic_tmp_nbr = [8; 3; 2; 0; ];
M_.model_local_variables_dynamic_tt_idxs = {
};
M_.equations_tags = {
  1 , 'name' , '1' ;
  2 , 'name' , '2' ;
  3 , 'name' , 'dD' ;
  4 , 'name' , '4' ;
  5 , 'name' , 'dC' ;
  6 , 'name' , 'I' ;
  7 , 'name' , '7' ;
  8 , 'name' , 'G' ;
};
M_.mapping.rI.eqidx = [2 3 4 5 ];
M_.mapping.rB.eqidx = [4 5 7 ];
M_.mapping.dD.eqidx = [1 3 ];
M_.mapping.dC.eqidx = [1 5 ];
M_.mapping.I.eqidx = [2 3 4 5 6 ];
M_.mapping.B.eqidx = [5 6 7 ];
M_.mapping.C.eqidx = [1 2 4 ];
M_.mapping.G.eqidx = [7 8 ];
M_.mapping.eg.eqidx = [8 ];
M_.static_and_dynamic_models_differ = false;
M_.has_external_function = false;
M_.state_var = [5 6 10 ];
M_.exo_names_orig_ord = [1:1];
M_.maximum_lag = 1;
M_.maximum_lead = 1;
M_.maximum_endo_lag = 1;
M_.maximum_endo_lead = 1;
oo_.steady_state = zeros(10, 1);
M_.maximum_exo_lag = 0;
M_.maximum_exo_lead = 0;
oo_.exo_steady_state = zeros(1, 1);
M_.params = NaN(7, 1);
M_.endo_trends = struct('deflator', cell(10, 1), 'log_deflator', cell(10, 1), 'growth_factor', cell(10, 1), 'log_growth_factor', cell(10, 1));
M_.NNZDerivatives = [39; 33; -1; ];
M_.static_tmp_nbr = [8; 0; 0; 0; ];
M_.model_local_variables_static_tt_idxs = {
};
M_.params(1) = 0.5;
D = M_.params(1);
M_.params(2) = 0.25;
T = M_.params(2);
M_.params(3) = 0.9963;
beta = M_.params(3);
M_.params(4) = 0.2;
thetaD = M_.params(4);
M_.params(5) = 0.1;
thetaC = M_.params(5);
M_.params(6) = 0.05;
sigmag = M_.params(6);
M_.params(7) = 0.9;
gammaI = M_.params(7);
%
% SHOCKS instructions
%
M_.exo_det_length = 0;
M_.Sigma_e(1, 1) = (M_.params(6))^2;
%
% INITVAL instructions
%
options_.initval_file = false;
oo_.steady_state(1) = 0.08;
oo_.steady_state(2) = 0.03;
oo_.steady_state(3) = 0.03;
oo_.steady_state(4) = (-0.01);
oo_.steady_state(5) = 0.5;
oo_.steady_state(6) = 0.5;
oo_.steady_state(7) = 0.9;
oo_.steady_state(9)=M_.params(3)^2/oo_.steady_state(7);
oo_.steady_state(10)=oo_.steady_state(5);
if M_.exo_nbr > 0
	oo_.exo_simul = ones(M_.maximum_lag,1)*oo_.exo_steady_state';
end
if M_.exo_det_nbr > 0
	oo_.exo_det_simul = ones(M_.maximum_lag,1)*oo_.exo_det_steady_state';
end
options_.steady.maxit = 10000;
steady;
oo_.dr.eigval = check(M_,options_,oo_);
options_.order = 2;
var_list_ = {};
[info, oo_, options_, M_] = stoch_simul(M_, options_, oo_, var_list_);


oo_.time = toc(tic0);
disp(['Total computing time : ' dynsec2hms(oo_.time) ]);
if ~exist([M_.dname filesep 'Output'],'dir')
    mkdir(M_.dname,'Output');
end
save([M_.dname filesep 'Output' filesep 'test_results.mat'], 'oo_', 'M_', 'options_');
if exist('estim_params_', 'var') == 1
  save([M_.dname filesep 'Output' filesep 'test_results.mat'], 'estim_params_', '-append');
end
if exist('bayestopt_', 'var') == 1
  save([M_.dname filesep 'Output' filesep 'test_results.mat'], 'bayestopt_', '-append');
end
if exist('dataset_', 'var') == 1
  save([M_.dname filesep 'Output' filesep 'test_results.mat'], 'dataset_', '-append');
end
if exist('estimation_info', 'var') == 1
  save([M_.dname filesep 'Output' filesep 'test_results.mat'], 'estimation_info', '-append');
end
if exist('dataset_info', 'var') == 1
  save([M_.dname filesep 'Output' filesep 'test_results.mat'], 'dataset_info', '-append');
end
if exist('oo_recursive_', 'var') == 1
  save([M_.dname filesep 'Output' filesep 'test_results.mat'], 'oo_recursive_', '-append');
end
if ~isempty(lastwarn)
  disp('Note: warning(s) encountered in MATLAB/Octave code')
end
