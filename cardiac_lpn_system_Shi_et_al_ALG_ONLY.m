function f = cardiac_lpn_system_Shi_et_al_ALG_ONLY(y)

t=0;

% Obtain system constants
B = system_constants_Shi_et_al(t);

% Specify system of equations

% Left Atrium
f(1) = y(1) - 60;
f(2) = y(2) - B(1) - B(2)*(y(1) - B(3));
%f(3,1) = y(3) - sign(y(2) - y(5))*B(4)*sqrt(abs(y(2) - y(5)));
if(y(2) > y(5))
    f(3) = y(3) - B(4)*sqrt(abs(y(2) - y(5)));
else
    %f(3,1) = y(3) + B(4)*sqrt(abs(y(5) - y(2)));
    f(3) = y(3) - 0;
end
f(4) = y(4) - 130;
f(5) = y(5) - B(5) - B(6)*(y(4) - B(11));
%f(6,1) = y(6) - sign(y(5) - y(13))*B(8)*sqrt(abs(y(5) - y(13)));
if(y(5) > y(13))
    f(6) = y(6) - B(8)*sqrt(abs(y(5) - y(13)));
else
    %f(6,1) = y(6) + B(8)*sqrt(abs(y(13) - y(5)));
    f(6) = y(6) - 0;
end
f(7) = y(7) -39;
f(8) = y(8) - B(9) - B(10)*(y(7) - B(11));
%f(9,1) = y(9) - sign(y(8) - y(11))*B(12)*sqrt(abs(y(8) - y(11)));
if(y(8) > y(11))
    f(9) = y(9) - B(12)*sqrt(abs(y(8) - y(11)));
else
    %f(9,1) = y(9) + B(12)*sqrt(abs(y(8) - y(11)));
    f(9) = y(9) - 0;
end
f(10) = y(10) - 110;
f(11) = y(11) - B(13) - B(14)*(y(10) - B(15));
%f(12,1) = y(12) - sign(y(11) - y(14))*B(16)*sqrt(abs(y(11) - y(14)));
if(y(11) > y(19))
    f(12) = y(12) - B(16)*sqrt(abs(y(11) - y(19)));
else
    %f(12,1) = y(12) + B(16)*sqrt(abs(y(11) - y(14)));
    f(12) = y(12) - 0;
end
f(13) = y(13) - 100;
f(14) = y(14) - 0;

f(15) = y(15) - 100;
f(16) = y(16) - 0;

f(17) = y(17) - 10;
f(18) = y(18) - (y(17) - y(8))/B(24);

f(19) = y(19) - 20;
f(20) = y(20) - 0; 

f(21) = y(21) - 20;
f(22) = y(22) - 0; 

f(23) = y(23) - 10;
f(24) = y(24) - (y(23) - y(2))/B(32);

end