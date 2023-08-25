function f = cardiac_lpn_system_Shi_et_al_Implicit(t,y,yp)


% Obtain system constants
B = system_constants_Shi_et_al(t);

% Specify system of equations

% Left Atrium
f(1,1) = yp(1) - y(24)+ y(3);
f(2,1) = y(2) - B(1) - B(2)*(y(1) - B(3));
%f(3,1) = y(3) - sign(y(2) - y(5))*B(4)*sqrt(abs(y(2) - y(5)));
if(y(2) > y(5))
    f(3,1) = y(3) - B(4)*sqrt(abs(y(2) - y(5)));
else
    %f(3,1) = y(3) + B(4)*sqrt(abs(y(5) - y(2)));
    f(3,1) = y(3) - 0;
end

f(4,1) = yp(4) - y(3) + y(6);
f(5,1) = y(5) - B(5) - B(6)*(y(4) - B(7));
%f(6,1) = y(6) - sign(y(5) - y(13))*B(8)*sqrt(abs(y(5) - y(13)));
if(y(5) > y(13))
    f(6,1) = y(6) - B(8)*sqrt(abs(y(5) - y(13)));
else
    %f(6,1) = y(6) + B(8)*sqrt(abs(y(13) - y(5)));
    f(6,1) = y(6) - 0;
end

f(7,1) = yp(7) - y(18) + y(9);
f(8,1) = y(8) - B(9) - B(10)*(y(7) - B(11));
%f(9,1) = y(9) - sign(y(8) - y(11))*B(12)*sqrt(abs(y(8) - y(11)));
if(y(8) > y(11))
    f(9,1) = y(9) - B(12)*sqrt(abs(y(8) - y(11)));
else
    %f(9,1) = y(9) + B(12)*sqrt(abs(y(8) - y(11)));
    f(9,1) = y(9) - 0;
end

f(10,1) = yp(10) - y(9) + y(12);
f(11,1) = y(11) - B(13) - B(14)*(y(10) - B(15));
%f(12,1) = y(12) - sign(y(11) - y(14))*B(16)*sqrt(abs(y(11) - y(14)));
if(y(11) > y(19))
    f(12,1) = y(12) - B(16)*sqrt(abs(y(11) - y(19)));
else
    %f(12,1) = y(12) + B(16)*sqrt(abs(y(11) - y(14)));
    f(12,1) = y(12) - 0;
end

f(13,1) = yp(13) - (y(6) - y(14))/B(17);
f(14,1) = yp(14) - (y(13) - y(15) - B(18)*y(14))/B(19);

f(15,1) = yp(15) - (y(14) - y(16))/B(20);
f(16,1) = yp(16) - (y(15) - y(17) - B(21)*y(16))/B(22);

f(17,1) = yp(17) - (y(16) - y(18))/B(23);
f(18,1) = y(18) - (y(17) - y(8))/B(24);

f(19,1) = yp(19) - (y(12) - y(20))/B(25);
f(20,1) = yp(20) - (y(19) - y(21) - B(26)*y(20))/B(27);

f(21,1) = yp(21) - (y(20) - y(22))/B(28);
f(22,1) = yp(22) - (y(21) - y(23) - B(29)*y(22))/B(30);

f(23,1) = yp(23) - (y(22) - y(24))/B(31);
f(24,1) = y(24) - (y(23) - y(2))/B(32);

end