%**************************************************************************
%
% Program to read and determine baroreflex response curve equation
% August2017
% CVKeshav
%
%**************************************************************************

clc
clear all
close all

rawdata = xlsread('Baroreceptor_response_raw.xlsx');

rawpress= rawdata(:,1);
rawres = rawdata(:,2);
first = rawpress(1);
last = rawpress(numel(rawpress));

% Obtain splinefit
f=fit(rawpress,rawres,'smoothingspline','SmoothingParam',0.9972821106603916);
p2 = first:0.01:last;
r2 = feval(f,p2);

figure
hold on
plot(rawpress,rawres,'bo')
plot(p2,r2,'r')
grid on
xlabel('Normalized carotid sinus pressure')
ylabel('Normalized systemic vascular resistance')

baroresponse(:,1) = p2;
baroresponse(:,2) = r2;

save('baroresponse.mat','baroresponse')

setpoint = 90;
pact = p2*setpoint;
pdev = pact - 90;

fs = 18*atan(pdev/18);

figure
plot(pact,fs)

cftool