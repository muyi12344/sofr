function [ys_, params, info] = steadystate(ys_, exo_, params)
% Steady state generated by Dynare preprocessor
    info = 0;
    params(1)=0.2;
    ys_(1)=1/params(4)-1;
    ys_(9)=params(7)/(1-params(4)*params(6));
    ys_(8)=ys_(9);
    ys_(14)=(1-(1-params(4)*params(6))*(params(3)-params(1))/params(7)+params(4)*(params(4)*params(6)-1))/(params(6)*params(4)^2);
    ys_(2)=1/(params(4)*ys_(14))-1;
    ys_(4)=1/(params(4)*(1-params(4)*params(6)*(1-ys_(14))))-1;
    ys_(16)=ys_(8);
    ys_(5)=ys_(8)*(params(6)+ys_(14)*(1-params(6)-params(4)))+ys_(16)*(params(4)-1);
    ys_(10)=params(8);
    ys_(11)=((1-params(4)*(1-params(9)))/params(5))^(1/(params(5)-1))*params(2);
    ys_(15)=params(9)*ys_(11)/(params(4)*ys_(10));
    ys_(3)=1/(params(4)*ys_(15))-1;
    ys_(12)=(1-params(5))*(ys_(11)/params(2))^params(5);
    ys_(6)=ys_(9)+ys_(10)*ys_(15)+ys_(8)*ys_(14)*(params(4)-1)-params(4)*ys_(10)*ys_(15)-ys_(8)*params(6)*(1-ys_(14))-params(7)*(1-ys_(14))-ys_(9)/(1+ys_(4));
    ys_(7)=ys_(11)^params(5)*params(2)^(1-params(5))-params(2)*ys_(12)-ys_(10)*ys_(15)-params(8)*(1-ys_(15));
    ys_(13)=ys_(7)+ys_(6)+ys_(5)+params(2)*ys_(12)+ys_(16)*(1-params(4))-params(3);
    % Auxiliary equations
ys_(17)=ys_(13);
ys_(18)=ys_(15);
ys_(19)=ys_(8);
end
