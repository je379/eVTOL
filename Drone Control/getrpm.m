%% LOAD IN RPM DATA FIRST (Raw ADC output)
clear all;
close all;

% system("scp pi@raspberrypi:~/drone/STATIC_TEST.txt ./STATIC_TEST.txt");
% system("scp pi@raspberrypi:~/drone/STATIC_THRUST.txt ./STATIC_THRUST.txt");


[timepwr current voltage] = importpower();
[timerpm RPM thr] = importrpm('TEST');
[pks ind] = findpeaks(RPM);

time2 = linspace(0,max(timerpm),length(timerpm));

ind = ind(pks > 0.8);
n = length(ind);
timerpm = time2(ind);

current = current/100;
voltage = voltage/1000;
systemresist = voltage/current;
%% FIDDLE
% load('RPMTEST.mat'); % RPM RAW TEST DATA

averagewindow = 1;

lim = averagewindow;
timerpm = timerpm(lim:end-lim);

for j = 1:n-1
    separation(j) = (time2(ind(j+1)) - time2(ind(j)));
end

timerpm(separation<0.002) = [];
separation(separation<0.002) = [];

f = length(separation);

averagewindow = 2;

for i = 1+averagewindow:f-averagewindow+1
    separation(i) = (sum(separation(i-averagewindow:i+averagewindow-1))/(2*averagewindow));
end

frequency = 1./separation;
rpmmeasure = zeros([1, f]);

for i = 1+averagewindow:f-averagewindow+1
    rpmmeasure(i) =  0.5 * 60 * (sum(frequency(i-averagewindow:i+averagewindow-1))/(2*averagewindow));
end

%%
averagewindow = 2;

k = length(rpmmeasure);

liml = averagewindow;
limh = averagewindow-1;

for l = 1+averagewindow:k-averagewindow+1
    rpmmeasure(l) =  (sum(rpmmeasure(l-liml:l+limh-1)) / (2*averagewindow - 1));
end

%% PLOT
rpmmean = mean(rpmmeasure(rpmmeasure > 0.8*max(rpmmeasure)));

power = voltage.*current;
P = mean(power(power > 0.8*max(power)));
T = mean(thr(thr > 0.8*max(thr)))/1000;
A = 0.0092;
rho = 1.225;

FOM = (T/P)*sqrt(T/(2*A*rho));

mass = 1000*T/9.81;

output = [rpmmean mass]
FOM

figure(1); 
subplot(2,2,1); hold on; plot(timerpm, rpmmeasure); plot([0 max(timerpm)], [rpmmean rpmmean], 'k'); title('RPM'); xlabel('Time'); ylabel('RPM');
subplot(2,2,2); hold on; plot(time2, thr/9.81);plot([0 max(time2)], [1000*T/9.81 1000*T/9.81], 'k'); ylim([0 1.2*1000*T/9.81]);title('Thrust (in grams)'); xlabel('Time'); ylabel('grams');
% subplot(2,2,2); hold on; plot(thr/9.81);plot([1000*T/9.81 1000*T/9.81], 'k'); ylim([0 1.2*1000*T/9.81]);title('Thrust (in grams)'); xlabel('Time'); ylabel('grams');

figure(1); subplot(2,2,3); hold on; plot(timepwr/1000, current); plot(timepwr/1000, voltage); ylim([0 1.2*max(voltage)]); title('Electrical Input'); xlabel('Time'); ylabel('Amps or Volts'); legend('Current', 'Voltage');
subplot(2,2,4); hold on; plot(timepwr/1000, power); plot([0 max(timepwr)/1000], [P P], 'k'); ylim([0 1.2*P]); title('Power'); xlabel('Time'); ylabel('Watts');

save('OP_SIG10_L_16', 'FOM', 'rpmmean', 'P', 'T', 'mass');
% save('OP_PROP_BASE', 'FOM', 'P', 'T', 'mass');