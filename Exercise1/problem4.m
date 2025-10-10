% 4. Draw the waveforms of the sinusoidal signal mixed with noises

t = 0:0.00001:2; % sampling period Ts = 0.00001 s
s = cos(2*pi*t);
sigma_s = std(s);
fprintf('Standard deviation of the signal (sigma_s): %f\n', sigma_s);
disp('----------------------------------------------------');


% --- Uniform White Noise ---
SNR_uniform = 15;
n_uniform = rand(size(t)) - 0.5;
sigma_n_uniform = std(n_uniform);
a_uniform = (sigma_s / sigma_n_uniform) / (10^(SNR_uniform/20));
fprintf('Standard deviation of Uniform Noise (sigma_n_uniform): %f\n', sigma_n_uniform);
fprintf('Noise magnitude of Uniform Noise (a_uniform): %f\n', a_uniform);

x_uniform = s + a_uniform * n_uniform;

figure(1);
plot(t, x_uniform, 'b', 'DisplayName', 'Noisy Signal x(t)');
hold on;
plot(t, s, 'r--', 'LineWidth', 1.5, 'DisplayName', 'Original Signal s(t)');
hold off;
title_string = sprintf('Signal with Zero-Mean Uniform White Noise (SNR = 15 dB, $\\sigma_n$ = %.4f, magnitude a = %.4f)',sigma_n_uniform,a_uniform);
title(title_string,'Interpreter','latex');
xlabel('Time (t)');
ylabel('x(t)');
legend;
grid on;
axis([0 2 -2 2]);


% --- White Gaussian Noise ---
disp('----------------------------------------------------');
SNR_gaussian = 10;
n_gaussian = randn(size(t));
sigma_n_gaussian = std(n_gaussian);
a_gaussian = (sigma_s / sigma_n_gaussian) / (10^(SNR_gaussian/20));
fprintf('Standard deviation of Gaussian Noise (sigma_n_gaussian): %f\n', sigma_n_gaussian);
fprintf('Noise magnitude of Gaussian Noise (a_gaussian): %f\n', a_gaussian);

x_gaussian = s + a_gaussian * n_gaussian;

figure(2);
plot(t, x_gaussian, 'b', 'DisplayName', 'Noisy Signal x(t)');
hold on;
plot(t, s, 'r--', 'LineWidth', 1.5, 'DisplayName', 'Original Signal s(t)');
hold off;
title_string = sprintf('Signal with Zero-Mean White Gaussian Noise (SNR = 15 dB, $\\sigma_n$ = %.4f, magnitude a = %.4f)',sigma_n_gaussian,a_gaussian);
title(title_string,'Interpreter','latex');
xlabel('Time (t)');
ylabel('x(t)');
legend;
grid on;
axis([0 2 -2 2]);