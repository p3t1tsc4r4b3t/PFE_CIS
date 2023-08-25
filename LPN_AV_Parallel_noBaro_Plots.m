% *************************************************************************
% Plotting results for HVAD with pulsatility mode on
% Pulsatility mode kicks in every 0.1sec for 10 cases
% CVKeshav
% March 2018
%**************************************************************************

clc
clear all
close all

% Load data for HVAD Pulsatility cases
% 1st case is without pulsatility mode,only steady speed at 2600rpm

fileID = fopen('CaseList.txt');
names = textscan(fileID,'%s');
fclose(fileID);

num_names = size(names{1},1);

index = 1;
clear case_data

% In case_data, entries #1-9 are for HVAD, entries #10-20 are for HM3

for i=1:num_names

    case_name = names{1}{i};
    
    filename = [case_name '.mat'];
    
    clear temp1 temp2
    temp1 = load(filename);
    temp2 = temp1.data;
    
    case_data(index).data = temp2;
    
    index = index+1;

end


% In case_data, entry #1 is no pulse mode, entry #2-11 are with pulse mode

% Plotting parameters
lw = 2;
fs = 20;



%% Plot HVAD Cases

close all

clear t c1 c2 c3 c4 c5 c6 c7 c8 c9 c10 c11 

c1 = case_data(1).data.y;
c2 = case_data(2).data.y;
c3 = case_data(3).data.y;
% c4 = case_data(4).data.y;
% c5 = case_data(5).data.y;
% c6 = case_data(6).data.y;
% c7 = case_data(7).data.y;
% c8 = case_data(8).data.y;
% c9 = case_data(9).data.y;
% c10 = case_data(10).data.y;
% c11 = case_data(11).data.y;

tspan = case_data(1).data.tspan;

%% MAP and QLVAD 

f5=figure('units','normalized','outerposition',[0 0 1 1])
subplot(211)
plot(tspan,c1(15,:),'k','LineWidth',lw)
hold on
plot(tspan,c2(15,:),'b-','LineWidth',lw)
plot(tspan,c3(15,:),'c-','LineWidth',lw)
% plot(tspan,c4(15,:),'g-','LineWidth',lw)
% plot(tspan,c5(15,:),'r-','LineWidth',lw)
% plot(tspan,c6(15,:),'-','color',[0.91 0.41 0.17],'LineWidth',lw)
% plot(tspan,c7(15,:),'b--','LineWidth',lw)
% plot(tspan,c8(15,:),'c--','LineWidth',lw)
% plot(tspan,c9(15,:),'g--','LineWidth',lw)
% plot(tspan,c10(15,:),'r--','LineWidth',lw)
% plot(tspan,c11(15,:),'--','color',[0.91 0.41 0.17],'LineWidth',lw)
legend('2600rpm','Pulse @6.0s','Pulse @6.1s','Pulse @6.2s','Pulse @6.3s','Pulse @6.4s','Pulse @6.5s','Pulse @6.6s','Pulse @6.7s','Pulse @6.8s','Pulse @6.9s','Orientation','vertical','Location','eastoutside');
xlabel('Time(s)','FontWeight','bold')
ylabel('Pressure (mmHg)','FontWeight','bold')
xlim([4 12])
xt = get(gca, 'XTick');
set(gca, 'FontSize', fs)

