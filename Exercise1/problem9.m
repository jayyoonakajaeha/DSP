% 9. Implement the discrete Fourier transform (DFT) yourself and compare it to the fft fucntion.

function X = DFT(x)
    N = length(x);
    X = complex(zeros(1,N));
    for k = 0:N-1
        for n = 0:N-1
            X(k+1) = X(k+1) + x(n+1) * exp(-1j*2*pi*n*k/N);
        end
    end
end

fs = 1000;
N = 1024;
t = (0:N-1)/fs;
x = (abs(t) <= 0.05);
tic;
X_dft = DFT(x);
time_dft = toc;
tic;
X_fft = fft(x);
time_fft = toc;
f = (-N/2:N/2-1)*(fs/N);

fs = 1000;
N = 4096;
t = (0:N-1)/fs;
x = (abs(t) <= 0.05);
tic;
X_dft = DFT(x);
time_dft_4096 = toc;
tic;
X_fft = fft(x);
time_fft_4096 = toc;
f = (-N/2:N/2-1)*(fs/N);

fprintf('Computation Time of DFT when N=1024: %f\n',time_dft)
fprintf('Computation Time of FFT when N=1024: %f\n',time_fft)
fprintf('Computation Time of DFT when N=4096: %f\n',time_dft_4096)
fprintf('Computation Time of FFT when N=4096: %f\n',time_fft_4096)

difference = max(abs(X_dft - X_fft));
fprintf('Maximum difference between the two results: %e\n', difference)

figure;
subplot(2,1,1);
stem(f, fftshift(abs(X_dft))/N, 'filled');
title('Magnitude of my DFT');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
xlim([-50 50]);

subplot(2,1,2);
stem(f, fftshift(abs(X_fft))/N, 'filled');
title('Magnitude of MATLAB''s FFT');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
xlim([-50 50]);
sgtitle('DFT of a Rectangular Pulse');
