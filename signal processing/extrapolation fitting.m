%% Analysis of extrapolation fitting
clear all
close all
clc

%% 数据加载
data = xlsread('XXX'); %data
subject = 10; %subject id
number = 9; %The first number of data are used to fit the straight line

%% Curve 1
xx = data(1,3:number); %Luminance ratio gradient
yy = data(subject+1,3:number); %SSVEP response
[p]=polyfit(xx,yy,1); %Fitting a linear, p involves the slope and intercept
f = polyval(p,xx); 
plot(xx,yy,'o',xx,f,'-') 
legend('data','linear fit') 
xlabel('xx');ylabel('yy');

%%  Curve 2
xx1 = data(1,number:end); %Luminance ratio gradient
yy1 = data(subject+1,number:end); %SSVEP response
[p1]=polyfit(xx1,yy1,1); %Fitting a linear, p involves the slope and intercept
f1 = polyval(p1,xx1); 
figure
plot(xx1,yy1,'o',xx1,f1,'-') 
legend('data','linear fit') 
xlabel('xx1');ylabel('yy1');

%% Find the intersection point
k1 = p(1);
b1 = p(2);
k2 = p1(1);
b2 = p1(2);
[x_sp,y_sp]=linecross(k1,b1,k2,b2);

%% plot Amplitude
figure
plot(data(1,:),data(subject+1,:))
