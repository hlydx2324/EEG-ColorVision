%% to test if you have installed Psychtoolbox

Screen('Preference', 'SkipSyncTests', 1); 
[win, rect] = Screen('OpenWindow', 0, [128 128 128]); 
ifi = Screen('GetFlipInterval', win);
