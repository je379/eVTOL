function [] = Energy()
%% Calculate work done, thrust, mass flow
% 

global radius phi psi omega power thrust mass rho V

%% Mass-Av Stagnation Enthaply Rise

% Local constants
dr          = radius(2) - radius(1);

% Stagnation flow
h0          = psi.span .* (omega .* radius) .^ 2;

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
FOM = ( thrust ./ power ) .* sqrt(thrust ./ (2 .* rho .* sum(mass.dA)))
end