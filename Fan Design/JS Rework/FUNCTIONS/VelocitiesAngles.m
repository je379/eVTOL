function DHR = VelocitiesAngles()
%% Mean line design (2D section design)
% Set location of 'meanline' with 'r'
% Assume axial inlet and exit flow

global phi psi psi_ts rc rh rm omega radius angle sections V p rho mass power thrust

radius = linspace(rh, rc, 99999);
sections = [rh rm rc];

%% Radial Equilibrium Function solutions

[phi.sec, psi.sec, psi_ts.sec] = Distributions(p, phi, psi, sections); % Section
[phi.span, psi.span, psi_ts.span] = Distributions(p, phi, psi, radius); % Span

%% Velocity Triangles and Flow Angles

[angle.m V.m] = Flow(rm, omega, phi.m, psi.m); % Midline
[angle.sec V.sec] = Flow(sections, omega, phi.sec, psi.sec); % Sections
[angle.span V.span] = Flow(radius, omega, phi.span, psi.span); % Span

%% De Hallers rule: c2/c1 >= 0.72
DHR = V.sec.rel2 ./ V.sec.rel1;
end