subplot(212)
plot(tspan,c1(6,:),'k','LineWidth',lw)
hold on
plot(tspan,c2(6,:),'b-','LineWidth',lw)
plot(tspan,c3(6,:),'c-','LineWidth',lw)
% plot(tspan,c4(6,:),'g-','LineWidth',lw)
% plot(tspan,c5(6,:),'r-','LineWidth',lw)
% plot(tspan,c6(6,:),'-','color',[0.91 0.41 0.17],'LineWidth',lw)
% plot(tspan,c7(6,:),'b--','LineWidth',lw)
% plot(tspan,c8(6,:),'c--','LineWidth',lw)
% plot(tspan,c9(6,:),'g--','LineWidth',lw)
% plot(tspan,c10(6,:),'r--','LineWidth',lw)
% plot(tspan,c11(6,:),'--','color',[0.91 0.41 0.17],'LineWidth',lw)
legend('2600rpm','Pulse @6.0s','Pulse @6.1s','Pulse @6.2s','Pulse @6.3s','Pulse @6.4s','Pulse @6.5s','Pulse @6.6s','Pulse @6.7s','Pulse @6.8s','Pulse @6.9s','Orientation','vertical','Location','eastoutside');
xlabel('Time(s)','FontWeight','bold')
ylabel('Volume (ml)','FontWeight','bold')
xlim([5 12])
ylim([0 150])
xt = get(gca, 'XTick');
set(gca, 'FontSize', fs)

saveas(f5,'HVAD_Pulsatility_Mode_2600rpm_MAP_QLVAD.fig')
saveas(f5,'HVAD_Pulsatility_Mode_2600rpm_MAP_QLVAD.png')

% LVP
f6=figure('units','normalized','outerposition',[0 0 1 1])
plot(tspan,c1(5,:),'k','LineWidth',lw)
hold on
plot(tspan,c2(5,:),'b-','LineWidth',lw)
plot(tspan,c3(5,:),'c-','LineWidth',lw)
% plot(tspan,c4(5,:),'g-','LineWidth',lw)
% plot(tspan,c5(5,:),'r-','LineWidth',lw)
% plot(tspan,c6(5,:),'-','color',[0.91 0.41 0.17],'LineWidth',lw)
% plot(tspan,c7(5,:),'b--','LineWidth',lw)
% plot(tspan,c8(5,:),'c--','LineWidth',lw)
% plot(tspan,c9(5,:),'g--','LineWidth',lw)
% plot(tspan,c10(5,:),'r--','LineWidth',lw)
% plot(tspan,c11(5,:),'--','color',[0.91 0.41 0.17],'LineWidth',lw)
legend('2600rpm','Pulse @6.0s','Pulse @6.1s','Pulse @6.2s','Pulse @6.3s','Pulse @6.4s','Pulse @6.5s','Pulse @6.6s','Pulse @6.7s','Pulse @6.8s','Pulse @6.9s','Orientation','vertical','Location','eastoutside');
xlabel('Time(s)','FontWeight','bold')
ylabel('Pressure (mmHg)','FontWeight','bold')
xlim([4 12])
xt = get(gca, 'XTick');
set(gca, 'FontSize', fs)


f6=figure('units','normalized','outerposition',[0 0 1 1])
plot(tspan,c1(13,:),'k','LineWidth',lw)
hold on
plot(tspan,c2(13,:),'b-','LineWidth',lw)
plot(tspan,c3(13,:),'c-','LineWidth',lw)
% plot(tspan,c4(13,:),'g-','LineWidth',lw)
% plot(tspan,c5(13,:),'r-','LineWidth',lw)
% plot(tspan,c6(13,:),'-','color',[0.91 0.41 0.17],'LineWidth',lw)
% plot(tspan,c7(13,:),'b--','LineWidth',lw)
% plot(tspan,c8(13,:),'c--','LineWidth',lw)
% plot(tspan,c9(13,:),'g--','LineWidth',lw)
% plot(tspan,c10(13,:),'r--','LineWidth',lw)
% plot(tspan,c11(13,:),'--','color',[0.91 0.41 0.17],'LineWidth',lw)
legend('2600rpm','Pulse @6.0s','Pulse @6.1s','Pulse @6.2s','Pulse @6.3s','Pulse @6.4s','Pulse @6.5s','Pulse @6.6s','Pulse @6.7s','Pulse @6.8s','Pulse @6.9s','Orientation','vertical','Location','eastoutside');
xlabel('Time(s)','FontWeight','bold')
ylabel('Pressure (mmHg)','FontWeight','bold')
xlim([4 12])
xt = get(gca, 'XTick');
set(gca, 'FontSize', fs)


