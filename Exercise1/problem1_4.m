% 1 - 4) discrete sinusoids with different sampling periods: f0=1, phi=0, A=1,2,3

f0 = 1;
phi = 0;
A = [1, 2, 3];
Ts = [0.1, 0.05, 0.025]; % sampling periods (s)
figure;
x_max = 2;
y_max = max(A);
for i = 1:length(A)
    for j = 1:length(Ts)
        subplot(3,3,(i-1)*3 + j); hold on;
        n = 0:100;
        t = n * Ts(j);
        x = A(i) * cos(2*pi*f0*t + phi);
        stem(t, x, 'filled');
        title(sprintf('A=%d, Ts=%.3f s', A(i), Ts(j)));
        xlabel('Time (s)');
        ylabel('x[n]');
        xlim([0, x_max]);
        ylim([-y_max, y_max]);
    end
end