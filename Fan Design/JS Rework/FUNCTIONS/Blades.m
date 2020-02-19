function [blade] = Blades(blade, filepath)
%% Return complete blade structure
% [blade] = Blades(blade)
NUMBEROFSECTIONS = 21;

%% Get blade points from KON_Make_Blade
[blade.s_steps,blade.p_steps,blade.sections,blade.pointspersection,blade.XYZ1,blade.XYZ2] = KON_Make_Blade(blade.sec.chi1,blade.sec.chi2,blade.sec.radius,blade.sec.chord,blade.type,filepath,NUMBEROFSECTIONS);

%% Offset blades
blade.zoffset = blade.z - min(min(squeeze(blade.s_steps(:,3,:))));

%% Sweep and Lean Offsets
% Set distribution and apply in y and z directions

% tipangle = 10;
% leangle = 40;
% 
% % Tip offset ('winglet', y direction)
% dtips = (r_c/5)*tan(2*pi*tipangle/360);
% pv = polyfit([0 0.15 0.25 0.45 0.65 1],[0 dtips*(0.15/0.65) dtips*(0.25/0.65) dtips*(0.45/0.65) dtips 0],5);
% dtips_offset = 0.8*polyval(pv,linspace(0,1,21));
% 
% % Leading edge offset (z direction)
% %     dle = (r_c/8)*tan(2*pi*leangle/360);
% %     p = polyfit([0 0.1 0.2 0.3 0.5 0.7 0.8 0.9 1],[-0.2*dle 0.2*dle 0.5*dle 0.6*dle 0.65*dle 0.6*dle 0.5*dle 0.2*dle -0.3*dle],5);
% dle = 1.25*(r_c/5)*tan(2*pi*tipangle/360);
% pv = polyfit([0 0.25 0.45 0.6 0.85 1],[0 dle*(0.15/0.65) dle*(0.25/0.65) dle*(0.45/0.65) dle 0],5);
% dle_offset = polyval(pv,linspace(0,1,21));
% switch p
%     case 1
%         % MID- FREE AND FORCE VORTEX
%         dle_offset = polyval(pv,linspace(0,1,21));
%     case 2
%         % FREE VORTEX
%         dle_offset = linspace(-13e-3, 5e-3,21) + polyval(pv,linspace(0,1,21));
% end
% 
% % Set sweep and lean offsets
% %     zroffset = rotor_offset*ones([1,21]) + dle_offset; 
% %     yroffset = -dtips_offset;
% zroffset = rotor_offset*ones([1,21]);
% yroffset = zeros([1,21]);
% % Plot sweep and lean curves
% figure(11); plot(linspace(r_h,r_c,21),dtips_offset); axis equal; title('Tip Offset');
% figure(10); plot(linspace(r_h,r_c,21),dle_offset); axis equal; title('Leading Edge Offset');
% 
% for stepi = 1:21
% %     disp(stator_offset);
%     r_s_steps(:,3,stepi)  = zroffset(stepi) + r_s_steps(:,3,stepi);
%     r_p_steps(:,3,stepi)  = zroffset(stepi) + r_p_steps(:,3,stepi);
% 
%     r_s_steps(:,2,stepi)  = r_s_steps(:,2,stepi) + yroffset(stepi);
%     r_p_steps(:,2,stepi)  = r_p_steps(:,2,stepi) + yroffset(stepi);
% 
%     r_XYZ1(:,3,stepi)    = zroffset(stepi) + r_XYZ1(:,3,stepi);
%     r_XYZ2(:,3,stepi)    = zroffset(stepi) + r_XYZ2(:,3,stepi);
% 
%     r_XYZ1(:,2,stepi)    = r_XYZ1(:,2,stepi) + yroffset(stepi);
%     r_XYZ2(:,2,stepi)    = r_XYZ2(:,2,stepi) + yroffset(stepi);
% 
% end
% 
% s_s_steps(:,3,:)  = stator_offset + s_s_steps(:,3,:);
% s_p_steps(:,3,:)  = stator_offset + s_p_steps(:,3,:);
% 
% s_XYZ1(:,3,:)    = stator_offset + s_XYZ1(:,3,:);
% s_XYZ2(:,3,:)    = stator_offset + s_XYZ2(:,3,:) ;
% 
% nose=0;
%     
% %% IBL
% % Concatenate PS & SS
% 
% for i = 1:size(r_XYZ1,3)
%     r_XYZ(:,:,i) = [r_XYZ1(:,:,i);r_XYZ2(:,:,i)] * 1000; % mm
%     s_XYZ(:,:,i) = [s_XYZ1(:,:,i);s_XYZ2(:,:,i)] * 1000; % mm
% end
% 
% % Get centerline values
% % MAKE ZOFFSET A FUNCTION OF R
% zoffset = stator_offset*ones([1,21]);
% 
% load('sectionlocation.mat');
% figure(3); plot3(sectionlocation,shiftvary,zoffset);
% centerline = [sectionlocation.',shiftvary.',zoffset.'].*1000;
% 
% % Write .ibl in X,Y,Z (STATOR)
% pathname    = [pwd, '/IBL'];
% statorfile  = fullfile(pathname, 'Stator.ibl');
% rotorfile   = fullfile(pathname,'Rotor.ibl');
% statorcenterlinefile = fullfile(pathname,'CenterLine.ibl');
% 
% fid = fopen(statorfile, 'w');
% fprintf(fid,'Closed Index arclength\n');
% for ss = 1:size(s_XYZ,3)
%      fprintf(fid,'begin section\n');
%      fprintf(fid,'begin curve\n');
%      for pp = 1:size(s_XYZ,1)
%          fprintf(fid,'%f  %f  %f\n', s_XYZ(pp,1,ss),s_XYZ(pp,2,ss),s_XYZ(pp,3,ss));
%      end
% end
% 
% fclose(fid);
% 
% % Write .ibl in X,Y,Z (ROTOR)
% fid = fopen(rotorfile, 'w');
%  
% fprintf(fid,'Closed Index arclength\n');
% for ss = 1:size(r_XYZ,3)
%      fprintf(fid,'begin section\n');
%      fprintf(fid,'begin curve\n');
%      for pp = 1:size(r_XYZ,1)
%          fprintf(fid,'%f  %f  %f\n', r_XYZ(pp,1,ss),r_XYZ(pp,2,ss),r_XYZ(pp,3,ss));
%      end
% end
% 
% fclose(fid);
% 
% fid = fopen(statorcenterlinefile, 'w');
% fprintf(fid,'Closed Index arclength\n');
% fprintf(fid,'begin section\n');
% fprintf(fid,'begin curve\n');
% for ss = 1:size(centerline,1)
%      fprintf(fid,'%f  %f  %f\n', centerline(ss,1),centerline(ss,2),centerline(ss,3));
% end
% fclose(fid);
end