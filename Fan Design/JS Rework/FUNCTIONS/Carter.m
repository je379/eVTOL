function [angle, V, R, S, delta, carter] = Carter(angle, V)
% Return angles and velocities based on carters rule
DF.m = 0.45; % Diffusion Factor

% Carter's rule
R.m = 0.23 - angle.b2 ./ 500;
S.m = 0.23;

% Pitch to chord
R.pitchchord = (DF.m - (1 - (V.rel2 ./ V.rel1))) ./ (V.theta2 ./ (2.*V.rel1));
S.pitchchord = (DF.m - (1 - (V.x ./ V.abs2))) ./ (V.theta2 ./ (2.*V.abs2));

% Metal angles
angle.chi1 = abs(angle.b1)+angle.i1;
angle.chi2 = (-angle.b2 - abs(angle.chi1) .* R.m .* R.pitchchord .^ (0.5)) ./ (1 - R.m.*R.pitchchord.^(0.5));
angle.chi3 = angle.a2+angle.i3;
angle.chi4 = (abs(angle.a3) - abs(angle.chi3) .* S.m .* S.pitchchord .^ (0.5)) ./ (1 - S.m.*S.pitchchord.^(0.5));

% Deviation
delta.S = angle.chi4 - abs(angle.a3);
delta.R = angle.chi2 - abs(angle.b2);

% Limit deviation
%delta.S(delta.S > 0) = -10; delta.S(delta.S < -10) = -10;
%delta.R(delta.R > 0) = -10; delta.R(delta.R < -10) = -10;
delta.R = linspace(1,0.75,length(delta.R)) .* delta.R;
if max(abs(delta.R)) > 15
    delta.R = -5*ones(size(delta.R));
end
% Recalculate exit angle
angle.chi2 = abs(angle.b2) + delta.R;
angle.chi4 = abs(angle.a3) + delta.S;

carter.S = S.m;
carter.R = R.m;

R.delta = delta.R;
S.delta = delta.S;
end
