%% Plot Graphs (LONG INTAKE)
% Thrust vs RPM
% Power vs RPM
% FOM vs Re
% Pressure vs Axial Position
% Pressure Rise vs Flow Coefficient
close all;

%% Import
load('EXP_DATA_SHORTINTAKE.mat');
load('EXP_DATA_LONGINTAKE.mat');
load('EXP_DATA_PROP.mat');

%% Calculations
r_cCRIT = 57.69e-3; r_h = 20e-3; AR = 1.5; rho = 1.225; mu = 18.13e-6;
c = (r_cCRIT - r_h) / AR; Ax = pi*(r_cCRIT^2 - r_h^2);
S08L.U = (pi/30) .* S08L.rpmmean .* 0.5 .* (r_cCRIT + r_h); S08L.Vx = sqrt(S08L.T .* S08L.sig ./ (rho * Ax)); S08L.V = sqrt(S08L.U.^2 + S08L.Vx.^2); S08L.Re = rho .* S08L.V .* c ./ mu;
S10L.U = (pi/30) .* S10L.rpmmean .* 0.5 .* (r_cCRIT + r_h); S10L.Vx = sqrt(S10L.T .* S10L.sig ./ (rho * Ax)); S10L.V = sqrt(S10L.U.^2 + S10L.Vx.^2); S10L.Re = rho .* S10L.V .* c ./ mu;
S12L.U = (pi/30) .* S12L.rpmmean .* 0.5 .* (r_cCRIT + r_h); S12L.Vx = sqrt(S12L.T .* S12L.sig ./ (rho * Ax)); S12L.V = sqrt(S12L.U.^2 + S12L.Vx.^2); S12L.Re = rho .* S12L.V .* c ./ mu;

S08L.phi = S08L.Vx ./ S08L.U;
S10L.phi = S10L.Vx ./ S10L.U;
S12L.phi = S12L.Vx ./ S12L.U;

S08L.psi = S08L.Vx.^2 ./ (2 .* S08L.U.^2 .* S08L.sig^2);
S10L.psi = S10L.Vx.^2 ./ (2 .* S10L.U.^2 .* S10L.sig^2);
S12L.psi = S12L.Vx.^2 ./ (2 .* S12L.U.^2 .* S12L.sig^2);

S08L.sigpredicted = sqrt(S08L.phi.^2 ./ (2 .* S08L.psi));
S10L.sigpredicted = sqrt(S10L.phi.^2 ./ (2 .* S10L.psi));
S12L.sigpredicted = sqrt(S12L.phi.^2 ./ (2 .* S12L.psi));

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
plot(S08L.Re, S08L.FOM, '-xr');
plot(S10L.Re, S10L.FOM, '-xk');
plot(S12L.Re, S12L.FOM, '-xb');
plot([min(S10L.Re) max(S08L.Re)], [mean(BASE.FOM) mean(BASE.FOM)], '-g');
plot([min(S10L.Re) max(S08L.Re)], [mean(APC.FOM) mean(APC.FOM)], '-.g');
legend('Sigma = 0.8', 'Sigma = 1.0', 'Sigma = 1.2', 'Baseline Propellor', 'APC Propellor', 'Location', 'northeast');
% legend('SHORT Sigma = 0.8', 'SHORT Sigma = 1.0', 'SHORT Sigma = 1.2', 'LONG Sigma = 0.8', 'LONG Sigma = 1.0', 'LONG Sigma = 1.2', 'Baseline Propellor', 'APC Propellor', 'Location', 'east');

save('EXP_DATA_LONGINTAKE.mat', 'S08L','S10L','S12L');
save('EXP_DATA_PROP.mat', 'BASE','APC');