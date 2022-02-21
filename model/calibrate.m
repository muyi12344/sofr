%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calibrate parameters in the model. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fixed parameters: beta=0.998 alpha=0.4 thetaD=0.6 lambdaD=1/2 lambdaC=2 xiC=0.2 
% delta=0.03 gammaI=0.99 gammaL=0.95 Abar=1 Bbar=1 rhoB=0.9 rhoA=0.9 sigmaB=0.01 sigmaA=0.01;


% Calibated parameters
n_para_grid=10;
phi_grid=linspace(0.5, 3, n_para_grid);
thetaC_grid=linspace(1, 10, n_para_grid);
etaB_grid=linspace(0.5, 1.5, n_para_grid);
etaL_grid=linspace(0.1, 0.8, n_para_grid);



rI_generated=NaN(n_para_grid, n_para_grid, n_para_grid, n_para_grid);
rL_generated=NaN(n_para_grid, n_para_grid, n_para_grid, n_para_grid);
rB_generated=NaN(n_para_grid, n_para_grid, n_para_grid, n_para_grid);
I_generated=NaN(n_para_grid, n_para_grid, n_para_grid, n_para_grid);
B_generated=NaN(n_para_grid, n_para_grid, n_para_grid, n_para_grid);
L_generated=NaN(n_para_grid, n_para_grid, n_para_grid, n_para_grid);
K_generated=NaN(n_para_grid, n_para_grid, n_para_grid, n_para_grid);
C_generated=NaN(n_para_grid, n_para_grid, n_para_grid, n_para_grid);


BKcheck=NaN(n_para_grid, n_para_grid, n_para_grid, n_para_grid);

first_time=1;
for i1=1:n_para_grid;    
    for i2=1:n_para_grid;       
        for i3=1:n_para_grid;      
            for i4=1:n_para_grid;         
                        if first_time;
                        dynare test2 nostrict noclearall;
                        first_time=0;
                        else
                        set_param_value('phi', phi_grid(i1));
                        set_param_value('thetaC', thetaC_grid(i2));
                        set_param_value('etaB', etaB_grid(i3));
                        set_param_value('etaL', etaL_grid(i4));
                        
                        try
                         steady;
                        rI_generated(i1,i2,i3,i4)=oo_.steady_state(1);
                        rL_generated(i1,i2,i3,i4)=oo_.steady_state(2);
                        rB_generated(i1,i2,i3,i4)=oo_.steady_state(3);
                        I_generated(i1,i2,i3,i4)=oo_.steady_state(7);
                        B_generated(i1,i2,i3,i4)=oo_.steady_state(8);
                        L_generated(i1,i2,i3,i4)=oo_.steady_state(9);
                        K_generated(i1,i2,i3,i4)=oo_.steady_state(10);
                        C_generated(i1,i2,i3,i4)=oo_.steady_state(11);
                        
                         [eigenvalues,result,~]=check(M_, options_, oo_);

                        BKcheck(i1,i2,i3,i4)=result;
                        catch
                        disp('Failed to compute steady state')        
                        end  
                        end 
            end
        end
    end
end
    




save ('/N/slate/qwu2/sofr/model/cali_result/rI.mat', 'rI_generated');
save ('/N/slate/qwu2/sofr/model/cali_result/rL.mat', 'rL_generated');
save ('/N/slate/qwu2/sofr/model/cali_result/rB.mat', 'rB_generated');
save ('/N/slate/qwu2/sofr/model/cali_result/I.mat', 'I_generated');
save ('/N/slate/qwu2/sofr/model/cali_result/B.mat', 'B_generated');
save ('/N/slate/qwu2/sofr/model/cali_result/L.mat', 'L_generated');
save ('/N/slate/qwu2/sofr/model/cali_result/K.mat', 'K_generated');
save ('/N/slate/qwu2/sofr/model/cali_result/C.mat', 'C_generated');

save ('/N/slate/qwu2/sofr/model/cali_result/phi_grid.mat', 'phi_grid');
save ('/N/slate/qwu2/sofr/model/cali_result/thetaC_grid.mat', 'thetaC_grid');
save ('/N/slate/qwu2/sofr/model/cali_result/etaB_grid.mat', 'etaB_grid');
save ('/N/slate/qwu2/sofr/model/cali_result/etaL_grid.mat', 'etaL_grid');

save ('/N/slate/qwu2/sofr/model/cali_result/BKcheck.mat', 'BKcheck');






