%% MATLAB Exercise 2 - STFT Time–Frequency Tradeoff
% 인공지능학과 21012010 윤재하
clear; close all; clc;

fs = 16000;
t = 0:1/fs:5;
duration = max(t);
x_clean = sin(2*pi*500*t) + 0.7*sin(2*pi*1200*t) + 0.6*chirp(t,1000,5,4000);

% Add Gaussian noise (SNR ~ 20 dB)
SNR_dB = 20;
signal_power = mean(x_clean.^2);
noise_power = signal_power / (10^(SNR_dB/10));
x = x_clean + sqrt(noise_power)*randn(size(x_clean));

fprintf('Signal: duration=%.2f s, fs=%d Hz, samples=%d\n', duration, fs, length(t));

%% Prepare containers to compute ALL STFTs first (so we can get global caxis)
allP = {};   % store P (dB) matrices
allF = {};   % corresponding F vectors
allT = {};   % corresponding T vectors
labels = {}; % text labels for each stored spectrogram (for plotting later)

%% Part A: Window Lengths
L_values = [256, 1024, 4096];
overlap_ratio = 0.5;
resultsA = zeros(length(L_values),6);

for i = 1:length(L_values)
    L = L_values(i);
    ov = round(L * overlap_ratio);
    win = rectwin(L);

    tic;
    [S,F,T] = stft(x, fs, 'Window', win, 'OverlapLength', ov, 'FFTLength', L);
    runtime = toc;

    P = 20*log10(abs(S));
    allP{end+1} = P;
    allF{end+1} = F;
    allT{end+1} = T;
    labels{end+1} = sprintf('Part A: Rect, L=%d', L);

    resultsA(i,:) = [L, overlap_ratio, fs/L, (L-ov)/fs, length(T), runtime];
end

%% Part B: Overlaps (L fixed = 1024)
L = 1024;
overlap_ratios = [0, 0.5, 0.75, 0.875];
resultsB = zeros(length(overlap_ratios),6);

for i = 1:length(overlap_ratios)
    ratio = overlap_ratios(i);
    ov = round(L * ratio);
    win = rectwin(L);

    tic;
    [S,F,T] = stft(x, fs, 'Window', win, 'OverlapLength', ov, 'FFTLength', L);
    runtime = toc;

    P = 20*log10(abs(S));
    allP{end+1} = P;
    allF{end+1} = F;
    allT{end+1} = T;
    labels{end+1} = sprintf('Part B: Rect, Overlap=%.1f%%', ratio*100);

    resultsB(i,:) = [L, ratio, fs/L, (L-ov)/fs, length(T), runtime];
end

%% Part C: Window types (L=1024, overlap=50%)
L = 1024; ov = round(L*0.5);
win_list = {'rectwin','hamming','hann'};
resultsC = cell(length(win_list),7);

for i = 1:length(win_list)
    winfun = str2func(win_list{i});
    win = winfun(L);

    tic;
    [S,F,T] = stft(x, fs, 'Window', win, 'OverlapLength', ov, 'FFTLength', L);
    runtime = toc;

    P = 20*log10(abs(S));
    allP{end+1} = P;
    allF{end+1} = F;
    allT{end+1} = T;
    labels{end+1} = sprintf('Part C: %s', upper(win_list{i}));

    resultsC{i,1} = upper(win_list{i});
    resultsC{i,2} = L;
    resultsC{i,3} = 0.5;
    resultsC{i,4} = fs/L;
    resultsC{i,5} = (L-ov)/fs;
    resultsC{i,6} = length(T);
    resultsC{i,7} = runtime;
end

%% Part D: Zero padding (L=1024, overlap=50%, Nfft=1024 & 4096)
L = 1024; ov = round(L*0.5); win = hamming(L);
Nfft_values = [1024, 4096];
resultsD = zeros(length(Nfft_values),7);

for i = 1:length(Nfft_values)
    Nfft = Nfft_values(i);

    tic;
    [S,F,T] = stft(x, fs, 'Window', win, 'OverlapLength', ov, 'FFTLength', Nfft);
    runtime = toc;

    P = 20*log10(abs(S));
    allP{end+1} = P;
    allF{end+1} = F;
    allT{end+1} = T;
    labels{end+1} = sprintf('Part D: NFFT=%d', Nfft);

    resultsD(i,:) = [Nfft, L, 0.5, fs/Nfft, (L-ov)/fs, length(T), runtime];
