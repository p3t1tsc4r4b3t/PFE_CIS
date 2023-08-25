function jac = calcJac_wVAD(t,y)
% This function calculates the non-constant Jacobian at every timestep

% Obtain system constants
B = system_constants_Shi_et_al_wVAD(t,y);

jac = zeros(27,27);

jac(1,24) = -1;
jac(1,3) = 1;

jac(2,1) = -B(2);
jac(2,2) = 1;

if(y(2) > y(5))
jac(3,2) = -B(4)/(2*sqrt(y(2) - y(5)));
jac(3,5) = B(4)/(2*sqrt(y(2) - y(5)));
jac(3,3) = 1;
else
    jac(3,3) = 1;
end

jac(4,3) = -1;
jac(4,6) = 1;
jac(4,27) = 1;

jac(5,4) = -B(6);
jac(5,5) = 1;

%%%%% ONLY IF INCLUDING AORTIC VALVE
if(y(5) > y(13))
    jac(6,5) = -B(8)/(2*sqrt(y(5) - y(13)));
    jac(6,13) = B(8)/(2*sqrt(y(5) - y(13)));
    %jac(6,25) = 1;
    jac(6,6) = 1;
else
    jac(6,6) = 1;
end


jac(7,9) = 1;
jac(7,18) = -1;

jac(8,7) = -B(10);
jac(8,8) = 1;

if(y(8) > y(11))
    jac(9,8) = -B(12)/(2*sqrt(y(8) - y(11)));
    jac(9,11) = B(12)/(2*sqrt(y(8) - y(11)));
    jac(9,9) = 1;
else
    jac(9,9) = 1;
end

jac(10,9) = -1;
jac(10,12) = 1;

jac(11,10) = -B(14);
jac(11,11) = 1;

if(y(11) > y(19))
    jac(12,11) = -B(16)/(2*sqrt(y(11) - y(19)));
    jac(12,19) = B(16)/(2*sqrt(y(11) - y(19)));
    jac(12,12) = 1;
else
    jac(12,12) = 1;
end

jac(13,6) = -1/B(17);
jac(13,14) = 1/B(17);

jac(14,13) = -1/B(19);
jac(14,15) = 1/B(19);
jac(14,14) = B(18)/B(19);


 jac(15,14) = -1/B(20);
 jac(15,16) = 1/B(20);
 jac(15,26) = -1/B(20);


jac(16,15) = -1/B(22);
jac(16,16) = B(21)/B(22);
jac(16,17) = 1/B(22);

jac(17,16) = -1/B(23);
jac(17,18) = 1/B(23);

jac(18,18) = 1/B(24);
jac(18,17) = -1/B(24);
jac(18,18) = 1;

jac(19,12) = -1/B(25);
jac(19,20) = 1/B(25);

jac(20,19) = -1/B(27);
jac(20,20) = B(26)/B(27);
jac(20,21) = 1/B(27);

jac(21,20) = -1/B(28);
jac(21,22) = 1/B(28);

jac(22,21) = -1/B(30);
jac(22,22) = B(29)/B(30);
jac(22,23) = 1/B(30);

jac(23,22) = -1/B(31);
jac(23,24) = 1/B(31);

jac(24,2) = 1/B(32);
jac(24,23) = -1/B(32);
jac(24,24) = 1;


%%%%%%%%%%%%%%%%%%%% LVAD %%%%%%%%%%%%%%%%%%%
jac(25,26) = 1/B(33);
jac(25,27) = -1/B(33);

jac(26,15) = 1/B(35);
jac(26,25) = -1/B(35); 
jac(26,26) = B(34)/B(35);
%%%%%%%%%%%%%%%%%%%% LVAD %%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%% LVAD %%%%%%%%%%%%%%%%%%%
% %   %%%%%%%%%% LVAD - VARIABLE SPEED CONTROL %%%%%
% 
%   %%%Initiate variable speed cycle
%  init_varspeed = 8.00;
%  
%  % HVAD
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
%   end
  
  
  dp_thresh = 140;

  if((y(25) - y(5)) < dp_thresh && (y(25) - y(5)) > 0)
     
     % Quintic curve
     jac(27,5) = B(36)*5*((y(25) - y(5)))^4 + B(37)*4*((y(25) - y(5)))^3 + B(38)*3*((y(25) - y(5)))^2 ...
         + B(39)*2*((y(25) - y(5))) + B(40);
     jac(27,25) = - B(36)*5*((y(25) - y(5)))^4 - B(37)*4*((y(25) - y(5)))^3 - B(38)*3*((y(25) - y(5)))^2 ...
         - B(39)*2*((y(25) - y(5))) - B(40);    
     
     jac(27,27) = 1;    
     
 else
     jac(27,27) = 1;
 end
 
%%%%%%%%%%%%%%%%%%%% LVAD %%%%%%%%%%%%%%%%%%%

%%%

%jac = jac*-1;
    
    

end