clear All;  % Clean Workspace - Clears all variables from the workspace
close All;  % Close Windows - Closes all open figures
clc;        % Clean Command Window - Clears the contents of the command window

% Define the time vector
t = -10:0.01:10; % Generate a time vector from -10 to 10 with a step of 0.01

% Compute the operations on signals
result_a = signal_x(t) - 2 * signal_y(t);   % Calculate the result of x(t) - 2y(t)
result_b = t .* signal_y(t);                % Calculate the result of t.y(t)
result_c = signal_y(t) .* heaviside(t);     % Calculate the result of y(t).u(t)
result_d = signal_y(-2.*t+3);               % Calculate the result of y(-2t+3)

% Create a new figure for plotting
figure;

% Call the 'plotFig' function to plot the signals and results
plotFig(t, signal_x(t), 1, "x(t)", "b");      % Plot x(t)
plotFig(t, signal_y(t), 2, "y(t)", "r");      % Plot y(t)
plotFig(t, result_a, 3, "x(t) - 2y(t)", "k"); % Plot x(t) - 2y(t)
plotFig(t, result_b, 4, "t . y(t)", "r");     % Plot t . y(t)
plotFig(t, result_c, 5, "y(t).u(t)", "g");    % Plot y(t).u(t)
plotFig(t, result_d, 6, "y(-2t + 3)", "m");   % Plot y(-2t + 3)

%% Define a custom functions

% Define the signal x(t)
function x = signal_x(t)
    x = heaviside(t) - ramp(t-2) + ramp(t-3);
end

% Define the signal y(t)
function y = signal_y(t)
    y = 0.5 * heaviside(t + 1) - 1.5 * heaviside(t) + heaviside(t - 1);
end

% Define the ramp function
function r = ramp(t)
    r = t .* (t >= 0);
end

% Define the plot function
function plotFig(t, signal_t, pos, tit, color)

    % Create a subplot with 6 rows, 1 column, and select the specified subplot position
    subplot(6, 1, pos);

    % Plot the continuous signal with the specified color and line width
    plot(t, signal_t, Color = color, LineWidth = 2);

    % Set the title of the subplot with a dynamic title
    title(sprintf("Continuous signal: %s", tit));

    % Set the y-axis label based on the input title
    ylabel(tit);

    % Set the x-axis label as "t"
    xlabel("t");

    % Enable the grid on the plot
    grid on;

    % End the 'plotFig' function
end
