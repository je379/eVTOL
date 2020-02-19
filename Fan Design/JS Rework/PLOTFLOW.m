%% Plot PSI/PHI Distirubutions

global phi psi psi_ts rc rh radius delta R S angle V 

x = (radius-rh)./(rc-rh);

%% PSI/PHI Spanwise Distribution
figure('Position', [0 320 2560 500]);

subplot(1,6,1);
hold on; title('\phi (Flow Coefficient)'); ylabel('% of Span'); xlabel('\phi');
plot(phi.span,x, 'k');

subplot(1,6,2);
hold on; title('\psi (Total-Total Stage Loading)'); ylabel('% of Span'); xlabel('\psi');
plot(psi.span,x, 'k');

subplot(1,6,3);
hold on; title('\psi_{ts} (Total-Static Stage Loading)'); ylabel('% of Span'); xlabel('\psi_{ts}');
plot(psi_ts.span,x, 'k');

subplot(1,6,4);
hold on; title('\delta (Deviation)'); ylabel('% of Span'); xlabel('\delta (DEVIATION)');
plot(delta.span.R,x,'b');plot(delta.span.S,x,'r');legend('Rotor','Stator');

subplot(1,6,5);
hold on; title('s/l (Pitch-Chord)'); ylabel('% of Span'); xlabel('s/l');
plot(R.span.pitchchord,x);plot(S.span.pitchchord,x);legend('Rotor','Stator');

subplot(1,6,6);
hold on; title('m (Carter variable)'); ylabel('% of Span'); xlabel('m');
plot(carter.span.R,x,'b'); plot([carter.span.S carter.span.S],[0 1],'r'); legend('Rotor','Stator');

%% Velocities
figure('Position', [0 320 2560 500]);

subplot(1,4,1);
hold on; title('V_x'); ylabel('% of Span'); xlabel('V / ms^{-1}');
plot(V.span.x,x, 'k');

subplot(1,4,2);
hold on; title('V_{\theta 2}'); ylabel('% of Span'); xlabel('V / ms^{-1}');
plot(V.span.theta2,x, 'k');

subplot(1,4,3);
hold on; title('\beta_2'); ylabel('% of Span'); xlabel('Degrees');
plot(angle.span.b2,x, 'k');

subplot(1,4,4);
hold on; title('\chi_2'); ylabel('% of Span'); xlabel('Degrees');
plot(angle.span.chi2,x, 'k');

%% CLEAR
clear x;