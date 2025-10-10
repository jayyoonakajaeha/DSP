% 1 - 1) Sinusoidal waves of different amplitudes: f0=1, phi=0, A=1,2,3

t = 0:0.00001:2; % sampling period Ts = 0.00001 s
f0 = 1;
phi = 0;
A = [1,2,3];
figure;
for i = 1:length(A)
    x = A(i) * cos(2*pi*f0*t+phi);
    plot(t,x,'DisplayName',sprintf('A = %d', A(i))); hold on;
end
title('1-1) Sinusoidal waves with different amplitudes: $f_0=1,\ \phi=0,\ A=1,2,3$', 'Interpreter', 'latex');
xlabel('Time (s)'); ylabel('x(t)');
legend show;