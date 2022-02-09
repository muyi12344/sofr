% Solve for  dC, dF, L, gammaL, K in steady state

function var=ss_help(var0,  D, T, beta, alpha, phi, omega, thetaD, thetaC, lambdaD, lambdaC, xiC, delta, gammaI, Abar, Gbar)
fun=@(var)ss_help_fun(var, D, T, beta, alpha, phi, omega, thetaD, thetaC, lambdaD, lambdaC, xiC, delta, gammaI, Abar, Gbar)

var=fsolve(fun,var0);