%% P-V Loops
% Plot LV P-V loop 
clear r1
r1 = find(tspan >= 6);
st = r1(1);
clear r2
r2 = find(tspan >= 7);
fin = r2(1);

f7=figure('units','normalized','outerposition',[0 0 1 1])
%subplot(121)
plot(c1(4,st:fin),c1(5,st:fin),'k','LineWidth',lw)
hold on
plot(c2(4,st:fin),c2(5,st:fin),'b','LineWidth',lw*2)
plot(c3(4,st:fin),c3(5,st:fin),'c','LineWidth',lw*2)
% plot(c4(4,st:fin),c4(5,st:fin),'g','LineWidth',lw*2)
% plot(c5(4,st:fin),c5(5,st:fin),'r','LineWidth',lw*2)
% plot(c6(4,st:fin),c6(5,st:fin),'-','color',[0.91 0.41 0.17],'LineWidth',lw*2)
% plot(c7(4,st:fin),c7(5,st:fin),'b--','LineWidth',lw*2)
% plot(c8(4,st:fin),c8(5,st:fin),'c--','LineWidth',lw*2)
% plot(c8(4,st:fin),c9(5,st:fin),'g--','LineWidth',lw*2)
% plot(c10(4,st:fin),c10(5,st:fin),'r--','LineWidth',lw*2)
% plot(c11(4,st:fin),c11(5,st:fin),'--','color',[0.91 0.41 0.17],'LineWidth',lw*2)
%legend('2600rpm','Pulse @6.0s','Pulse @6.1s','Pulse @6.2s','Pulse @6.3s','Pulse @6.4s','Pulse @6.5s','Pulse @6.6s','Pulse @6.7s','Pulse @6.8s','Pulse @6.9s','Orientation','vertical','Location','eastoutside');
xlabel('Volume (ml)','FontWeight','bold')
ylabel('Pressure (mmHg)','FontWeight','bold')
xlim([80 130])
%ylim([0 180])
xt = get(gca, 'XTick');
set(gca, 'FontSize', fs)

saveas(f7,'HVAD_Pulsatility_Mode_2600rpm_LV_PV_Loop.fig')
saveas(f7,'HVAD_Pulsatility_Mode_2600rpm_LV_PV_Loop.png')

% Plot RV P-V loop 
clear r1
r1 = find(tspan >= 6);
st = r1(1);
clear r2
r2 = find(tspan >= 7);
fin = r2(1);

f8=figure('units','normalized','outerposition',[0 0 1 1])
%subplot(121)
plot(c1(10,st:fin),c1(11,st:fin),'k','LineWidth',lw)
hold on
plot(c2(10,st:fin),c2(11,st:fin),'b','LineWidth',lw*2)
plot(c3(10,st:fin),c3(11,st:fin),'c','LineWidth',lw*2)
% plot(c4(10,st:fin),c4(11,st:fin),'g','LineWidth',lw*2)
% plot(c5(10,st:fin),c5(11,st:fin),'r','LineWidth',lw*2)
% plot(c6(10,st:fin),c6(11,st:fin),'-','color',[0.91 0.41 0.17],'LineWidth',lw*2)
% plot(c7(10,st:fin),c7(11,st:fin),'b--','LineWidth',lw*2)
% plot(c8(10,st:fin),c8(11,st:fin),'c--','LineWidth',lw*2)
% plot(c8(10,st:fin),c9(11,st:fin),'g--','LineWidth',lw*2)
% plot(c10(10,st:fin),c10(11,st:fin),'r--','LineWidth',lw*2)
% plot(c11(10,st:fin),c11(11,st:fin),'--','color',[0.91 0.41 0.17],'LineWidth',lw*2)
%legend('2600rpm','Pulse @6.0s','Pulse @6.1s','Pulse @6.2s','Pulse @6.3s','Pulse @6.4s','Pulse @6.5s','Pulse @6.6s','Pulse @6.7s','Pulse @6.8s','Pulse @6.9s','Orientation','vertical','Location','eastoutside');
xlabel('Volume (ml)','FontWeight','bold')
ylabel('Pressure (mmHg)','FontWeight','bold')
xlim([80 130])
%ylim([0 180])
xt = get(gca, 'XTick');
set(gca, 'FontSize', fs)

