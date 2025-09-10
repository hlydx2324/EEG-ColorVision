%% present red or green to test lumincance

Screen('Preference', 'SkipSyncTests', 1);
% Clear the workspace and the screen
sca;
close all;
clearvars;

% Here we call some default settings for setting up Psychtoolbox
PsychDefaultSetup(2);

screens = Screen('Screens');

screenNumber = max(screens);
stimevent.Gray = [255 0 0]; % range 0-255

[window, winRect] = Screen('OpenWindow', screenNumber,stimevent.Gray);%,[0 0 800 600]PsychImaging
KbStrokeWait;
sca;
