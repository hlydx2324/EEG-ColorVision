%% Gray-Luminance Calibration for Red and Green Channels
% MATLAB + Psychtoolbox required
% Author: Xiaowei Zheng
% Date: 2025.5

% clear; clc; close all;

%% 1. Define grayscale values
grayValues = 0:5:255; % integer grayscale levels to test
nVals = length(grayValues);

%% 2. Measure luminance for each grayscale value (cd/m²) (for example)
% Here we simulate measurement; replace with photometer readings
% Example: measuredLum_R and measuredLum_G
% You need to replace this part with actual measurement
measuredLum_R = 0.05 * grayValues.^1.8 + 0.1; % simulated red channel 
measuredLum_G = 0.04 * grayValues.^1.9 + 0.2; % simulated green channel

%% 3. Fit calibration curves
% Log-log linearization to linearize luminance perception
p_R = polyfit(log(grayValues+1), log(measuredLum_R+1), 1);
p_G = polyfit(log(grayValues+1), log(measuredLum_G+1), 1);

% Create fitted curves
fitLum_R = exp(p_R(2)) * (grayValues+1).^p_R(1) - 1;
fitLum_G = exp(p_G(2)) * (grayValues+1).^p_G(1) - 1;

%% 4. Plot calibration curves
figure;
plot(grayValues, measuredLum_R, 'ro', 'MarkerSize',6,'DisplayName','Measured Red');
hold on;
plot(grayValues, fitLum_R, 'r-', 'LineWidth',1.5, 'DisplayName','Fitted Red');
plot(grayValues, measuredLum_G, 'go', 'MarkerSize',6,'DisplayName','Measured Green');
plot(grayValues, fitLum_G, 'g-', 'LineWidth',1.5, 'DisplayName','Fitted Green');
xlabel('Gray value (0-255)');
ylabel('Luminance (cd/m²)');
title('Gray-Luminance Calibration for Red and Green Channels');
legend('Location','northwest');
grid on;

%% 5. Compute inverse mapping: desired luminance -> required gray
desiredLum_R = 5; % target luminance for red channel
desiredLum_G = 35; % target luminance for green channel

% Solve for gray value using inverse of the fitted curve
Gray_R = round(exp((log(desiredLum_R + 1) - p_R(2))/p_R(1)) - 1);
Gray_G = round(exp((log(desiredLum_G + 1) - p_G(2))/p_G(1)) - 1);

fprintf('For target luminance %.2f cd/m²:\n', desiredLum_R);
fprintf('Red channel gray value = %d\n', Gray_R);
fprintf('Green channel gray value = %d\n', Gray_G);

%% 6. Optional: Save calibration results
calibrationTable = table(grayValues', measuredLum_R', fitLum_R', measuredLum_G', fitLum_G', ...
    'VariableNames', {'Gray', 'Lum_R_measured', 'Lum_R_fit', 'Lum_G_measured', 'Lum_G_fit'});
writetable(calibrationTable, 'GrayLuminanceCalibration.csv');
disp('Calibration table saved as GrayLuminanceCalibration.csv');