saveas(f8,'HVAD_Pulsatility_Mode_2600rpm_RV_PV_Loop.fig')
saveas(f8,'HVAD_Pulsatility_Mode_2600rpm_RV_PV_Loop.png')


%% test differentials

clear p dpdt 

p = c2(15,:);
dpdt(1) = 0;

for i=2:numel(p)
    
    dpdt(i) = (p(i) - p(i-1))/(t(i) - t(i-1)); 
    
end

figure
subplot(121)
plot(t,p)
subplot(122)
plot(t,dpdt)

clear v dvdt 

v = c2(6,:);
dvdt(1) = 0;

for i=2:numel(v)
    
    dvdt(i) = (v(i) - v(i-1))/(t(i) - t(i-1)); 
    
end

figure
subplot(121)
plot(t,v)
subplot(122)
plot(t,dvdt)

%% Pulse characteristics



clear r1
r1 = find(tspan >= 5);
st = r1(1);
clear r2
r2 = find(tspan >= 12);
fin = r2(1);

% MAP
clear MAP_pulse 

for i=1:num_names
    
    
    clear minp maxp deltap tdata1 tdata2 tdiff
    tdata1 = case_data(1).data.y(15,st:fin);
    tdata2 = case_data(i).data.y(15,st:fin);
    
    tdiff = tdata1 - tdata2;    
    
    minp = min(tdiff);
    maxp = max(tdiff);
    min_press = min(tdata2);
    
    
    MAP_pulse(i,1) = minp;
    MAP_pulse(i,2) = maxp;
    MAP_pulse(i,3) = min_press;

end

% LVAD flow

clear QLVAD_pulse

for i=1:num_names
    
    clear minp maxp deltap tdata1 tdata2 tdiff
    tdata1 = case_data(1).data.y(6,st:fin);
    tdata2 = case_data(i).data.y(6,st:fin);
    
    tdiff = tdata1 - tdata2;    
    
    minp = min(tdiff);
    maxp = max(tdiff);
    min_flow = min(tdata2);
    
    QLVAD_pulse(i,1) = minp;
    QLVAD_pulse(i,2) = maxp;
    QLVAD_pulse(i,3) = min_flow;

end

figure
plot(QLVAD_pulse(:,3))

%% Write Pulse data to file

fid = fopen('HVAD_Pulsatility_Mode_2600rpm_MAP_QLVAD_PulseMag.txt','w');
fprintf(fid,'**************************************************************\n');
fprintf(fid,'--------------------------------------------------------------\n');
fprintf(fid,'--------------------- MAP PULSE DATA (mmHg) --------------------\n');
fprintf(fid,'--------------------------------------------------------------\n');
fprintf(fid,'Min Pulse Mag \t Max Pulse Mag \t Min Pressure \n');
for i=1:num_names
fprintf(fid,'%6.4f \t %6.4f \t %6.4f\n',MAP_pulse(i,1),MAP_pulse(i,2),MAP_pulse(i,3));
end
fprintf(fid,'--------------------------------------------------------------\n');
fprintf(fid,'**************************************************************\n');
fprintf(fid,'--------------------------------------------------------------\n');
fprintf(fid,'--------------------- QLVAD PULSE DATA (ml) --------------------\n');
fprintf(fid,'--------------------------------------------------------------\n');
fprintf(fid,'Min Pulse Mag \t Max Pulse Mag \t Min Flow \n');
for i=1:num_names
fprintf(fid,'%6.4f \t %6.4f \t %6.4f\n',QLVAD_pulse(i,1),QLVAD_pulse(i,2),QLVAD_pulse(i,3));
end
fprintf(fid,'--------------------------------------------------------------\n');
fprintf(fid,'**************************************************************\n');
fprintf(fid,'NOTE: PULSE STARTS AT 6.0 sec IN STEPS OF 0.1 sec');
fclose(fid)

