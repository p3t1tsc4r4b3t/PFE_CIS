function [EV] = calc_ev(time)

t = time;
    
    RR = 0.8;                       % Length of cardiac cycle = 0.8 s
tcar = mod(t,RR);

% Specify time thresholds for activation functions
Tac = 0.875*RR;
Tme = 0.3*sqrt(RR);
Tce = 1.5*Tme;

% Determine activation function for ventricle
if(tcar >=0 && tcar < Tme)
    ev = 1 - cos(tcar*pi/Tme);
elseif(tcar >= Tme && tcar < Tce)
    ev = 1 + cos((tcar-Tme)*pi/(Tce-Tme));
else
    ev = 0;
end

EV = ev;

end