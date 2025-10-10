% 10. Plot the magnitude and phase of the DFT for a step function of length 4 (for N = 64), and unwrap the phase.

N = 64;
x = zeros(1, N);
x(61:64) = 1;
X = fft(x);
f = (-N/2 : N/2-1) / N;

figure;
sgtitle('DFT of a Step Function of Length 4 (N=64)');

subplot(3, 1, 1);
X_mag = abs(X);
X_mag_shifted = fftshift(X_mag);
stem(f, X_mag_shifted, 'filled');
title('Magnitude Spectrum');
xlabel('Normalized Frequency (cycles/sample)');
ylabel('Magnitude');
grid on;

subplot(3, 1, 2);
X_phase_shifted = fftshift(angle(X));
plot(f, X_phase_shifted, '.-');
title('Wrapped Phase Spectrum');
xlabel('Normalized Frequency (cycles/sample)');
ylabel('Phase');
grid on;
yticks([-pi, -pi/2, 0, pi/2, pi]);
yticklabels({'-\pi', '-\pi/2', '0', '\pi/2', '\pi'});

subplot(3, 1, 3);
X_phase_unwrapped = unwrap(X_phase_shifted);
plot(f, X_phase_unwrapped, '.-');
title('Unwrapped Phase Spectrum');
xlabel('Normalized Frequency (cycles/sample)');
ylabel('Phase');
grid on;
yticks([-4*pi, -2*pi, 0, 2*pi, 4*pi,6*pi]);
yticklabels({'-4\pi', '-2\pi', '0', '2\pi', '4\pi','6\pi'});