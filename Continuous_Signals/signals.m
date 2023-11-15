clear All;  % Clean Workspace - Clears all variables from the workspace
close All;  % Close Windows - Closes all open figures
clc;        % Clean Command Window - Clears the contents of the command window

% Define the time vector
t = -10:0.01:10; % Generate a time vector from -10 to 10 with a step of 0.01

% Compute the operations on signals
result_a = signal_x(t) - 2 * signal_y(t);  % Calculate the result of x(t) - 2y(t)
result_b = t .* signal_y(t);               % Calculate the result of t.y(t)
result_c = signal_y(t) .* (t >= 0);        % Calculate the result of y(t).u(t)
result_d = signal_y(-2.*t+3);              % Calculate the result of y(-2t+3)

% Plotting using object-oriented approach
figure("WindowState","maximized");

% Create an array of titles
titles = {'x(t)', 'y(t)', 'x(t) - 2y(t)', 't . y(t)', 'y(t).u(t)', 'y(-2t + 3)'};

% Create an array of colors
colors= {'b','r','k','c','g','m'};

% Create an array of functions
signals_obj = {@signal_x, @signal_y, @(t) result_a, @(t) result_b, @(t) result_c, @(t) result_d};

%% For Loop to plot each signal
for i = 1:numel(signals_obj) 

    % Create a subplot with 6 rows, 1 column, and select the specified subplot position
    subplot(6, 1, i); 
  
    signal_t = signals_obj{i}(t); % Get a specific signal

    % Plot the continuous signal with the specified color and line width
    plot(t, signal_t,colors{i},LineWidth=2);
    
    % Set the title of the subplot with a dynamic title
    title(sprintf("Continuous signal: %s", titles{i}));

    ylabel(titles{i});   % Set the y-axis label based on the input title
    xlabel('t');  % Set the x-axis label as "t"
    grid on;  % Enable the grid on the plot

    % End the For-Loop
end

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