%% Get Flow Rates

t_final = tspan(numel(tspan));
st = 1;
fin = numel(tspan);

for i=1:num_names
    clear tdata
    tdata = case_data(i).data.y;
Mean_Qvad(i) = trapz(tspan(st:fin),tdata(6,st:fin))*(60/t_final)*1e-3;
end

%% Get pulmonary pressures

clear y
   y = c1_data;
   PVsys = max(y(21,9000:10000))
   MVP = mean(y(21,8000:10000))
   lvedv = min(y(4,8000:10000))
   lvesv = max(y(4,8000:10000))
   rvedv = min(y(10,8000:10000))
   rvesv = max(y(10,8000:10000))
   
   clear y
   y = c2_data;
   PVsys = max(y(21,9000:10000))
   MVP = mean(y(21,8000:10000)) 
    lvedv = min(y(4,8000:10000))
   lvesv = max(y(4,8000:10000))
   rvedv = min(y(10,8000:10000))
   rvesv = max(y(10,8000:10000))
   
  
   clear PVsys MVP

for i=1:num_names
   clear y
   y = case_data(i).data.y;
   PVsys(i) = max(y(21,9000:10000));
   MVP(i) = mean(y(21,8000:10000)); 
   lvedv(i) = min(y(4,8000:10000));
   lvesv(i) = max(y(4,8000:10000));
   rvedv(i) = min(y(10,8000:10000));
   rvesv(i) = max(y(10,8000:10000));
end

%% Increase pulmonary vascular resistance (pulmonary hypertension)
clear c12 c13 c14 c15

c12 = case_data(10).data.y;
c13 = case_data(11).data.y;
c14 = case_data(12).data.y;
c15 = case_data(13).data.y;



% LV LA P and V
f5=figure('units','normalized','outerposition',[0 0 1 1])
subplot(211)
plot(tspan,c8(5,:),'b--','LineWidth',lw)
hold on
plot(tspan,c13(5,:),'c--','LineWidth',lw)
plot(tspan,c14(5,:),'g--','LineWidth',lw)
plot(tspan,c15(5,:),'r--','LineWidth',lw)
plot(tspan,c8(15,:),'b','LineWidth',lw)
plot(tspan,c13(15,:),'c','LineWidth',lw)
plot(tspan,c14(15,:),'g','LineWidth',lw)
plot(tspan,c15(15,:),'r','LineWidth',lw)
legend('Plv_{HVAD 2360rpm}','Plv_{HVAD 2360rpm PVR+60%}','Plv_{HVAD 2600rpm PVR+60%}','Plv_{HVAD 3000rpm PVR+60%}','Psa_{HVAD 2360rpm}','Psa_{HVAD 2360rpm PVR+60%}','Psa_{HVAD 2600rpm PVR+60%}','Psa_{HVAD 3000rpm PVR+60%}','Orientation','vertical','Location','eastoutside')
xlabel('Time(s)','FontWeight','bold')
ylabel('Pressure (mmHg)','FontWeight','bold')
xlim([10 15])
xt = get(gca, 'XTick');
set(gca, 'FontSize', fs)

subplot(212)
plot(tspan,c8(4,:),'b','LineWidth',lw)
hold on
plot(tspan,c13(4,:),'c','LineWidth',lw)
plot(tspan,c14(4,:),'g','LineWidth',lw)
plot(tspan,c15(4,:),'r','LineWidth',lw)
plot(tspan,c8(1,:),'b--','LineWidth',lw)
plot(tspan,c13(1,:),'c--','LineWidth',lw)
plot(tspan,c14(1,:),'g--','LineWidth',lw)
plot(tspan,c15(1,:),'r--','LineWidth',lw)
legend('Vlv_{HVAD 2360rpm}','Vlv_{HVAD 2360rpm PVR+60%}','Vlv_{HVAD 2600rpm PVR+60%}','Vlv_{HVAD 3000rpm PVR+60%}','Vla_{HVAD 2360rpm}','Vla_{HVAD 2360rpm PVR+60%}','Vla_{HVAD 2600rpm PVR+60%}','Vla_{HVAD 3000rpm PVR+60%}','Orientation','vertical','Location','eastoutside')
xlabel('Time(s)','FontWeight','bold')
ylabel('Volume (ml)','FontWeight','bold')
xlim([10 15])
xt = get(gca, 'XTick');
set(gca, 'FontSize', fs)

