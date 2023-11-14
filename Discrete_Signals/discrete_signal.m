clear All;  % Clean Workspace - Clears all variables from the workspace
close All;  % Close Windows - Closes all open figures
clc;        % Clean Command Window - Clears the contents of the command window

% fs=5; % Assumed Sampling frequency
% N=50;  % Numbers of points
% t=(-N:N)/fs; % Define the time vector

% Define the time vector 't' from -10 to 10 with a step of 0.2
t = -10:0.2:10;

% Create a discrete signal 'f_discrete' using the cosine function
f_discrete = cos(t);

% Create another discrete signal 'f_discrete_minus_3' by shifting 'f_discrete' by 3 units to the right
f_discrete_minus_3 = cos(t - 3);

% Create a maximized figure window
figure("WindowState","maximized");

% Call the 'plotFig' function to plot 'f_discrete' in the first subplot
plotFig(t, f_discrete, 1, "f(t)", "b");

% End the 'plotFig' function
hold off;

% Call the 'plotFig' function to plot 'f_discrete_minus_3' in the second subplot
plotFig(t, f_discrete_minus_3, 2, "f(t-3)", "r");


%% Define a custom function 'plotFig' to create subplots and plot discrete signals

function plotFig(t, ft, pos, tit, color)

    % Create a subplot with 2 rows, 1 column, and select the specified subplot position
    subplot(2, 1, pos);

    % Plot the discrete signal as stem plots
    stem(t, ft, "filled", Color = color, LineWidth = 1);

    % Set the title of the subplot with a dynamic title
    title(sprintf("Discrete version of %s", tit));

    % Set the y-axis label based on the input title
    ylabel(tit);

    % Set the x-axis label as "t"
    xlabel("t");

    % Enable the grid on the plot
    grid on;

    % End the 'plotFig' function
end
