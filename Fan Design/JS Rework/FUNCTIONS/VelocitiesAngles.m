function [V, ang, phi, psi, psi_ts, radius, sections] = VelocitiesAngles(DESIGNSECTIONS, omega, phi, psi, psi_ts, rc, rh, rm, p)
%% Mean line design (2D section design)
% Set location of 'meanline' with 'r'
% Assume axial inlet and exit flow

radius = linspace(rh, rc, 99999);
sections = linspace(rh, rc, DESIGNSECTIONS);

%% Radial Equilibrium Function solutions

[phi.sec, psi.sec, psi_ts.sec] = Distributions(p, phi, psi, sections, rm); % Section
[phi.span, psi.span, psi_ts.span] = Distributions(p, phi, psi, radius, rm); % Span

%% Velocity Triangles and Flow Angles

[ang.m, V.m] = Flow(rm, omega, phi.m, psi.m); % Midline
[ang.sec, V.sec] = Flow(sections, omega, phi.sec, psi.sec); % Sections
[ang.span, V.span] = Flow(radius, omega, phi.span, psi.span); % Span

%% De Hallers rule: c2/c1 >= 0.72
% DHR = V.sec.rel2 ./ V.sec.rel1;
end