function [] = Blades()
%% Return blade points from KONMakeBlade
% [] = Blades()


[r_s_steps,r_p_steps,r_sections,r_pointspersection,r_XYZ1,r_XYZ2]= KON_Make_Blade(chi1_rotor,chi2_rotor,R_rotor,c_rotor,'rotor',file_name{n1});    
[s_s_steps,s_p_steps,s_sections,s_pointspersection,s_XYZ1,s_XYZ2]= KON_Make_Blade(chi1_stator,chi2_stator,R_stator,c_stator,'stator',file_name{n1});