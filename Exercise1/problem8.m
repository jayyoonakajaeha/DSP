% 8. Approximate a 2pi-periodic square wave using a Fourier series. (Compare all cases when the partial sum order is 1, 3, and 9.)

% Define a time vector(-3pi to 3pi)
t = linspace(-3*pi, 3*pi, 1000);

% The square() function in MATLAB generates a 2pi-periodic square wave.
y_ideal = square(t);

% Initialize the approximation vector
y_approx = zeros(size(t));

y_N1 = [];
y_N3 = [];
% For a symmetric square wave (an odd function), the Fourier series only contains sine terms for odd harmonics (n = 1, 3, 5, ...).
for N = 1:2:9
    y_approx = y_approx + (1/N) * sin(N*t);
    if N == 1
        y_N1 = (4/pi) * y_approx;
    elseif N == 3
        y_N3 = (4/pi) * y_approx;
    end
end
y_N9 = (4/pi) * y_approx;

figure;
hold on;
plot(t, y_ideal, 'b-', 'LineWidth', 2.5, 'DisplayName', 'Ideal Square Wave');
plot(t, y_N1, 'r--', 'LineWidth', 1.5, 'DisplayName', 'Partial Sum Order 1');
plot(t, y_N3, 'y-.', 'LineWidth', 1.5, 'DisplayName', 'Partial Sum Order 3');
plot(t, y_N9, 'g:', 'LineWidth', 1.5, 'DisplayName', 'Partial Sum Order 9');
title('Fourier Series Approximation of a 2\pi-Periodic Square Wave');
xlabel('Time (t)');
ylabel('Amplitude');
grid on;
axis([-8, 8, -1.5, 1.5]);
legend('Location', 'best');
hold off;