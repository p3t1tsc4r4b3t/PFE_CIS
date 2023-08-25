function [f,k,m] = shi_dae_wVAD(t,y,yp)
% This function assembles the system of DAE equations, along with the
% jacobians k=df/dy and m = df/dy'

% Get system of DAEs
f = cardiac_lpn_system_Shi_et_al_Implicit_wVAD(t,y,yp);

% Obtain jacobian k = df/dy
k = calcJac_wVAD(t,y);

% obtain jacobian m = df/dy'
% This jacobian is based on y' variables
J = zeros(27,27);
J(1,1) = 1;
J(4,4) = 1;
J(7,7) = 1;
J(10,10) = 1;
J(13,13) = 1;
J(14,14) = 1;
J(15,15) = 1;
J(16,16) = 1;
J(17,17) = 1;
J(19,19) = 1;
J(20,20) = 1;
J(21,21) = 1;
J(22,22) = 1;
J(23,23) = 1;
J(25,25) = 1;
J(26,26) = 1;

m=J;


end