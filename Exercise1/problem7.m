% 7. Plot the comparison results showing the following two cases.

fs = 1000; % Sampling frequency
N = 1024;  % Number of points (FFT length)

% --- Case 1: Constant (Sinusoid) in Time <=> Spike in Frequency ---
figure(1);
sgtitle('Case 1: Time-Constant <=> Frequency-Spike');

% Time Domain Plot
t = (0:N-1)/fs; % Time vector
s1 = ones(size(t)); % Time-domain constant signal

subplot(2, 1, 1);
plot(t, s1);
title('Time Domain: Constant Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;
xlim([0 0.1]); 

% Frequency Domain Plot

% Compute the Fourier Transform of a constant signal.
% The result in the frequency domain is a single spike.
S1 = fft(s1);
f = (-N/2:N/2-1)*(fs/N); 
% Normalize, shift the spectrum to be centered at 0
S1_mag = abs(fftshift(S1))/N; 

subplot(2, 1, 2);
stem(f, S1_mag, 'filled');
title('Frequency Domain: Single-Frequency Spike');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
grid on;
xlim([-20 20]);

% --- Case 2: Impulse in Time <=> Flat in Frequency ---
figure(2);
sgtitle('Case 2: Time-Impulse <=> Frequency-Flat');

% Time Domain Plot
n = -N/2:N/2-1; % Discrete time vector
s2 = (n == 0); % Impulse signal (1 at n=0, 0 otherwise)

subplot(2, 1, 1);
stem(n, s2, 'filled');
title('Time Domain: Impulse Signal');
xlabel('n (sample)');
ylabel('Amplitude');
grid on;
xlim([-20 20]);

% Frequency Domain Plot

% Compute the Fourier Transform of a single spike.
% The result in the frequency domain is a flat spectrum.
S2 = fft(s2);
f = (-N/2:N/2-1)*(fs/N);
% Normalize and shift
S2_mag = abs(fftshift(S2));

subplot(2, 1, 2);
plot(f, S2_mag);
title('Frequency Domain: Flat Spectrum');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
grid on;
ylim([0 2]);