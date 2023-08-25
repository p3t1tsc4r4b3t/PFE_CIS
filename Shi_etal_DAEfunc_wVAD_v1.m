% *************************************************************************
% Testing 2006 shi et al model (no valve angle, no reverse flow)
% Included HVAD at 2600RPM
% using DAE function written by Tony Roberts (found online)
% CVKeshav
% May 2017
%**************************************************************************

clc
clear all
close all

% Read initial conditions for original set of equations
fileID = fopen('Cardiac_Initial_Conditions_Shi_et_al_wVAD.txt');
init_c = textscan(fileID,'%f');
fclose(fileID);

ic_guess = init_c{1,1};

y0est = ic_guess;

% Use fsolve to obtain better guess for ICs
%X = fsolve(@symbolic_DAE_v3_ALG_only,ic_guess);
X = fsolve(@cardiac_lpn_system_Shi_et_al_ALG_ONLY_wVAD,ic_guess);


yp0 = zeros(length(ic_guess),1);

[y0new,yp0new] = decic(@cardiac_lpn_system_Shi_et_al_Implicit_wVAD,0,X,ic_guess,yp0,yp0);


% determine tspan
t_final = 10;
num_iter = 1000;
half_iter = num_iter/2;

tspan = linspace(0,t_final,num_iter);
init = 10;

tic

% call DAE solver
y = dae4o('shi_dae_wVAD',tspan,y0new,init);

toc

% plot solution
plot_params(tspan,y);

MAP = mean(y(15,half_iter:num_iter))

% integrate flow through vad to find LVAD output
st = 1;
fin = num_iter;

Mean_Qvad = trapz(tspan(st:fin),y(26,st:fin))*(60/t_final)*1e-3

Mean_Qav = trapz(tspan(st:fin),y(6,st:fin))*(60/t_final)*1e-3

Psys = max(y(15,half_iter:num_iter))

Pdias = min(y(15,half_iter:num_iter))

PASP = max(y(21,half_iter:num_iter))

Mean_PAP = mean(y(21,half_iter:num_iter))

% Write simulation data to file
clear data
data.tspan = tspan;
data.y = y;

filename = 'LPM_AV_Parallel_HVAD_2600rpm_Elv_1p8_Res_0p58.mat';

save(filename,'data');
% 
% 
% 
% figure
% plot(tspan,y(13,:),'b')
% hold on
% plot(tspan,y(5,:),'r')
% plot(tspan,(y(13,:) - y(5,:)),'k')
% plot(tspan,y(15,:),'g')
% % 
% 
% 
% B = system_constants_Shi_et_al_wVAD(10);
% 
% for i=1:10000
%     clear dp;
% dp = y(15,i) - y(5,i);
% 
% qvad(i) = B(36)*dp^5 + B(37)*dp^4 + B(38)*dp^3 + B(39)*dp^2 + B(40)*dp + B(41);
% end
% 
% figure
% plot(tspan,qvad)
% 
% mean(qvad*0.06)


% tspan = data.tspan;
% y = data.y;
% 
% % Plot pressures
% figure
% hold on
% plot(tspan,y(13,:),'b')
% plot(tspan,y(15,:),'r')
% plot(tspan,y(17,:),'g')
% plot(tspan,y(19,:),'m')
% plot(tspan,y(21,:),'k')
% plot(tspan,y(23,:),'y')
% 
% % Plot flows
% figure
% hold on
% hold on
% plot(tspan,y(14,:),'b')
% plot(tspan,y(16,:),'r')
% plot(tspan,y(18,:),'g')
% plot(tspan,y(20,:),'m')
% plot(tspan,y(22,:),'k')
% plot(tspan,y(24,:),'y')

