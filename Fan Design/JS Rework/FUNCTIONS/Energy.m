function [power, thrust, mass, phi, psi, FOM, P] = Energy(V, phi, psi, radius, omega, rho, rc, rh)
%% Calculate work done, thrust, mass flow
% 

Pa = 1.0125e5;
%% Mass-Av Stagnation Enthaply Rise

global plotflag
% Local constants
dr          = radius(2) - radius(1);

% Stagnation flow
h0          = psi.span .* (omega .* radius) .^ 2;

%% Pressures
P.P2 = h0*rho + Pa - 0.5*rho*V.span.x.^2;
if plotflag == 1
    figure(3); subplot(2,6,12); plot(P.P2, ((radius-rh)./(rc-rh)),'b');
    title('Static Pressure Profile'); ylabel('% of Span'); xlabel('P_{exit}');
end

P.P02 = P.P2 + 0.5*rho.*V.span.x.^2;
P.P01 = P.P02 - rho*h0;
%% Mass Flow
% Mass flow: dm = rho*dA*Vx
mass.dA     = dr .* 2 .* pi .* radius;
mass.dm     = rho .* mass.dA .* V.span.x;
mass.total  = sum(mass.dm);

%% Power and Thrust
% Work
power       = sum(mass.dm .* h0);
thrust      = rho.*sum(mass.dA .* V.span.x.^2 ./ sqrt(phi.span.^2 ./ (2.*psi.span)) );

%% Mass averaged phi and psi
psi.massav  = sum((h0 ./ ((omega .* radius).^2)) .* mass.dm) ./ mass.total;
phi.massav  = sum((V.span.x ./ (omega .* radius)) .* mass.dm) ./ mass.total;

%% Figure of merit
FOM = ( thrust ./ power ) .* sqrt(thrust ./ (2 .* rho .* sum(mass.dA)));
end