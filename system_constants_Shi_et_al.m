function B = system_constants_Shi_et_al(t)

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

Elv_max = 2.5;
Elv_max = 0.5; %%%%% HEART FAILURE !!!!
Elv_min = 0.07;

Era_max = 0.25;
Era_min = 0.15;

Erv_max = 1.15;
Erv_min = 0.07;


% Specify all system constants
B = zeros(32,1);

B(1) = 1;
B(2) = 0.15 + 0.05*ea;
B(3) = 4;
B(4) = 400;
B(5) = 1;
B(6) = 0.07 + 1.25*ev;
B(7) = 5;
B(8) = 350;
B(9) = 1;
B(10) = 0.15 + 0.05*ea;
B(11) = 4;
B(12) = 400;
B(13) = 1;
B(14) = 0.07 + 0.54*ev;
B(15) = 10;
B(16) = 350;
B(17) = 0.08;
B(18) = 0.003;
B(19) = 0.000062;
B(20) = 1.6;
B(21) = 1.07;
B(22) = 0.0017;
B(23) = 20.5;
B(24) = 0.075;
B(25) = 0.18;
B(26) = 0.002;
B(27) = 0.000052;
B(28) = 3.8;
B(29) = 0.13;
B(30) = 0.0017;
B(31) = 20.5;
B(32) = 0.006;

end
