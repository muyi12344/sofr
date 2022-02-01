function ds = dynamic_set_auxiliary_series(ds, params)
%
% Status : Computes Auxiliary variables of the dynamic model and returns a dseries
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

ds.AUX_ENDO_LEAD_71=ds.C(1);
ds.AUX_ENDO_LEAD_130=ds.gammaL(1);
ds.AUX_ENDO_LAG_7_1=ds.I(-1);
end
