%% Luminance gray-scale information
% The grayscale value is an integer

gray = [0:10:250,255]; %gray

Luminance_Gray = [0.42 0.48 0.66 1.05 1.55 2.23 3.18 4.38 5.85...
    7.67 9.77 12.3 14.98 18.15 21.53 25.19 29.26 33.53...
    37.84 43.1 48.5 53.9 59.6 66.1 72.4 79.4 83.9]; 


xx_Gray = linspace(0,255,2551); %The range from 0 to 255 is divided into 256 integer parts and 2551 parts
yy_Gray = spline(gray,Luminance_Gray,xx_Gray); %Cubic spline interpolation, interpolating at the integer xx

for ccc = 1:length(yy_Gray)
    if abs(yy_Gray(ccc)-stimevent.FlashLo_Lum) == min(abs(yy_Gray(:)-stimevent.FlashLo_Lum))
        Gray_Gray = ccc; %灰度值
    end
end

Gray_Gray = xx_Gray(Gray_Gray); %