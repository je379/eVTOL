function [angle, V] = Flow(r, omega, phi, psi)

% Return velocities
V.x         = (r .* omega) .* phi;
V.theta2    = (r .* omega) .* psi;
V.rel1      = sqrt((r.*omega) .^ 2 + V.x .^ 2);

% Return flow angles
angle.a1    = 0;
angle.b1    = atand(-omega .* r ./ V.x);
angle.a2    = atand(V.theta2 ./ V.x);
angle.b2    = atand((V.theta2 - r .* omega) ./ V.x);
angle.a3    = 0;
angle.b3    = 0;
angle.i1    = 0;
angle.i3    = 0;

% Other velocities
V.abs1      = V.x ./ cosd(angle.a1);
V.abs2      = V.x ./ cosd(angle.a2);
V.rel2      = V.x ./ cosd(angle.b2);
end