end

%% Determine global color scale and axis limits
maxVals = cellfun(@(p) max(p(:)), allP);
global_max = max(maxVals);

% Use fixed dynamic range (70 dB window)
cmax = global_max;
cmin = cmax - 70;

% Frequency axis limits and time limits
freq_lim = [0, fs/2];
time_lim = [0, duration];

fprintf('Global color scale: [%.1f, %.1f] dB (cmin, cmax)\n', cmin, cmax);
%% Plots
plotIdx = 1;

% Part A plots
figure('Name','Part A - Spectrograms','NumberTitle','off');
for i = 1:length(L_values)
    P = allP{plotIdx}; F = allF{plotIdx}; T = allT{plotIdx}; lbl = labels{plotIdx};
    mask = F >= 0;
    subplot(length(L_values),1,i);
    surf(T, F(mask), P(mask,:), 'EdgeColor', 'none');
    view(0,90); axis tight;
    ylim(freq_lim); xlim(time_lim);
    colormap jet; caxis([cmin cmax]);
    xlabel('Time (s)'); ylabel('Frequency (Hz)');
    title(lbl);
    c=colorbar;
    c.Label.String = 'Magnitude (dB)';
    plotIdx = plotIdx + 1;
end

% Part B plots
figure('Name','Part B - Spectrograms','NumberTitle','off');
for i = 1:length(overlap_ratios)
    P = allP{plotIdx}; F = allF{plotIdx}; T = allT{plotIdx}; lbl = labels{plotIdx};
    mask = F >= 0;
    subplot(length(overlap_ratios),1,i);
    surf(T, F(mask), P(mask,:), 'EdgeColor', 'none');
    view(0,90); axis tight;
    ylim(freq_lim); xlim(time_lim);
    colormap jet; caxis([cmin cmax]);
    xlabel('Time (s)'); ylabel('Frequency (Hz)');
    title(lbl);
    c=colorbar;
    c.Label.String = 'Magnitude (dB)';
    plotIdx = plotIdx + 1;
end

% Part C plots
figure('Name','Part C - Spectrograms','NumberTitle','off');
for i = 1:length(win_list)
    P = allP{plotIdx}; F = allF{plotIdx}; T = allT{plotIdx}; lbl = labels{plotIdx};
    mask = F >= 0;
    subplot(length(win_list),1,i);
    surf(T, F(mask), P(mask,:), 'EdgeColor', 'none');
    view(0,90); axis tight;
    ylim(freq_lim); xlim(time_lim);
    colormap jet; caxis([cmin cmax]);
    xlabel('Time (s)'); ylabel('Frequency (Hz)');
    title(lbl);
    c=colorbar;
    c.Label.String = 'Magnitude (dB)';
    plotIdx = plotIdx + 1;
end

% Part D plots
figure('Name','Part D - Spectrograms','NumberTitle','off');
for i = 1:length(Nfft_values)
    P = allP{plotIdx}; F = allF{plotIdx}; T = allT{plotIdx}; lbl = labels{plotIdx};
    mask = F >= 0;
    subplot(length(Nfft_values),1,i);
    surf(T, F(mask), P(mask,:), 'EdgeColor', 'none');
    view(0,90); axis tight;
    ylim(freq_lim); xlim(time_lim);
    colormap jet; caxis([cmin cmax]);
    xlabel('Time (s)'); ylabel('Frequency (Hz)');
    title(lbl);
    c=colorbar;
    c.Label.String = 'Magnitude (dB)';
    plotIdx = plotIdx + 1;
end

%% Display Summary Tables
disp('--- Part A Summary Table ---');
disp(array2table(resultsA, 'VariableNames',{'L','OverlapRatio','Δf','Δt','NumFrames','Runtime_s'}));

disp('--- Part B Summary Table ---');
disp(array2table(resultsB, 'VariableNames',{'L','OverlapRatio','Δf','Δt','NumFrames','Runtime_s'}));

disp('--- Part C Summary Table ---');
disp(cell2table(resultsC, 'VariableNames',{'Window','L','OverlapRatio','Δf','Δt','NumFrames','Runtime_s'}));

disp('--- Part D Summary Table ---');
disp(array2table(resultsD, 'VariableNames',{'FFTLength','L','OverlapRatio','Δf','Δt','NumFrames','Runtime_s'}));
%% Report
