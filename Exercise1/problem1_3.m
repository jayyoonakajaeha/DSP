% 1 - 3) sinusoids with different frequencies: A=1, phi=0, f0=1,2,3

t = 0:0.00001:2; % sampling period Ts = 0.00001 s
A = 1;
phi = 0;
f0 = [1,2,3];
figure;
for i = 1:length(f0)
    x = A * cos(2*pi*f0(i)*t + phi);
    plot(t, x, 'DisplayName', sprintf('$f_0 = %d$', f0(i))); hold on;
end
title('1-3) sinusoids with different frequencies: $A=1,\ \phi=0,\ f_0=1,2,3$', 'Interpreter', 'latex');
xlabel('Time (s)');
ylabel('x(t)');
legend('Interpreter', 'latex', 'Location', 'best');