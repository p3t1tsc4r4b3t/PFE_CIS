function B = system_constants(t)

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
Elv_min = 0.07;

Era_max = 0.25;
Era_min = 0.15;

Erv_max = 1.15;
Erv_min = 0.07;


% Specify all system constants
B = zeros(50,1);

B(1) = 1;
B(2) = Ela_min + 0.5*(Ela_max - Ela_min)*ea;
B(3) = 4;
B(4) = 400;
B(5) = 1;
B(6) = Elv_min + 0.5*(Elv_max - Elv_min)*ev;
B(7) = 5;
B(8) = 350;
B(9) = 1;
B(10) = Era_min + 0.5*(Era_max - Era_min)*ea;
B(11) = 4;
B(12) = 400;
B(13) = 1;
B(14) = Erv_min + 0.5*(Erv_max - Erv_min)*ev;
B(15) = 10;
B(16) = 350;
B(17) = 25;
B(18) = 0.08;
B(19) = 1;
B(20) = 0.08;
B(21) = 0.003;
B(22) = 0.000062;
B(23) = 775;
B(24) = 1.6;
B(25) = 1;
B(26) = 1.6;
B(27) = 1.07;
B(28) = 0.0017;
B(29) = 3000;
B(30) = 20.5;
B(31) = 1;
B(32) = 20.5;
B(33) = 0.075;
B(34) = 25;
B(35) = 0.18;
B(36) = 1;
B(37) = 0.18;
B(38) = 0.002;
B(39) = 0.000052;
B(40) = 175;
B(41) = 3.8;
B(42) = 1;
B(43) = 3.8;
B(44) = 0.13;
B(45) = 0.0017;
B(46) = 300;
B(47) = 20.5;
B(48) = 1;
B(49) = 20.5;
B(50) = 0.006;


end