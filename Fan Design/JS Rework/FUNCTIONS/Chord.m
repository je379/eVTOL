function [blade] = Chord(blade, radius, sections)
%% Return chord distribution and number of blades
% 

global rc rh rm AR

% Midline chord
blade.lmid        = (rc - rh)./AR;

% Midline pitch
blade.smid        = blade.lmid .* blade.m.sl;

% Blade number
blade.N         = 2 * pi * rm ./ blade.smid;

% Spanwise pitch
blade.sec.s         = 2*pi .* sections ./ blade.N;
blade.span.s         = 2*pi .* radius ./ blade.N;

% Spanwise chord
blade.sec.l         = blade.sec.s ./ blade.sec.sl;
blade.span.l         = blade.span.s ./ blade.span.sl;

blade.sl = blade.m.sl;
end