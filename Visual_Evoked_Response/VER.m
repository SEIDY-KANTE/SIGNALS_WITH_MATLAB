clear All;  % Clear all variables from the workspace
close All;  % Close all figures
clc;       % Clear the command window

% Get the data from the 'biossinal_1.mat' file
load('biossinal_1.mat');

%% Task 1: Calculate the signal's sampling frequency
sampling_interval = 5e-3; % Define the sampling interval as 5 ms
sampling_frequency = 1 / sampling_interval; % Calculate the sampling frequency
disp(['The signal''s sampling frequency is ' num2str(sampling_frequency) 'Hz']); % Display the sampling frequency

%% TYPICAL FREQUENCY OF THE EEG :
% EEG signals typically have a frequency range of 0.5-100 Hz.

%% RELATIONSHIP BETWEEN  Sampling frequency and Signal's frequency :
% The sampling frequency must be at least double the signal's maximum frequency (Nyquist theorem). 
% The relationship is important because it affects the ability to accurately represent and analyze the signal. 
% A higher sampling frequency allows for better representation of high-frequency components in the signal.

%% Task 2: Calculate and display signal measurements

% Calculate the mean, effective value (RMS), variance, and standard deviation
mean_value = mean(sem_ruido);  % Calculate the mean of the signal
rms_value = rms(sem_ruido);    % Calculate the effective value (RMS) of the signal
variance_value = var(sem_ruido); % Calculate the variance of the signal
std_value = std(sem_ruido);      % Calculate the standard deviation of the signal

% Display the signal measurements
fprintf('========Signal''s measurements:==========\n');
disp(['Mean of sem_ruido    : ' num2str(mean_value)]);
disp(['Effective Value (RMS): ' num2str(rms_value)]);
disp(['Variance of sem_ruido: ' num2str(variance_value)]);
disp(['± Standard Deviation : ' num2str(std_value)]);

fprintf('\n');

% Plot the signal
N=length(sem_ruido);
time=(1:N)/sampling_frequency;
% figure("WindowState","maximized"); % Create a maximized figure
figure; % Create a figure
subplot(4,1,1); % Create a subplot with 4 rows and 1 column, select the first subplot
plot(time,sem_ruido,'LineWidth', 2); % Plot the signal with a specified line width
xlabel('Time (s)'); % Set the x-axis label
ylabel('Amplitude (a.u.)'); % Set the y-axis label
title('Visual Evoked Response (REV) Signal'); % Set the title of the plot
hold on; % Enable holding the plot for additional lines
% Plot lines representing mean, RMS, variance, standard deviation, and their values
plot([time(1) time(end)], [std_value+mean_value, std_value+mean_value], '--k','LineWidth', 1);
plot([time(1) time(end)], [-std_value+mean_value, -std_value+mean_value], '--k','LineWidth', 1);
% plot([time(1) time(end)], [std_value, std_value], '--k','LineWidth', 1);
plot([time(1) time(end)], [mean_value, mean_value], '--g','LineWidth', 1);
plot([time(1) time(end)], [rms_value, rms_value], '--b','LineWidth', 1);
plot([time(1) time(end)], [variance_value, variance_value], '--r','LineWidth', 1);

% Create a legend to label different lines
legend({"Signal"," ± Standard deviation","","Mean","RMS","Variance"},"Location","bestoutside");
legend("boxoff")

%% Assuming biossinal contains the multiple individual evoked responses

% Define the number of responses to be averaged
response_counts = [25, 100, 1000]; 

% Calculate the length of the signal and sampling frequency
N = length(biossinal);  % 100
sampling_interval = 5e-3; % Sampling interval is 5 ms
sampling_frequency = 1 / sampling_interval;

% Create time axis
time = (0:N-1) * sampling_interval;

% Initialize a cell array to store averaged responses for different counts
averaged_responses = cell(1, length(response_counts));

% Loop through different response counts
for i = 1:length(response_counts)
    numResponses = response_counts(i); % Number of responses for this iteration

    % Divide the signal into segments of 100 points each
    segment_size = 100;
    num_segments = floor(N / segment_size);
    segmented_responses = zeros(segment_size, num_segments);

    % Segment the signal
    for j = 1:num_segments
        segment_start = (j - 1) * segment_size + 1;
        segment_end = j * segment_size;
        segmented_responses(:, j) = biossinal(segment_start:segment_end);
    end

    % Compute mean of each segment across responses
    averaged_segments = mean(segmented_responses, 2);

    % Store the averaged response
    averaged_responses{i} = averaged_segments;

    % Dipslay
    disp(['Ensemble Averaging with ' num2str(numResponses) ' responses:']);
    disp(['   Mean: ' num2str(mean(averaged_responses{i}))]);

    % Plot ensemble averaging measurements
    subplot(length(response_counts)+1, 1, i+1);
    plot(time(1:segment_size),averaged_segments, 'b-', 'LineWidth', 2); % Plot the averaged response
    hold on;
    plot(time(1:segment_size), sem_ruido, 'r--', 'LineWidth', 2); % Plot the simulated REV signal
    legend('Ensemble Averaging', 'Simulated REV');
    xlabel('Time (s)');
    ylabel('Amplitude (a.u.)');
    title(['Ensemble Averaging of Visual Evoked Responses (REV) with ' num2str(numResponses) ' responses']);
end

%% COMMENT:
% Regardless of the number of responses used for ensemble averaging (25, 100, or 1000), 
% the mean value of the resulting averaged response remains consistent at around -0.10213. 
% This suggests that the ensemble averaging process is stable and produces a consistent outcome for different response counts.
