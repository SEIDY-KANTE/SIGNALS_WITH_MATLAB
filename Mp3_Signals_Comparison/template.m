clear All;  % Clean Workspace
close All;  % Close Windows
clc;        % Clean Command Window

%% NOTE 1:
% This code will calculate the cross-correlation between
% the 'template_name.mp3' and each of the three names
% and then determine the most likely name in the 'template_name.mp3'
% based on the highest correlation value

%% NOTE 2:
% % In signal processing, cross-correlation
% % is a measure of similarity of two waveforms as
% % a function of a time-lag applied to one of them

%=========Read the .mp3 files============
template_name = audioread('template_name.mp3'); % Read the 'template_name.mp3' audio file
Maria = audioread('maria.mp3'); % Read the 'maria.mp3' audio file
Joana = audioread('joana.mp3'); % Read the 'joana.mp3' audio file
Hugo = audioread('hugo.mp3'); % Read the 'hugo.mp3' audio file

%=====Determine the minimum length among the audio signals======
min_length = min([length(template_name), length(Maria), length(Joana), length(Hugo)]); % Find the minimum length among all audio signals

%====Resample all audio signals to the minimum length=========
template_name = template_name(1:min_length); % Resample 'template_name' to the minimum length
Maria = Maria(1:min_length); % Resample 'Maria' to the minimum length
Joana = Joana(1:min_length); % Resample 'Joana' to the minimum length
Hugo = Hugo(1:min_length); % Resample 'Hugo' to the minimum length

%=======Use a comparison algorithm:============
cross_corr_Maria = xcorr(template_name, Maria); % Calculate the cross-correlation between 'template_name' and 'Maria'
cross_corr_Joana = xcorr(template_name, Joana); % Calculate the cross-correlation between 'template_name' and 'Joana'
cross_corr_Hugo = xcorr(template_name, Hugo); % Calculate the cross-correlation between 'template_name' and 'Hugo'

%====Find the maximum cross-correlation for each one
max_cross_corr_Maria = max(cross_corr_Maria);
max_cross_corr_Joana = max(cross_corr_Joana);
max_cross_corr_Hugo = max(cross_corr_Hugo);

%========Determine the name in 'template_name.mp3':======
max_corr = max([max_cross_corr_Maria, max_cross_corr_Joana,max_cross_corr_Hugo ]); % Find the maximum cross-correlation value among the three names

if max_corr == max_cross_corr_Maria
    disp('The template likely contains the name Maria.'); % Display a message if 'Maria' has the highest correlation
elseif max_corr == max_cross_corr_Joana
    disp('The template likely contains the name Joana.'); % Display a message if 'Joana' has the highest correlation
elseif max_corr == max_cross_corr_Hugo
    disp('The template likely contains the name Hugo.'); % Display a message if 'Hugo' has the highest correlation
else
    disp('Unable to determine the name.'); % Display a message if the name cannot be determined
end

%pause(1)  % Wait for moment (1 second)

%=============Plot each figure======================
% figure("WindowState","maximized")
figure("WindowState","normal")
plotFigure(template_name,"TEMPLATE NAME",1,"b");
plotFigure(Maria,"MARIA",2,"r");
plotFigure(Joana,"JOANA",3,"y");
plotFigure(Hugo,"HUGO",4,"k");

%=============FUNCTION TO PLOT THE FIGURES================
function plotFigure(name,tit,pos,color)
    subplot(4,1,pos);
    plot(name,sprintf("%c",color),LineWidth=1);
    title(tit);
    ylabel("x(t)");
    xlabel("t")
    grid on;
end
