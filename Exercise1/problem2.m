% 2. For the following signal, draw the waveform of the signal and find energy and power

t = 0:0.00001:2; % sampling period Ts = 0.00001 s
x_t = 3*pi * sin(8*pi*t + 1.3) .* cos(4*pi*t - 0.8) .* exp(sin(12*pi*t));
y_t = x_t .* (t >= 0.2 & t <= 0.7);
figure;
plot(t, y_t);
grid on;
title('Waveform of y(t)');
xlabel('t (seconds)');
ylabel('y(t)');
axis([0 1 -30 30]);

% To find the total energy of y(t), I integrate x(t) only over [0.2, 0.7] because y(t) is zero elsewhere
integrand = @(t) abs(3*pi * sin(8*pi*t + 1.3) .* cos(4*pi*t - 0.8) .* exp(sin(12*pi*t))).^2;
energy = integral(integrand, 0.2, 0.7);
fprintf('The energy of the signal y(t) is: %f\nSince y(t) is finite-support signal, the power of the signal is: 0', energy);