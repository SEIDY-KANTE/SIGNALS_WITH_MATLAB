clear All; % Clears all variables from the workspace
close All; % Closes all open figures
clc; % Clears the command window

filePath = "data\voices\male\v_male_6.mp3"; % File path for a male voice audio file
% filePath = "voices\female\v_female_1.wav"; % Alternate file path for a female voice audio file

% Load audio signal from a mp3 or .wav file
[signal, fs] = loadAudio(filePath); % Calls the loadAudio function to load the audio file

% Play the audio signal
playAudio(signal, fs); % Calls the playAudio function to play the loaded audio

% Plot the audio signals
plotAudioSignals(signal, fs); % Calls the plotAudioSignals function to plot time domain and power spectrum of the audio signal

% Recognize gender of the speaker
gender = recognizeBinaryGender(signal, fs); % Calls recognizeBinaryGender function to determine the gender of the speaker
fprintf('Gender: %s\n', gender); % Displays the determined gender in the command window


function [signal, fs] = loadAudio(filePath)

    % Loads audio signal from a .wav or .mp3 file
    %
    % Input:
        % filePath: Path to the audio file
    %
    % Output:
        % signal: Audio signal data
        % fs: Sampling frequency of the audio signal

    [signal, fs] = audioread(filePath);
end

function [player] =playAudio(signal, fs)

    % Plays the audio signal using MATLAB's audio player
    %
    % Input:
        % signal: Audio signal data
        % fs: Sampling frequency of the audio signal

    [player] = audioplayer(signal, fs);
    
    player.play;

end

function plotAudioSignals(signal, fs)
    % Plots the imported audio signal in time domain and its power spectrum
    %
    % Input:
        % signal: Audio signal data
        % fs: Sampling frequency of the audio signal
    
    % Time domain plot
    t = 1:length(signal);
    time = t/fs;
    plot(time, signal);
    title('Audio Signal in Time Domain');
    xlabel('Time (s)');
    ylabel('Amplitude');
    
    % Power spectrum plot
    f = (0:length(signal)-1)/fs;
    Pxx = abs(fft(signal)).^2;
    Pxx_db = 20*log10(Pxx);
    plot(f, Pxx_db);
    title('Power Spectrum of Audio Signal');
    xlabel('Frequency (Hz)');
    ylabel('Power Spectral Density (dB)');

end

function gender = recognizeBinaryGender(audio, fs)

    nfft = 2^nextpow2(length(audio));
    audio_fft = fft(audio, nfft);
    power_spectrum = abs(audio_fft).^2 / (fs * length(audio));
    freq = (0:nfft-1) * fs / nfft;

    % Find maximum frequency
    [~, max_idx] = max(power_spectrum); % ~:max_power
    max_freq = freq(max_idx);

    % Calculate distances
    male_distance = abs(125 - max_freq);
    female_distance = abs(200 - max_freq);

    % Determine gender based on distances
    if male_distance <= female_distance
        gender = 'Male';
    else
        gender = 'Female';
    end
end