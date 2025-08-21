%% CCA- Linear extrapolation amplitude
clc
close all;
clear all;

load data
Fs % sample frequency
%% band-pass filter
for iii = 1:Nkstim
    FilterRange = [3 45];
    DATA_80Trail_Filter{iii,1} = (bandpassfilter(double(data,Fs,FilterRange))';%bandpassfilter
end

%% Average the five trial data of each block
aa=detrend(a,'constant');
aaa=smooth(aa,30,'loess');
mean(data) %average

%% Canonical correlation analysis
figure
for block = 1:size(Sum,2)
    data = ssvepdata{block,1}(:,:);
    fps = 15;
    t = (0:1/Fs:(tt*Fs-1)/Fs)';
    B = data;
    rad1=pi*fps*t*2;
    cos2=cos(rad1);
    sin2=sin(rad1);
    X1=[cos2 sin2];
    [V3, D3, r1] = canoncorr(B,X1); %CCA函数
    signal = B*V3(:,1); % fusion
    [ff,yy,~]=fft(signal); %FFT
    subplot(4,7,block)
    plot(ff,yy) %DFT图
    xlim([0 35])
    %% SNR
    M = 10; %number of points
    k0 = 151; %target frequency
    Sf = yy(k0);
    sum = 0; %inition
    for cc= (k0-M):(k0+M) 
        sum = sum + yy(cc);
    end
    Nf = (sum-Sf)/(2*M);
    snr = Sf/Nf; %snr value
    Amplitude(block) = Sf;
    SNR(block) = snr;
end

%% Fig
figure
plot(Amplitude)
