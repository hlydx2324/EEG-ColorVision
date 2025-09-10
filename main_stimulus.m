%% Main procedure for Red-Green Checkerboard Flicker Stimulus
% Flicker frequency: 15 Hz
% Author: Xiaowei Zheng
% Date: 2025.5

clear; clc; close all;
Screen('Preference', 'SkipSyncTests', 1);

%% 1. Load calibrated gray values (example)
Gray_R = 120; % red square gray value after calibration and caculation
Gray_G = 180; % green square gray value after calibration and caculation
Gray_Back = 128; % background gray

%% 2. Screen setup
screenNum = max(Screen('Screens'));
[win, rect] = Screen('OpenWindow', screenNum, Gray_Back);
[xCenter, yCenter] = RectCenter(rect);

%% 3. Flicker parameters (adjustable)
flickerFreq = 15; % Hz, can change to other frequency
flipInterval = 1 / flickerFreq;
stimDuration = 5; % seconds
nFlips = flickerFreq * stimDuration;

%% 4. Checkerboard parameters
nRows = 6; % number of rows
nCols = 6; % number of columns
stimSize = 60; % size of one square (pixels)

% Precompute checkerboard positions
[xGrid, yGrid] = meshgrid(0:nCols-1, 0:nRows-1);

%% 5. Generate two color matrices
color1 = [Gray_R, 0, 0]; % red
color2 = [0, Gray_G, 0]; % green

%% 6. Present checkerboard flicker
for i = 1:nFlips
    % Alternate pattern
    if mod(i,2)==1
        flipColor = 1;
    else
        flipColor = 2;
    end
    
    for r = 1:nRows
        for c = 1:nCols
            pos = [c-1, r-1, c, r] * stimSize;
            % move postion to the center
            pos = [pos(1)+xCenter-stimSize*nRows/2, pos(2)+yCenter-stimSize*nRows/2, pos(3)+xCenter-stimSize*nRows/2, pos(4)++yCenter-stimSize*nRows/2];
            % Alternate colors to form checkerboard
            if mod(r+c,2) == 0
                if flipColor == 1
                    Screen('FillRect', win, color1, pos);
                else
                    Screen('FillRect', win, color2, pos);
                end
            else
                if flipColor == 1
                    Screen('FillRect', win, color2, pos);
                else
                    Screen('FillRect', win, color1, pos);
                end
            end
        end
    end
    Screen('Flip', win);
    WaitSecs(flipInterval);
end

%% 7. Close window
Screen('CloseAll');
disp('Checkerboard stimulus finished.');