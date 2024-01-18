clear All; % Clears all variables from the workspace
close All; % Closes all open figures
clc; % Clears the command window

% Load the audio file
file = 'data\handle_J.WAV';
[y, Fs] = audioread(file); % Reads the audio file and stores the signal in 'y' and the sampling frequency in 'Fs'

% Listen to the audio signal
sound(y, Fs); % Plays the audio signal using MATLAB's sound function

% Task 1: Display power spectrum and signal trace
% Compute power spectrum
N = length(y);
L = N / Fs;
t = (0:N-1) / Fs;
f = Fs*(0:(N/2))/N;
Y = fft(y);
P = abs(Y/N);
P1 = P(1:N/2+1);
P1(2:end-1) = 2*P1(2:end-1);

% Plot power spectrum in relation to time and frequency
figure;
subplot(2,1,1);
plot(t, y);
xlabel('Time (s)');
ylabel('Amplitude');
title('Signal in Time Domain');
subplot(2,1,2);
plot(f, P1);
xlabel('Frequency (Hz)');
ylabel('Power');
title('Power Spectrum');

% Task 2: Identify noise frequencies and design filter(s)
% Analyze the spectrum to identify noise frequencies
% Design and apply a filter to remove noise

frequencies_to_remove = [1000 2000]; % Define frequencies to filter out
bandwidth = 200; % Bandwidth for the filter

% Design band-stop filter
d = designfilt('bandstopiir','FilterOrder',20, ...
               'HalfPowerFrequency1',frequencies_to_remove(1)-bandwidth/2, ...
               'HalfPowerFrequency2',frequencies_to_remove(2)+bandwidth/2, ...
               'DesignMethod','butter','SampleRate',Fs);

% Plot the frequency response of the filter
% fvtool(d, 'Fs', Fs);

% Task 3: Filter the audio signal
y_filtered = filter(d, y); % Apply the designed filter to the audio signal

% Task 4: Listen to the filtered audio signal and calculate power spectrum
sound(y_filtered, Fs); % Play the filtered audio signal using sound function

% Calculate power spectrum of the filtered signal
Y_filtered = fft(y_filtered);
P_filtered = abs(Y_filtered/N);
P1_filtered = P_filtered(1:N/2+1);
P1_filtered(2:end-1) = 2*P1_filtered(2:end-1);

% Plot power spectrum of the filtered signal
figure;
subplot(2,1,1);
plot(t, y_filtered);
xlabel('Time (s)');
ylabel('Amplitude');
title('Filtered Signal in Time Domain');
subplot(2,1,2);
plot(f, P1_filtered);
xlabel('Frequency (Hz)');
ylabel('Power');
title('Power Spectrum of Filtered Signal');
