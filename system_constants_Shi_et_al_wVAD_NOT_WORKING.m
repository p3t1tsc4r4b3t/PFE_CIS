function B = system_constants_Shi_et_al_wVAD(t,y)

% Determine cardiac cycle time
RR = 0.8;                       % Length of cardiac cycle = 0.8 s
tcar = mod(t,RR);

% Specify time thresholds for activation functions
Tac = 0.875*RR;
Tme = 0.3*sqrt(RR);
Tce = 1.5*Tme;

% Determmine activation function for atrium
if(tcar >= 0 && tcar <= Tac)
    ea = 0;
else
    ea = 1 - cos((tcar-Tac)*2*pi/(RR-Tac));
end

% Determine activation function for ventricle
if(tcar >=0 && tcar < Tme)
    ev = 1 - cos(tcar*pi/Tme);
elseif(tcar >= Tme && tcar < Tce)
    ev = 1 + cos((tcar-Tme)*pi/(Tce-Tme));
else
    ev = 0;
end

% Specify Elastances
Ela_max = 0.25;
Ela_min = 0.15;

% Elv_max = 2.5;
% Elv_max = 0.5; %%%%% HEART FAILURE !!!!
% Elv_min = 0.07;

%%%%% NEW PARAMETERS FOR LOWER INITIAL BP
Elv_max = 0.4; %2.5;
%Elv_max = 0.5; %%%%% HEART FAILURE !!!!
Elv_min = 0.085; %0.07;

Era_max = 0.25;
Era_min = 0.15;

Erv_max = 1.15;
Erv_min = 0.07;

% % Arterial Resistances
% scale_factor = 0.68;
% Rsat = 0.05*scale_factor;
% Rsar = 0.5*scale_factor;
% Rscp = 0.52*scale_factor;

%%%%% Incorporating Baroreceptor response
% testing sum of sine fit
clear map norm_press
map = y(15);
setpoint = 70;
norm_press = map/setpoint;

% 2 sine terms fit
%res_factor = 1.434*sin(0.3968*norm_press + 1.93) + 0.2048*sin(3.33*norm_press - 0.1073);

% 3 sine terms fit
res_factor = 3.336*sin(0.1352*norm_press + 2.694) + 0.1806*sin(3.424*norm_press - 0.3021) + 0.04048*sin(6.943*norm_press + 2.633);

% fid = fopen('baroresponse_trial.txt','a');
% fprintf(fid,'%6.2f \t %6.2f \t %6.2f\n',t,map,res_factor);
% fclose(fid);

%%%%% NEW PARAMETERS FOR LOWER INITIAL BP
% Arterial Resistances
scale_factor = 1.0*res_factor;
modf = 0.; %%% FOR REDUCING INITIAL BP
Rsat = 0.05*modf*scale_factor;
Rsar = 0.5*modf*scale_factor;
Rscp = 0.52*modf*scale_factor;

% Modeling pulmonary hypertension
pscale = 1.0;
Rpat = 0.01*pscale;
Rpar = 0.05*pscale;
Rpcp = 0.07*pscale;



% Specify all system constants
B = zeros(38,1);

B(1) = 1;
B(2) = Ela_min + 0.5*(Ela_max - Ela_min)*ea;
B(3) = 4;
B(4) = 350; %400; %%%%% NEW PARAMETERS FOR LOWER INITIAL BP
B(5) = 1;
B(6) = Elv_min + 0.5*(Elv_max -Elv_min)*ev;
B(7) = 5;
B(8) = 300; %350; %%%%% NEW PARAMETERS FOR LOWER INITIAL BP
B(9) = 1;
B(10) = Era_min + 0.5*(Era_max - Era_min)*ea;
B(11) = 4;
B(12) = 400;
B(13) = 1;
B(14) = Erv_min + 0.5*(Erv_max - Erv_min)*ev;
B(15) = 10;
B(16) = 350;
B(17) = 0.08;
B(18) = 0.003;
B(19) = 0.000062;
B(20) = 1.4; %1.6; %%%%% NEW PARAMETERS FOR LOWER INITIAL BP
%B(20) = 0.8; % LOWERING Csat to raise MAP - DOES NOT WORK, ONLY INCREASES RANGE, NOT MEAN
%B(21) = 1.07;
B(21) = Rsat + Rsar + Rscp;
B(22) = 0.0017;
B(23) = 20.5;
B(24) = 0.075;
B(25) = 0.18;
B(26) = 0.002;
B(27) = 0.000052;
B(28) = 3.8;
B(29) = Rpat+Rpar+Rpcp; %0.13;
B(30) = 0.0017;
B(31) = 20.5;
B(32) = 0.006;

