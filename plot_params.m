function [] = plot_params(tspan,y)

figure
subplot(211)
plot(tspan,y(5,:))
hold on
plot(tspan,y(15,:),'r')
plot(tspan,y(2,:),'k')
legend('Plv','Psat','Pla')
xlabel('Time(s)')
ylabel('Pressure (mmHg)')

subplot(212)
plot(tspan,y(4,:))
hold on
plot(tspan,y(1,:),'r')
legend('Vlv','Vla')
xlabel('Time(s)')
ylabel('Volume (ml)')

%----------------------------------

figure
subplot(221)
plot(y(4,:),y(5,:))
xlabel('Volume (ml)')
ylabel('Pressure (mmHg)')
title('LV P-V loop')

subplot(222)
plot(y(1,:),y(2,:))
xlabel('Volume (ml)')
ylabel('Pressure (mmHg)')
title('LA P-V loop')

subplot(223)
plot(y(10,:),y(11,:))
xlabel('Volume (ml)')
ylabel('Pressure (mmHg)')
title('RV P-V loop')

subplot(224)
plot(y(7,:),y(8,:))
xlabel('Volume (ml)')
ylabel('Pressure (mmHg)')
title('RA P-V loop')

%----------------------------------

figure
subplot(211)
plot(tspan,y(8,:))
hold on
plot(tspan,y(11,:))
plot(tspan,y(19,:))
legend('Pra','Prv','Ppas')
xlabel('Time(s)')
ylabel('Pressure (mmHg)')

subplot(212)
plot(tspan,y(10,:))
hold on
plot(tspan,y(7,:),'r')
legend('Vrv','Vra')
xlabel('Time(s)')
ylabel('Volume (ml)')

%------------------------------------

figure
subplot(211)
%plot(tspan,y(3,:)./16.67)
hold on
%plot(tspan,y(6,:)./16.67)
plot(tspan,y(26,:)./16.67)
legend('Qvad') %'Qmi','Qao',
xlabel('Time(s)')
ylabel('Flow (l/min)')

flow_qvad= y(26,:)./16.67
time = tspan
MeanQ_qvad = mean(y(26,:)/16.67)

subplot(212)
plot(tspan,y(9,:))
hold on
plot(tspan,y(12,:))
legend('Qti','Qpa')
xlabel('Time(s)')
ylabel('Flow (ml/s)')


end