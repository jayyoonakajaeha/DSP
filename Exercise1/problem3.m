% 3. Draw the waveforms of the following signals in the range -10<=n<=10

n = -10:10;
figure;

% --- Subplot 1: Impulse Signal δ[n] ---
% The impulse is 1 only when n=0, and 0 otherwise.
impulse = (n == 0);
subplot(2, 2, 1);
stem(n, impulse, 'filled');
title('1) Impulse: \delta[n]');
xlabel('n');
ylabel('Amplitude');
grid on;

% --- Subplot 2: Shifted Step Signal u[n+5] ---
% The unit step u[k] is 1 for k>=0.
% So, u[n+5] is 1 when (n+5)>=0, which means n>=-5.
step_shifted = (n >= -5);
subplot(2, 2, 2);
stem(n, step_shifted, 'filled');
title('2) Step: u[n+5]');
xlabel('n');
ylabel('Amplitude');
grid on;

% --- Subplot 3: Rectangular Signal rect[n/8] ---
% The rectangular function rect(x) is 1 for |x|<=0.5.
% So, rect[n/8] is 1 when |n/8|<=0.5, which means |n|<=4.
rect_signal = (abs(n) <= 4);
subplot(2, 2, 3);
stem(n, rect_signal, 'filled');
title('3) Rectangular: rect[$\frac{n}{8}$]','Interpreter','latex');
xlabel('n');
ylabel('Amplitude');
grid on;

% --- Subplot 4: Sinc Signal sinc(n/3) ---
% Use the built-in sinc function.
% sinc(x) = sin(pi*x) / (pi*x)
sinc_signal = sinc(n/3);
subplot(2, 2, 4);
stem(n, sinc_signal, 'filled');
title('4) Sinc: sinc($\frac{n}{3}$)','Interpreter','latex');
xlabel('n');
ylabel('Amplitude');
grid on;

sgtitle('3. The waveforms of the signals in the range $-10\le n \le 10$','Interpreter','latex');