B(33) = 0.08; % Capacitance for outflow graft
B(34) = 0.06; % Resistance for outflow graft
B(35) = 0.000062; % Inductance for outflow graft

% % Constants for LVAD H-Q curve
% % ----- TYPE OF LVAD -----
% % 1: HVAD
% % 2: HM3
% % ------------------------
% % ----- RPM for HVAD -----
% % 1: 2200 (HVAD)
% % 2: 2400 (HVAD)
% % 3: 2600 (HVAD)
% % 4: 2800 (HVAD)
% % 5: 3000 (HVAD)
% % ------------------------
% % ----- RPM for HM3 -----
% % 1: 3000 (HM3)
% % 2: 3400 (HM3)
% % 3: 4000 (HM3)
% % 4: 5000 (HM3)
% % 5: 5400 (HM3)
% % 6: 6000 (HM3)
% % 7: 7400 (HM3)


lvad = 1;
rpm = 3;

switch lvad
    case 1
        % HVAD
        switch rpm
            case 1
                %%% 2200 rpm
%                 %%% Quintic h-q curve HVAD 2200 RPM
%                 B(36) = -1e-7*16.67;
%                 B(37) = 2e-5*16.67;
%                 B(38) = -0.0011*16.67;
%                 B(39) = 0.0307*16.67;
%                 B(40) = -0.4411*16.67;
%                 B(41) = 9.5602*16.67;
                
                %%% Cubic h-q curve HVAD 2200 RPM
                B(36) = 0.0*16.67;
                B(37) = 0.0*16.67;
                B(38) = -5e-5*16.67;
                B(39) = 0.0039*16.67;
                B(40) = -0.1663*16.67;
                B(41) = 8.71*16.67;                
            case 2
                %%% 2400 rpm
%                 %%% Quintic h-q curve HVAD 2400 RPM
%                 B(36) = -5e-8*16.67;
%                 B(37) = 9e-6*16.67;
%                 B(38) = -0.0007*16.67;
%                 B(39) = 0.0237*16.67;
%                 B(40) = -0.4044*16.67;
%                 B(41) = 10.429*16.67;
                
                %%% Cubic h-q curve HVAD 2400 RPM
                B(36) = 0.0*16.67;
                B(37) = 0.0*16.67;
                B(38) = -3e-5*16.67;
                B(39) = 0.003*16.67;
                B(40) = -0.1525*16.67;
                B(41) = 9.497*16.67;                
            case 3
                %%% 2600 rpm
%                 %%% Quintic h-q curve HVAD 2600 RPM
%                 B(36) = -2e-8*16.67;
%                 B(37) = 5e-6*16.67;
%                 B(38) = -0.0005*16.67;
%                 B(39) = 0.0186*16.67;
%                 B(40) = -0.3733*16.67;
%                 B(41) = 11.29*16.67;
                
                %%% Cubic h-q curve HVAD 2600 RPM
                B(36) = 0.0*16.67;
                B(37) = 0.0*16.67;
                B(38) = -2e-5*16.67;
                B(39) = 0.0024*16.67;
                B(40) = -0.1408*16.67;
                B(41) = 10.289*16.67;                
                
            case 4
%                 %%% 2800 rpm
%                 %%% Quintic h-q curve HVAD 2800 RPM - DOES NOT WORK !?
%                 B(36) = -1e-8*16.67;
%                 B(37) = 3e-6*16.67;
%                 B(38) = -0.0003*16.67;
%                 B(39) = 0.0149*16.67;
%                 B(40) = -0.3466*16.67;
%                 B(41) = 12.16*16.67;
                
%                 %%% Cubic h-q curve HVAD 2800 RPM - DOES NOT WORK !?
%                 B(36) = 0.0*16.67;
%                 B(37) = 0.0*16.67;
%                 B(38) = -0.0008*16.67;
%                 B(39) = 0.0019*16.67;
%                 B(40) = -0.1307*16.67;
%                 B(41) = 11.08*16.67;
%                 
                
                % Quadratic h-q curve HVAD 2800 RPM
                B(36) = 0.0;
                B(37) = 0.0;
                B(38) = 0.0;
                B(39) = -0.0008*16.67;
                B(40) = 0.006*16.67;
                B(41) = 9.44*16.67;
                
                
            case 5
                %%% 3000 rpm