saveas(f5,'HF_HVAD_MAP70mmHg_SVRchange_PVR+_LV_LA.fig')
saveas(f5,'HF_HVAD_MAP70mmHg_SVRchange_PVR+_LV_LA.png')

% P-V Loops
% Plot P-V loop only for last cardiac cycle
clear r1
r1 = find(tspan >= 14);
st = r1(1);
fin = numel(tspan);

f7=figure('units','normalized','outerposition',[0 0 1 1])
subplot(121)
plot(c1_data(4,st:fin),c1_data(5,st:fin),'k--','LineWidth',lw)
hold on
plot(c8(4,st:fin),c8(5,st:fin),'b','LineWidth',lw*2)
plot(c13(4,st:fin),c13(5,st:fin),'c','LineWidth',lw*2)
plot(c14(4,st:fin),c14(5,st:fin),'g','LineWidth',lw*2)
plot(c15(4,st:fin),c15(5,st:fin),'r','LineWidth',lw*2)
legend('LV P-V_{H}','LV P-V_{HVAD 2360rpm}','LV P-V_{HVAD 2360rpm PVR+60%}','LV P-V_{HVAD 2600rpm PVR+60%}','LV P-V_{HVAD 3000rpm PVR+60%}','Orientation','vertical')
xlabel('Volume (ml)','FontWeight','bold')
ylabel('Pressure (mmHg)','FontWeight','bold')
xlim([0 300])
ylim([0 180])
xt = get(gca, 'XTick');
set(gca, 'FontSize', fs)


subplot(122)
plot(c1_data(10,st:fin),c1_data(11,st:fin),'k--','LineWidth',lw)
hold on
plot(c8(10,st:fin),c8(11,st:fin),'b','LineWidth',lw*2)
plot(c13(10,st:fin),c13(11,st:fin),'c','LineWidth',lw*2)
plot(c14(10,st:fin),c14(11,st:fin),'g','LineWidth',lw*2)
plot(c15(10,st:fin),c15(11,st:fin),'r','LineWidth',lw*2)
legend('RV P-V_{H}','RV P-V_{HVAD 2360rpm}','RV P-V_{HVAD 2360rpm PVR+60%}','RV P-V_{HVAD 2600rpm PVR+60%}','RV P-V_{HVAD 3000rpm PVR+60%}','Orientation','vertical')
xlabel('Volume (ml)','FontWeight','bold')
ylabel('Pressure (mmHg)','FontWeight','bold')
xlim([0 150])
ylim([0 80])
xt = get(gca, 'XTick');
set(gca, 'FontSize', fs)

saveas(f7,'HF_HVAD_MAP70mmHg_SVRchange_PVR+_P-V Loop.fig')
saveas(f7,'HF_HVAD_MAP70mmHg_SVRchange_PVR+_P-V Loop.png')

% RV RA P and V
f16=figure('units','normalized','outerposition',[0 0 1 1])
subplot(211)
plot(tspan,c8(8,:),'b--','LineWidth',lw)
hold on
plot(tspan,c13(8,:),'c--','LineWidth',lw)
plot(tspan,c14(8,:),'g--','LineWidth',lw)
plot(tspan,c15(8,:),'r--','LineWidth',lw)
plot(tspan,c8(11,:),'b','LineWidth',lw)
plot(tspan,c13(11,:),'c','LineWidth',lw)
plot(tspan,c14(11,:),'g','LineWidth',lw)
plot(tspan,c15(11,:),'r','LineWidth',lw)
legend('Pra_{HVAD 2360rpm}','Pra_{HVAD 2360rpm PVR+60%}','Pra_{HVAD 2600rpm PVR+60%}','Pra_{HVAD 3000rpm PVR+60%}','Prv_{HVAD 2360rpm}','Prv_{HVAD 2360rpm PVR+60%}','Prv_{HVAD 2600rpm PVR+60%}','Prv_{HVAD 3000rpm PVR+60%}','Orientation','vertical','Location','eastoutside')
xlabel('Time(s)','FontWeight','bold')
ylabel('Pressure (mmHg)','FontWeight','bold')
xlim([10 15])
xt = get(gca, 'XTick');
set(gca, 'FontSize', fs)

