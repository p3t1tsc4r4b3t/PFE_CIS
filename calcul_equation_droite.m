% Enter the coordinates of the two points

%heart1
% x1 =6.711.*10.^(-3);
% y1 =100.868.*10.^(-3);
% z1 =14.089.*10.^(-3);
% 
% x2 =5.246.*10.^(-3);
% y2 =-2.972.*10.^(-3);
% z2 =-3.943.*10.^(-3);

% %heart2
% x1 =2.408*10.^(-3);
% y1 =102.988.*10.^(-3);
% z1 =14.378*10.^(-3);
% 
% x2 =4.153*10.^(-3);
% y2 =-20.060.*10.^(-3);
% z2 =-7.001.*10.^(-3);

%heart 3

% x1 =2.424*10.^(-3);
% y1 =102.981.*10.^(-3);
% z1 =14.376*10.^(-3);
% 
% x2 =4.152*10.^(-3);
% y2 =-20.060.*10.^(-3);
% z2 =-7.001.*10.^(-3);

%hvad
% 
% x1 =-5.228*10.^(-3);
% y1 =-35.307*10.^(-3);
% z1 =34.219.*10.^(-3);
% 
% x2 =-5.265.*10.^(-3);
% y2 =-61.550.*10.^(-3);
% z2 =34.219.*10.^(-3);

% Heartmate3

x1 =60.820.*10.^(-3);
y1 =51.128.*10.^(-3);
z1 =63.261*10.^(-3);

x2 =60.820.*10.^(-3);
y2 =41.829.*10.^(-3);
z2 =63.261*10.^(-3);

point1 = [x1, y1, z1];
point2 = [x2, y2, z2];

% Calculate the direction vector of the line
dir_vector = point2 - point1;

% Calculate the parameter t that gives points on the line
syms t
x_t = point1(1) + dir_vector(1)*t;
y_t = point1(2) + dir_vector(2)*t;
z_t = point1(3) + dir_vector(3)*t;

% Output the parametric equation of the line
disp(['x = ', char(x_t)])
disp(['y = ', char(y_t)])
disp(['z = ', char(z_t)])
