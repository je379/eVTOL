%% Light-weight Fan Design Code
% Master
clear all;
close all;

%% Set globals
global phi psi psi_ts rc rh rm omega angle V p R S delta carter rho mass power thrust sections radius AR

rho = 1.225;

phi.m = 0.8;
psi.m = 0.4;
psi_ts.m = 2*psi.m - phi.m^2;      % Total to Total stage loading = p02 - p01 / (0.5*rho*U^2)

omega = RPM2RADS(7500);

rc = 60e-3;
rh = 20e-3;

AR = 1.8;

%% VORTEX CONDITION
% 'free'; 'forced'; 'constangle';

p = 'constangle';

%% Set PSI distribution

% 1 = MASS AVERAGED
% 2 = FRACTION OF SPAN
% 3 = PSI AVERAGED
% 4 = PSI*RADIUS AVERAGED

R_POS = 3;

switch R_POS
    case 1 % MASS AVERAGE
        rm = sqrt(0.5*(rc^2 + rh^2));
    case 2 % FRACTION OF SPAN
        midlineposition = 0.4585;                 % Fraction of span
        rm = rh + (rc-rh)*midlineposition;
    case 3 % PSI AVERAGE
        rm = sqrt(2*(rc^2 * rh^2)/(rc^2 + rh^2));
    case 4 % PSI*RADIUS AVERAGE
        rm = 2*(1/rc + 1/rh)^(-1);
end

%% Calculate flow angles and velocities
VelocitiesAngles;

%% Calculate delta, metal angles, and pitch to chord ratio
Deviation('blade');

%% Blade chord distributions
R = Chord(R, radius, sections);
S = Chord(S, radius, sections);

%% Energy 
Energy;

%% Blade Shapes
Blades;

%% Plot
% PLOTFLOW;