%                 %%% Quintic h-q curve HVAD 3000 RPM - DOES NOT WORK !?
%                 B(36) = -6e-9*16.67;
%                 B(37) = 2e-6*16.67;
%                 B(38) = -0.0002*16.67;
%                 B(39) = 0.0121*16.67;
%                 B(40) = -0.3235*16.67;
%                 B(41) = 13.03*16.67;
                
%                 % Quadratic h-q curve HVAD 3000 RPM
%                 B(36) = 0.0;
%                 B(37) = 0.0;
%                 B(38) = 0.0;
%                 B(39) = -0.0006*16.67;
%                 B(40) = 0.0056*16.67;
%                 B(41) = 10.12*16.67; 
                
                % Cubic h-q curve HVAD 3000 RPM
                B(36) = 0.0;
                B(37) = 0.0;
                B(38) = -1e-5*16.67;
                B(39) = 0.0015*16.67;
                B(40) = -0.122*16.67;
                B(41) = 11.87*16.67; 
                
            case 6
                
                % Variable speed
                % Reduce by 200 rpm for 2 sec, increase by 400 rpm for
                % 1 sec, repeat after 60 sec
                % Starting variability after 10 sec
                
                % Initiate variable speed cycle
                init_varspeed = 10.65;
                t_pre = 2.00;
                t_post = 1.00;
                
                if (t > init_varspeed - t_pre && t <= init_varspeed)
                    % Reduce speed from 2600 to 2400 RPM
                    %%% Cubic h-q curve HVAD 2400 RPM
                    B(36) = 0.0*16.67;
                    B(37) = 0.0*16.67;
                    B(38) = -3e-5*16.67;
                    B(39) = 0.003*16.67;
                    B(40) = -0.1525*16.67;
                    B(41) = 9.497*16.67;
                    
                elseif ( t > init_varspeed && t <= init_varspeed + t_post)
                    % Increase speed to 2800 RPM
                    % Quadratic h-q curve HVAD 2800 RPM
                    B(36) = 0.0;
                    B(37) = 0.0;
                    B(38) = 0.0;
                    B(39) = -0.0008*16.67;
                    B(40) = 0.006*16.67;
                    B(41) = 9.44*16.67;
                else
                    % Run at normal speed of 2600 RPM
                    %%% Cubic h-q curve HVAD 2600 RPM
                    B(36) = 0.0*16.67;
                    B(37) = 0.0*16.67;
                    B(38) = -2e-5*16.67;
                    B(39) = 0.0024*16.67;
                    B(40) = -0.1408*16.67;
                    B(41) = 10.289*16.67;
                end
                
            case 7
                %%% 2300 rpm
%                 %%% Quintic h-q curve HVAD 3000 RPM - DOES NOT WORK !?
%                 B(36) = -6e-9*16.67;
%                 B(37) = 2e-6*16.67;
%                 B(38) = -0.0002*16.67;
%                 B(39) = 0.0121*16.67;
%                 B(40) = -0.3235*16.67;
%                 B(41) = 13.03*16.67;
                
                % Cubic h-q curve HVAD 2300 RPM
                B(36) = 0.0;
                B(37) = 0.0;
                B(38) = -4e-5*16.67;
                B(39) = 0.0034*16.67;
                B(40) = -0.1591*16.67;
                B(41) = 9.101*16.67; 
               
            case 8
                %%% 2360 rpm
