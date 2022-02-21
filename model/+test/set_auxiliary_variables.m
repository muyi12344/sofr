function y = set_auxiliary_variables(y, x, params)
%
% Status : Computes static model for Dynare
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

y(13)=(1+y(2))*(1-params(11))*params(2)^2/y(11);
end
