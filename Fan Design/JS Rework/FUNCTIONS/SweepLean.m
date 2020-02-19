function [offset] = SweepLean(blade)
%% Return offset vectors fro sweep and lean profiles
% [offset] = SweepLean(blade, parameter)

global p

%% Sweep and Lean Offsets
% Set distribution and apply in y and z directions

tipangle = blade.sweep;
leangle = blade.lean;

% Tip offset ('winglet', y direction)
dtips = (blade.sec.radius(end)/5)*tan(2*pi*tipangle/360);
pv = polyfit([0 0.15 0.25 0.45 0.65 1],[0 dtips*(0.15/0.65) dtips*(0.25/0.65) dtips*(0.45/0.65) dtips 0],5);
dy_offset = 0.8*polyval(pv,linspace(0,1,21));

% Leading edge offset (z direction)
dle = 1.25*(blade.sec.radius(end)/5)*tan(2*pi*tipangle/360);
pv = polyfit([0 0.25 0.45 0.6 0.85 1],[0 dle*(0.15/0.65) dle*(0.25/0.65) dle*(0.45/0.65) dle 0],5);
dz_offset = polyval(pv,linspace(0,1,21));

switch p
    case 'constangle'
        % MID- FREE AND FORCE VORTEX
        dz_offset = polyval(pv,linspace(0,1,21));
    case 'free'
        % FREE VORTEX
        dz_offset = linspace(-13e-3, 5e-3,21) + polyval(pv,linspace(0,1,21));
end

% Set sweep and lean offsets
offset.z = blade.zoffset*ones([1,21]) + dz_offset; 
offset.y = -dy_offset;

% offset.z = rotor_offset*ones([1,21]);
% offset.y = zeros([1,21]);


end