%                 %%% Quintic h-q curve HVAD 3000 RPM - DOES NOT WORK !?
%                 B(36) = -6e-9*16.67;
%                 B(37) = 2e-6*16.67;
%                 B(38) = -0.0002*16.67;
%                 B(39) = 0.0121*16.67;
%                 B(40) = -0.3235*16.67;
%                 B(41) = 13.03*16.67;
                
                % Cubic h-q curve HVAD 2300 RPM
                B(36) = 0.0;
                B(37) = 0.0;
                B(38) = -3e-5*16.67;
                B(39) = 0.0032*16.67;
                B(40) = -0.1551*16.67;
                B(41) = 9.339*16.67; 
                
        end
    case 2
        % HM3
        switch rpm
            case 1
                % Cubic h-q curve HM3 3000 RPM
                B(36) = 0.0;
                B(37) = 0.0;
                B(38) = -0.0001*16.67;
                B(39) = 0.0036*16.67;
                B(40) = -0.0851*16.67;
                B(41) = 3.837*16.67;   
             case 2
                % Cubic h-q curve HM3 3400 RPM
                B(36) = 0.0;
                B(37) = 0.0;
                B(38) = -6e-5*16.67;
                B(39) = 0.0025*16.67;
                B(40) = -0.0751*16.67;
                B(41) = 4.34*16.67;  
             case 3
                % Cubic h-q curve HM3 4000 RPM
                B(36) = 0.0;
                B(37) = 0.0;
                B(38) = -3e-5*16.67;
                B(39) = 0.0015*16.67;
                B(40) = -0.0638*16.67;
                B(41) = 5.116*16.67; 
             case 4
                % Cubic h-q curve HM3 5000 RPM
                B(36) = 0.0;
                B(37) = 0.0;
                B(38) = -8e-6*16.67;
                B(39) = 0.0008*16.67;
                B(40) = -0.0511*16.67;
                B(41) = 6.395*16.67;   
             case 5
                % Cubic h-q curve HM3 5400 RPM
                B(36) = 0.0;
                B(37) = 0.0;
                B(38) = -6e-6*16.67;
                B(39) = 0.0006*16.67;
                B(40) = -0.0473*16.67;
                B(41) = 6.91*16.67; 
             case 6
                % Cubic h-q curve HM3 6000 RPM
                B(36) = 0.0;
                B(37) = 0.0;
                B(38) = -4e-6*16.67;
                B(39) = 0.0007*16.67;
                B(40) = -0.0569*16.67;
                B(41) = 8.06*16.67;                 
             case 7
                % Cubic h-q curve HM3 7400 RPM
                B(36) = 0.0;
                B(37) = 0.0;
                B(38) = -1e-6*16.67;
                B(39) = 0.0002*16.67;
                B(40) = -0.0345*16.67;
                B(41) = 9.465*16.67;
            case 8
                % Variable speed
                % Reduce by 2000 rpm for 0.15 sec, increase by 4000 rpm for
                % 0.2 sec, repeat after 2 sec
                % Starting variability after 10 sec
                
                % Initiate variable speed cycle
                init_varspeed = 10.65;
                t_pre = 0.15;
                t_post = 0.20;
                
                if (t > init_varspeed - t_pre && t <= init_varspeed)
                    % Reduce speed from 5400 to 3400 RPM
                    % Cubic h-q curve HM3 3400 RPM
                    B(36) = 0.0;
                    B(37) = 0.0;
                    B(38) = -6e-5*16.67;
                    B(39) = 0.0025*16.67;
                    B(40) = -0.0751*16.67;
                    B(41) = 4.34*16.67;
                    
                elseif ( t > init_varspeed && t <= init_varspeed + t_post)
                    % Increase speed to 7400 RPM
                    % Cubic h-q curve HM3 7400 RPM
                    B(36) = 0.0;
                    B(37) = 0.0;
                    B(38) = -1e-6*16.67;
                    B(39) = 0.0002*16.67;
                    B(40) = -0.0345*16.67;
                    B(41) = 9.465*16.67;
                else
                    % Run at normal speed of 5400 RPM
                    % Cubic h-q curve HM3 5400 RPM
                    B(36) = 0.0;
                    B(37) = 0.0;
                    B(38) = -6e-6*16.67;
                    B(39) = 0.0006*16.67;
                    B(40) = -0.0473*16.67;
                    B(41) = 6.91*16.67;
                end
                    
                    
        end
                
end

% Quadratic h-q curve HVAD 2600 RPM
% B(36) = -0.001*16.67;
% B(37) = 0.0064*16.67;
% B(38) = 8.78*16.67;

% % % %Cubic h-q curve HVAD 2600 RPM
% B(36) = -2e-5*16.67;
% B(37) = 0.0024*16.67;
% B(38) = -0.1408*16.67;
% B(39) = 10.289*16.67;

% % % %Cubic h-q curve HVAD 3000 RPM
% B(36) = -1e-5*16.67;
% B(37) = 0.0015*16.67;
% B(38) = -0.122*16.67;
% B(39) = 11.89*16.67;

% % Quintic h-q curve HVAD 3000 RPM
% B(36) = -6e-9*16.67; 
% B(37) = 2e-6*16.67;
% B(38) = -0.0002*16.67;
% B(39) = 0.0121*16.67;
% B(40) = -0.3235*16.67;
% B(41) = 13.03*16.67;

% % Quadratic h-q curve HVAD 3000 RPM
% B(36) = 0.0; 
% B(37) = 0.0;
% B(38) = 0.0;
% B(39) = -0.0006*16.67;
% B(40) = 0.0056*16.67;
% B(41) = 10.12*16.67;

end
