function F=findI(I, beta, gammaI, thetaD, thetaC, lambdaD, lambdaC)
F=I-I*(beta+beta^2*(1-gammaI)*(thetaD*I^(lambdaD-1)-thetaC*I^(lambdaC-1)));
