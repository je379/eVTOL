%% Light-weight Fan Design Code
% Master
clear all;
close all;

%% Set globals
rho = 1.225;

phi.m = 0.6;
psi.m = 0.4;
psi_ts.m = 2*psi.m - phi.m^2;      % Total to Total stage loading = p02 - p01 / (0.5*rho*U^2)

omega = RPM2RADS(5000);

rc = 60e-3;
rh = 20e-3;

R.AR = 1.8;
S.AR = 1.8;

filepath = [pwd, '/Geometry/'];

R.type = 'rotor';
S.type = 'stator';

DESIGNSECTIONS = 5;
%% VORTEX CONDITION
% 'free'; 'forced'; 'constangle';

p = 'constangle';

%% Set PSI distribution

% 1 = MASS AVERAGED
% 2 = FRACTION OF SPAN
% 3 = PSI AVERAGED
% 4 = PSI*RADIUS AVERAGED

R_POS = 2;

switch R_POS
    case 1 % MASS AVERAGE
        rm = sqrt(0.5*(rc^2 + rh^2));
    case 2 % FRACTION OF SPAN
        midlineposition = 0.5;                 % Fraction of span
        rm = rh + (rc-rh)*midlineposition;
    case 3 % PSI AVERAGE
        rm = sqrt(2*(rc^2 * rh^2)/(rc^2 + rh^2));
    case 4 % PSI*RADIUS AVERAGE
        rm = 2*(1/rc + 1/rh)^(-1);
end

%% Calculate flow angles and velocities
[V, ang, phi, psi, psi_ts, radius, sections] = VelocitiesAngles(DESIGNSECTIONS, omega, phi, psi, psi_ts, rc, rh, rm, p);

%% Calculate delta, metal angles, and pitch to chord ratio
[V, ang, R, S, carter, delta] = Deviation('blade', V, ang, phi, psi, R, S);

%% Energy 
[power, thrust, mass, phi, psi, FOM] = Energy(V, phi, psi, radius, omega, rho);

%% Assemble blade section variables
[R,S] = Assemble(R,S,ang,sections,radius, rc, rh, rm);

%% Blade Shapes
R = Blades(R, p);
S = Blades(S, p);

%% 3D Plot blades
figure; hold on; grid on; box on; axis equal;
mesh(squeeze(R.XYZ(:,1,:)),squeeze(R.XYZ(:,3,:)),squeeze(R.XYZ(:,2,:)));
mesh(squeeze(S.XYZ(:,1,:)),squeeze(S.XYZ(:,3,:)),squeeze(S.XYZ(:,2,:)));
plot3(S.centerline(:,1,:),S.centerline(:,3,:),S.centerline(:,2,:));

%% Plot
PLOTFLOW(rc, rh, radius, phi, psi, psi_ts, delta, R, S, carter, V, ang);