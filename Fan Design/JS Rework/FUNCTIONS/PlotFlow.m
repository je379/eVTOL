function [] = PlotFlow(rc, rh, radius, sections, phi, psi, psi_ts, delta, R, S, carter, V, ang, omega, reaction)

%% Plot PSI/PHI Distirubutions

x = (radius-rh)./(rc-rh);

%% 3D Plot blades
figure(2); hold on; grid on; box on; axis equal; title('Blade Geometry');
mesh(squeeze(R.XYZ(:,1,:)),squeeze(R.XYZ(:,3,:)),squeeze(R.XYZ(:,2,:)));
mesh(squeeze(S.XYZ(:,1,:)),squeeze(S.XYZ(:,3,:)),squeeze(S.XYZ(:,2,:)));
plot3(S.centerline(:,1,:),S.centerline(:,3,:),S.centerline(:,2,:));

%% Velocity Triangles
figure(1); subplot(1,2,1); title('Blade Sections');
subplot(1,2,2); hold on; axis equal; 
VT_rad = sections(linspace(1,end,3));
dx = 4*V.sec.x(end);
dy = omega.*VT_rad(end);
XSHIFT = [dx dx dx; dx dx dx];
YSHIFT = [-dy 0 dy; -dy 0 dy];
title('Velocity Triangles'); xlim([-.2*dx, 1.5*dx]);
text(dx/2,dy,'CASING');text(dx/2,0,'MID');text(dx/2,-dy,'HUB');

% ROTOR INLET
X1.X(1:2,:)     = [zeros(1,3); V.sec.x(linspace(1,end,3))];
X1.Y(1:2,:)     = [zeros(1,3); zeros(1,3)] + YSHIFT;
plot(X1.X, X1.Y, 'k');

REL1.X(1:2,:)   = [zeros(1,3); V.sec.x(linspace(1,end,3))];
REL1.Y(1:2,:)   = [zeros(1,3); omega.*VT_rad] + YSHIFT;
plot(REL1.X, REL1.Y, 'k');

U1.X(1:2,:)   = [V.sec.x(linspace(1,end,3)); V.sec.x(linspace(1,end,3))];
U1.Y(1:2,:)   = [zeros(1,3); omega.*VT_rad] + YSHIFT;
plot(U1.X, U1.Y, 'k');

% STATOR INLET
X2.X(1:2,:)     = [zeros(1,3); V.sec.x(linspace(1,end,3))] + XSHIFT;
X2.Y(1:2,:)     = [zeros(1,3); zeros(1,3)] + YSHIFT;
plot(X2.X, X2.Y, 'b');

V2.X(1:2,:)   = [zeros(1,3); V.sec.x(linspace(1,end,3))] + XSHIFT;
V2.Y(1:2,:)   = [zeros(1,3); -V.sec.theta2(linspace(1,end,3))] + YSHIFT;
plot(V2.X, V2.Y, 'b');

REL2.X(1:2,:)   = [zeros(1,3); V.sec.x(linspace(1,end,3))] + XSHIFT;
REL2.Y(1:2,:)   = [zeros(1,3); omega.*VT_rad-V.sec.theta2(linspace(1,end,3))] + YSHIFT;
plot(REL2.X, REL2.Y, 'b');

U2.X(1:2,:)   = [V.sec.x(linspace(1,end,3)); V.sec.x(linspace(1,end,3))] + XSHIFT;
U2.Y(1:2,:)   = [-V.sec.theta2(linspace(1,end,3)); omega.*VT_rad-V.sec.theta2(linspace(1,end,3))] + YSHIFT;
plot(U2.X, U2.Y, 'b');

%% PSI/PHI Spanwise Distribution
figure('Position', [0 320 2560 1200]);

subplot(2,6,1);
hold on; title('\phi (Flow Coefficient)'); ylabel('% of Span'); xlabel('\phi');
plot(phi.span,x, 'k');

subplot(2,6,2);
hold on; title('\psi (Total-Total Stage Loading)'); ylabel('% of Span'); xlabel('\psi');
plot(psi.span,x, 'k');

subplot(2,6,3);
hold on; title('\psi_{ts} (Total-Static Stage Loading)'); ylabel('% of Span'); xlabel('\psi_{ts}');
plot(psi_ts.span,x, 'k');

%% Deviation
subplot(2,6,7);
hold on; title('\delta (Deviation)'); ylabel('% of Span'); xlabel('\delta (DEVIATION)');
plot(delta.span.R,x,'b');plot(delta.span.S,x,'r');legend('Rotor','Stator');

%% Pitch-Chord
subplot(2,6,8);
hold on; title('s/l (Pitch-Chord)'); ylabel('% of Span'); xlabel('s/l');
plot(R.span.pitchchord,x);plot(S.span.pitchchord,x);legend('Rotor','Stator');

%% Carter coefficient 'm'
subplot(2,6,9);
hold on; title('m (Carter variable)'); ylabel('% of Span'); xlabel('m');
plot(carter.span.R,x,'b'); plot([carter.span.S carter.span.S],[0 1],'r'); legend('Rotor','Stator');

%% Velocities
subplot(2,6,4);
hold on; title('V_x'); ylabel('% of Span'); xlabel('V / ms^{-1}');
plot(V.span.x,x, 'k');

subplot(2,6,5);
hold on; title('V_{\theta 2}'); ylabel('% of Span'); xlabel('V / ms^{-1}');
plot(V.span.theta2,x, 'k');

subplot(2,6,6);
hold on; title('Reaction'); ylabel('% of Span'); xlabel('Reaction');
plot(reaction.span,x, 'k');

%% Chord
subplot(2,6,10);
hold on; title('Rotor Chord'); ylabel('% of Span'); xlabel('Chord / mm');
plot(R.span.chord * 1000,x, 'k');

%% Flow angles
subplot(2,6,[11 12]);
hold on; title('Rotor exit angles'); ylabel('% of Span'); xlabel('Degrees');
plot(ang.span.b2,x, 'k'); plot(-ang.span.chi2,x, 'b'); legend('\beta_2','\chi_2');

%% CLEAR
clear x;