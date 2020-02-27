%% Light-weight Fan Design Code
% Master
clear all;
close all;

global plotflag
plotflag = 1;

%% Set globals
rho = 1.225;

phi.m = 0.8;
psi.m = 0.25;
psi_ts.m = 2*psi.m - phi.m^2;      % Total to Total stage loading = p02 - p01 / (0.5*rho*U^2)

omega = RPM2RADS(6000);

rc = 60e-3;
rh = 20e-3;

R.AR = 2.5; R.phi = phi.m; R.psi = psi.m;
S.AR = 1.8; S.phi = phi.m; S.psi = psi.m;

%% Continue 
filepath = [pwd, '/Geometry/'];

R.type = 'rotor';
S.type = 'stator';

DESIGNSECTIONS = 5;
%% VORTEX CONDITION
% 'free'; 'forced'; 'constangle';

p = 'free';

if strcmp(p, 'custom')
    pp = 1.5;
else
    pp = 0;
end

%% Set PSI distribution

% 1 = MASS AVERAGED
% 2 = FRACTION OF SPAN
% 3 = PSI AVERAGED
% 4 = PSI*RADIUS AVERAGED

R_POS = 1;

switch R_POS
    case 1 % MASS AVERAGE
        rr = [rc rh];
        rm = rms(rr);
    case 2 % FRACTION OF SPAN
        midlineposition = 0.4;                 % Fraction of span
        rm = rh + (rc-rh)*midlineposition;
    case 3 % PSI AVERAGE
        rm = sqrt(2*(rc^2 * rh^2)/(rc^2 + rh^2));
    case 4 % PSI*RADIUS AVERAGE
        rm = 2*(1/rc + 1/rh)^(-1);
end

%% OPTINAL LOAD EXISTING META DATA
% load('JONNY_RIG.mat');

%% Calculate flow angles and velocities
[V, ang, phi, psi, psi_ts, radius, sections, reaction, pc] = VelocitiesAngles(DESIGNSECTIONS, omega, phi, psi, psi_ts, rc, rh, rm, p, pp);

%% Calculate delta, metal angles, and pitch to chord ratio
[V, ang, R, S, carter, delta] = Deviation('blade', V, ang, phi, psi, R, S);

%% Energy 
[power, thrust, mass, phi, psi, FOM, P] = Energy(V, phi, psi, radius, omega, rho, rc, rh);

%% Assemble blade section variables
[R,S] = Assemble(R,S,ang,sections,radius, rc, rh, rm);

%% Blade Shapes
R = Blades(R, p);
S = Blades(S, p);

%% Plot
if plotflag == 1
    PlotFlow(rc, rh, radius, sections, phi, psi, psi_ts, delta, R, S, carter, V, ang, omega, reaction);
end

sigma = SIG(phi.m, psi.m);