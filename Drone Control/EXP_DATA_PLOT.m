%% Plot Graphs (LONG INTAKE)
% Thrust vs RPM
% Power vs RPM
% FOM vs Re
% Pressure vs Axial Position
% Pressure Rise vs Flow Coefficient
close all;

load('EXP_DATA_SHORTINTAKE.mat');
load('EXP_DATA_LONGINTAKE.mat');
load('EXP_DATA_PROP.mat');

%% Thrust vs RPM
figure(1); subplot(2,2,1); hold on; title('Thrust vs RPM'); xlabel('RPM'); 
ylabel('Thrust / N'); ylim([0 max([max(S08L.T), max(S10L.T), max(S12L.T)])]);
% plot(S08.rpmmean, S08.T, '-or');
% plot(S10.rpmmean, S10.T, '-ok');
% plot(S12.rpmmean, S12.T, '-ob');
plot(S08L.rpmmean, S08L.T, '-xr');
plot(S10L.rpmmean, S10L.T, '-xk');
plot(S12L.rpmmean, S12L.T, '-xb');
legend('Sigma = 0.8', 'Sigma = 1.0', 'Sigma = 1.2', 'Location', 'southeast');
% legend('SHORT Sigma = 0.8', 'SHORT Sigma = 1.0', 'SHORT Sigma = 1.2', 'LONG Sigma = 0.8', 'LONG Sigma = 1.0', 'LONG Sigma = 1.2', 'Location', 'southeast');

%% Power vs RPM
figure(1); subplot(2,2,3); hold on; title('Power vs RPM'); xlabel('RPM'); 
ylabel('Power / W'); ylim([0 max([max(S08L.P), max(S10L.P), max(S12L.P)])]);
% plot(S08.rpmmean, S08.P, '-or');
% plot(S10.rpmmean, S10.P, '-ok');
% plot(S12.rpmmean, S12.P, '-ob');
plot(S08L.rpmmean, S08L.P, '-xr');
plot(S10L.rpmmean, S10L.P, '-xk');
plot(S12L.rpmmean, S12L.P, '-xb');
legend('Sigma = 0.8', 'Sigma = 1.0', 'Sigma = 1.2', 'Location', 'southeast');
% legend('SHORT Sigma = 0.8', 'SHORT Sigma = 1.0', 'SHORT Sigma = 1.2', 'LONG Sigma = 0.8', 'LONG Sigma = 1.0', 'LONG Sigma = 1.2', 'Location', 'southeast');

%% Power vs RPM
figure(1); subplot(2,2,[2 4]); hold on; title('FoM vs Re'); xlabel('Re'); 
ylabel('FoM / M_f'); ylim([0 1.2]);
% plot(S08.rpmmean, S08.FOM, '-or');
% plot(S10.rpmmean, S10.FOM, '-ok');
% plot(S12.rpmmean, S12.FOM, '-ob');
plot(S08L.rpmmean, S08L.FOM, '-xr');
plot(S10L.rpmmean, S10L.FOM, '-xk');
plot(S12L.rpmmean, S12L.FOM, '-xb');
plot([min(S10L.rpmmean) max(S08L.rpmmean)], [mean(BASE.FOM) mean(BASE.FOM)], '-g');
plot([min(S10L.rpmmean) max(S08L.rpmmean)], [mean(PROP.FOM) mean(PROP.FOM)], '-.g');
legend('Sigma = 0.8', 'Sigma = 1.0', 'Sigma = 1.2', 'Baseline Propellor', 'APC Propellor', 'Location', 'northeast');
% legend('SHORT Sigma = 0.8', 'SHORT Sigma = 1.0', 'SHORT Sigma = 1.2', 'LONG Sigma = 0.8', 'LONG Sigma = 1.0', 'LONG Sigma = 1.2', 'Baseline Propellor', 'APC Propellor', 'Location', 'east');

%% 