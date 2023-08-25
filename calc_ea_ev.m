function [EA,EV] = calc_ea_ev(time)

%time = 0:0.001:3;

for i=1:numel(time)
    
    t = time(i);
    
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

EA(i) = ea;
EV(i) = ev;

end


% ela = 0.15+0.05*EA;
% elv = 0.07+1.25*EV;
% 
% figure
% plot(time,ela)
% hold on
% plot(time,elv)
% grid on



end