function f = cardiac_lpn_system_Shi_et_al_Implicit_wVAD(t,y,yp)


% Obtain system constants
B = system_constants_Shi_et_al_wVAD(t,y);

% Specify system of equations

% Left Atrium
f(1,1) = yp(1) - y(24)+ y(3);   %Vla
f(2,1) = y(2) - B(1) - B(2)*(y(1) - B(3));  %Pla
if(y(2) > y(5))
    f(3,1) = y(3) - B(4)*sqrt(abs(y(2) - y(5)));    %Qmi
else
    f(3,1) = y(3) - 0;  %Qmi
end

f(4,1) = yp(4) - y(3) + y(6) + y(27);   %Vlv
f(5,1) = y(5) - B(5) - B(6)*(y(4) - B(7));  %Plv

if(y(5) > y(13))
    f(6,1) = y(6) - B(8)*sqrt(abs(y(5) - y(13)));   %Qao 
else
    f(6,1) = y(6) - 0;
end



f(7,1) = yp(7) - y(18) + y(9);  %Vra
f(8,1) = y(8) - B(9) - B(10)*(y(7) - B(11));    %Pra
if(y(8) > y(11))
    f(9,1) = y(9) - B(12)*sqrt(abs(y(8) - y(11)));  %Qti
else
    f(9,1) = y(9) - 0;  %Qti
end

f(10,1) = yp(10) - y(9) + y(12);    %Vrv
f(11,1) = y(11) - B(13) - B(14)*(y(10) - B(15));    %Prv
if(y(11) > y(19))
    f(12,1) = y(12) - B(16)*sqrt(abs(y(11) - y(19)));   %Qpo
else
    f(12,1) = y(12) - 0;
end

f(13,1) = yp(13) - (y(6) - y(14))/B(17);    %Psas
f(14,1) = yp(14) - (y(13) - y(15) - B(18)*y(14))/B(19);    %Qsas

f(15,1) = yp(15) - (y(14) + y(26) - y(16))/B(20);   %Psat
f(16,1) = yp(16) - (y(15) - y(17) - B(21)*y(16))/B(22); %Qsat   

f(17,1) = yp(17) - (y(16) - y(18))/B(23);   %Psvn
f(18,1) = y(18) - (y(17) - y(8))/B(24);     %Qsvn

f(19,1) = yp(19) - (y(12) - y(20))/B(25);   %Ppas   
f(20,1) = yp(20) - (y(19) - y(21) - B(26)*y(20))/B(27);     %Qpas

f(21,1) = yp(21) - (y(20) - y(22))/B(28);   %Ppat
f(22,1) = yp(22) - (y(21) - y(23) - B(29)*y(22))/B(30); %Qpat

f(23,1) = yp(23) - (y(22) - y(24))/B(31);   %Ppvn
f(24,1) = y(24) - (y(23) - y(2))/B(32);     %Qpvn

f(25,1) = yp(25) - (y(27) - y(26))/B(33);   %Pvad
f(26,1) = yp(26) - (y(25) - y(15) - B(34)*y(26))/B(35);     %Qvad
%%%%%%%%%%%%%%%%%%%% LVAD %%%%%%%%%%%%%%%%%%%

% %  %%%%%%%%%% LVAD - VARIABLE SPEED CONTROL %%%%%
% %  % Initiate variable speed cycle
%   init_varspeed = 8.00;
%   
% %  %%% HVAD
%  t_pre = 2.00;
%  t_post = 1.00;
%   if (t > init_varspeed - t_pre && t <= init_varspeed)
%      % Reduce speed from 2600 to 2400 RPM
%      dp_thresh = 80;
%      
%  elseif ( t > init_varspeed && t <= init_varspeed + t_post)
%      % Increase speed to 2800 RPM
%      dp_thresh = 110;
%  else
%      % Run at normal speed of 2600 RPM
%      dp_thresh = 95;
%  end

dp_thresh = 200;
 
 if((y(25) - y(5)) < dp_thresh && (y(25) - y(5)) > 0)
     
     % Quintic curve
     f(27,1) = y(27) - B(36)*((y(25) - y(5)))^5 - B(37)*((y(25) - y(5)))^4 - B(38)*((y(25) - y(5)))^3 ...
         - B(39)*((y(25) - y(5)))^2 - B(40)*((y(25) - y(5))) - B(41);
     
 else
     
     f(27,1) = y(27) - 0;
 end
 
%%%%%%%%%%%%%%%%%%%% LVAD %%%%%%%%%%%%%%%%%%%

end