subplot(212)
plot(tspan,c8(10,:),'b','LineWidth',lw)
hold on
plot(tspan,c13(10,:),'c','LineWidth',lw)
plot(tspan,c14(10,:),'g','LineWidth',lw)
plot(tspan,c15(10,:),'r','LineWidth',lw)
plot(tspan,c8(7,:),'b--','LineWidth',lw)
plot(tspan,c13(7,:),'c--','LineWidth',lw)
plot(tspan,c14(7,:),'g--','LineWidth',lw)
plot(tspan,c15(7,:),'r--','LineWidth',lw)
legend('Vrv_{HVAD 2360rpm}','Vrv_{HVAD 2360rpm PVR+60%}','Vrv_{HVAD 2600rpm PVR+60%}','Vrv_{HVAD 3000rpm PVR+60%}','Vra_{HVAD 2360rpm}','Vra_{HVAD 2360rpm PVR+60%}','Vra_{HVAD 2600rpm PVR+60%}','Vra_{HVAD 3000rpm PVR+60%}','Orientation','vertical','Location','eastoutside')
xlabel('Time(s)','FontWeight','bold')
ylabel('Volume (ml)','FontWeight','bold')
xlim([10 15])
xt = get(gca, 'XTick');
set(gca, 'FontSize', fs)

saveas(f16,'HF_HVAD_Pressure_Volume_MAP70mmHg_SVRchange_PVR+_RV_RA.fig')
saveas(f16,'HF_HVAD_Pressure_Volume_MAP70mmHg_SVRchange_PVR+_RV_RA.png')

% %% 3D surface plot for rpm,speed and flow
% 
% clear X Y Z
% X = [2200,2400,2600,2800,3000];
% Y = [71.56,81.54,91.34,95.26,105.92];
% Z = [3.41,3.97,4.53,4.75,5.35];
% 
% 
% x=linspace(X(1),X(5),50);
% y=linspace(Y(1),Y(5),50);
% [Xt,Yt]=meshgrid(x,y);
% V=griddata(X,Y,Z,Xt,Yt,'v4');
% 
% surf(Xt,Yt,V)
% 
% [X,Y] = meshgrid(1:1:10,1:20);
% Z = sin(X) + cos(Y);
% surf(X,Y,Z)

%%  Calculation of cardiac parameters
% ejection fraction = stroke-volume/end-diastolic-volume

clear r1
r1 = find(tspan >= 14.2);
st = r1(1);
fin = numel(tspan);

clear tdat
tdat = c1_data;

time = tspan(st:fin);
qout = tdat(6,st:fin);
vlv = tdat(4,st:fin);

ef(1) = (max(vlv)-min(vlv))/max(vlv)


clear tdat
tdat = c2_data;

time = tspan(st:fin);
qout = tdat(6,st:fin);
vlv = tdat(4,st:fin);

ef(2) = (max(vlv)-min(vlv))/max(vlv)

clear y
y = tdat;

Psys = max(y(15,9000:10000))

Pdias = min(y(15,9000:10000))



PVsys = max(y(21,9000:10000))

MVP = mean(y(21,8000:10000))

% for i=1:num_names
% 
%     clear tdat
%     tdat =case_data(i).data;
% 
% 
% ef(i+2) = (max(vlv)-min(vlv))/max(vlv);
%     
%    
% 
% end

