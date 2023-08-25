function [EA] = calc_ea(time)

%time = 0:0.001:3;


    
    t = time;
    
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



EA = ea;




end