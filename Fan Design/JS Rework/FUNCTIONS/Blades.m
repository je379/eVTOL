function [blade] = Blades(blade, filepath)
%% Return complete blade structure
% [blade] = Blades(blade)
NUMBEROFSECTIONS = 21;

%% Get blade points from KON_Make_Blade
[blade.s_steps,blade.p_steps,blade.sections,blade.pointspersection,blade.XYZ1,blade.XYZ2] = KON_Make_Blade(blade.sec.chi1,blade.sec.chi2,blade.sec.radius,blade.sec.chord,blade.type,filepath,NUMBEROFSECTIONS);

%% Offset blades
blade.zoffset = blade.z - min(min(squeeze(blade.s_steps(:,3,:))));


end