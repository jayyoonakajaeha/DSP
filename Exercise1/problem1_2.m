% 1 - 2) Sinusoids with different phases: A=1, f0=1, phi=0,-pi/3,pi/3

t = 0:0.00001:2; % sampling period Ts = 0.00001 s
A = 1;
f0 = 1;
phi = [0,-pi/3,pi/3];
phi_labels = {'$\phi=0$', '$\phi=-\frac{\pi}{3}$', '$\phi=\frac{\pi}{3}$'};
figure;
for i = 1:length(phi)
    x = A * cos(2*pi*f0*t + phi(i));
    plot(t, x, 'DisplayName', phi_labels{i}); hold on;
end
title('1-2) Sinusoids with different phases: $A=1,\ f_0=1,\ \phi=0,-\frac{\pi}{3},\frac{\pi}{3}$', 'Interpreter', 'latex');
xlabel('Time (s)');
ylabel('x(t)');
legend('Interpreter', 'latex', 'Location', 'best');