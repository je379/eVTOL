function [phidist, psidist, psi_tsdist] = Distributions(p, phi, psi, r,rm)
%% Return coefficient distributions based on vortex design choice
% 'p' is a string = 'free', 'forced', 'constangle'

switch p
    case 'free'
        % Distributed values
        psidist        = psi.m .* (rm ./ r) .^ 2;
        phidist        = phi.m .* (rm ./ r);
        psi.p = 0;
    case 'custom'
        % Distributed values
        psidist        = psi.m .* (rm ./ r) .^ 1.1;
        phidist        = phi.m .* (rm ./ r);
        psi.p = 1.1;
    case 'forced'
        % Distributed values
        psidist        = psi.m .* r .^ 0;
        phidist        = phi.m .* (rm ./ r);
        psi.p = 0;
    case 'constangle'
        % Solution of form phi = phi.m.*r^(-B/A)
        A = 1 + (psi.m/phi.m).^2; B = 1 + 2*(psi.m/phi.m).^2;
        % Distributed
        phidist = phi.m .* (rm ./ r) .^ (B/A);
        psidist = psi.m .* (rm ./ r) .^ (B/A);
        psi.p = B/A;
end

psi_tsdist      = 2.*psidist - phidist.^2;
end