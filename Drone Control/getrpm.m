%% LOAD IN RPM DATA FIRST (Raw ADC output)
clear all;
close all;

importrpm;
[pks ind] = findpeaks(RPM);

time2 = linspace(0,max(time),length(time));

ind = ind(pks > 0.8);
n = length(ind);
timerpm = time2(ind);

voltage = 11.82;
current = 88/voltage;

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

averagewindow = 5;

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
rpmmean = mean(rpmmeasure(2000:end))

P = voltage*current;
T = mean(thr(150000:end))/1000;
A = 0.0092;
rho = 1.225;

FOM = (T/P)*sqrt(T/(2*A*rho))

mass = 1000*T/9.81

figure(1); subplot(2,1,1); hold on; plot(timerpm, rpmmeasure); plot([0 max(timerpm)], [rpmmean rpmmean]); title('RPM'); xlabel('Time'); ylabel('RPM');
subplot(2,1,2); hold on; plot([0 max(time2)], [1000*T/9.81 1000*T/9.81]); plot(time2, thr/9.81);title('Thrust (in grams)'); xlabel('Time'); ylabel('grams');

save('OP_SIG08_3', 'FOM', 'rpmmean', 'P', 'T', 'mass');