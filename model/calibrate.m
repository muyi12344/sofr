%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calibrate parameters in the model. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fixed parameters: beta=0.997; phi=1; omega=0.009; lambdaD=2/3; lambdaC=1;
% delta=0.03; gammaI=0.99; Abar=1; Gbar=0.05;


% Calibated parameters
n_para_grid=2;
alpha_grid=linspace(0.3, 0.5, n_para_grid);
T_grid=linspace(0.05, 0.2, n_para_grid);
D_grid=linspace(0, 0.5, n_para_grid);
thetaD_grid=linspace(0.4, 0.7, n_para_grid);
thetaC_grid=linspace(0.4, 0.7, n_para_grid);
xiC_grid=linspace(0.001, 100, n_para_grid);


rI_generated=zeros(n_para_grid, n_para_grid, n_para_grid, n_para_grid, n_para_grid, n_para_grid);
rL_generated=zeros(n_para_grid, n_para_grid, n_para_grid, n_para_grid, n_para_grid, n_para_grid);
rB_generated=zeros(n_para_grid, n_para_grid, n_para_grid, n_para_grid, n_para_grid, n_para_grid);
dD_generated=zeros(n_para_grid, n_para_grid, n_para_grid, n_para_grid, n_para_grid, n_para_grid);
dC_generated=zeros(n_para_grid, n_para_grid, n_para_grid, n_para_grid, n_para_grid, n_para_grid);
dF_generated=zeros(n_para_grid, n_para_grid, n_para_grid, n_para_grid, n_para_grid, n_para_grid);
I_generated=zeros(n_para_grid, n_para_grid, n_para_grid, n_para_grid, n_para_grid, n_para_grid);
B_generated=zeros(n_para_grid, n_para_grid, n_para_grid, n_para_grid, n_para_grid, n_para_grid);
L_generated=zeros(n_para_grid, n_para_grid, n_para_grid, n_para_grid, n_para_grid, n_para_grid);
K_generated=zeros(n_para_grid, n_para_grid, n_para_grid, n_para_grid, n_para_grid, n_para_grid);
C_generated=zeros(n_para_grid, n_para_grid, n_para_grid, n_para_grid, n_para_grid, n_para_grid);

first_time=1;
for i1=1:n_para_grid;    
    for i2=1:n_para_grid;       
        for i3=1:n_para_grid;            
            for i4=1:n_para_grid;
                for i5=1:n_para_grid;
                    for i6=1:n_para_grid;
                        
                        if first_time;
                        dynare test2 nostrict noclearall;
                        first_time=0;
                        else
                        set_param_value('alpha', alpha_grid(i1));
                        set_param_value('T', T_grid(i2));
                        set_param_value('D', D_grid(i3));
                        set_param_value('thetaD', thetaD_grid(i4));
                        set_param_value('thetaC', thetaC_grid(i5));
                        set_param_value('xiC', xiC_grid(i6));
                        
                        try
                        steady;
                        check;
                        
                        rI_generated(i1,i2,i3,i4,i5,i6)=oo_.steady_state(1);
                        rL_generated(i1,i2,i3,i4,i5,i6)=oo_.steady_state(2);
                        rB_generated(i1,i2,i3,i4,i5,i6)=oo_.steady_state(3);
                        dD_generated(i1,i2,i3,i4,i5,i6)=oo_.steady_state(4);
                        dC_generated(i1,i2,i3,i4,i5,i6)=oo_.steady_state(5);
                        dF_generated(i1,i2,i3,i4,i5,i6)=oo_.steady_state(6);
                        I_generated(i1,i2,i3,i4,i5,i6)=oo_.steady_state(7);
                        B_generated(i1,i2,i3,i4,i5,i6)=oo_.steady_state(8);
                        L_generated(i1,i2,i3,i4,i5,i6)=oo_.steady_state(9);
                        K_generated(i1,i2,i3,i4,i5,i6)=oo_.steady_state(10);
                        C_generated(i1,i2,i3,i4,i5,i6)=oo_.steady_state(11);
                        
                        end
                        end
                    end
                end
            end
        end
    end
end

save ('rI.mat', rI_generated);
save ('rL.mat', rL_generated);
save ('rB.mat', rB_generated);
save ('dD.mat', dD_generated);
save ('dC.mat', dC_generated);
save ('dF.mat', dF_generated);
save ('I.mat', I_generated);
save ('B.mat', B_generated);
save ('L.mat', L_generated);
save ('K.mat', K_generated);
save ('C.mat', C_generated);

save ('alpha_grid.mat', alpha_grid);
save ('T_grid.mat', T_grid);
save ('D_grid.mat', D_grid);
save ('thetaD_grid.mat', thetaD_grid);
save ('thetaC_grid.mat', thetaC_grid);
save ('xiC_grid.mat', xiC_grid);








