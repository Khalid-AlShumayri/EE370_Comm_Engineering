% =======================================================================
% This program plot the Fourier series representation of a triangular wave
% with variable raise/fall time 
% =======================================================================
%%
clc 
clear all
close all
A = 1;      % Amplitude
zeta = 5;   % For controlling raise\fall time. zeta >= 2 
T0 = 2;     % Fundamental period in [Sec]. Fall time equals T0/zeta
N = 10;     % Number of iterations (<30)
durt = 6;   % Duration of the signal in [Sec]
fs = 1000;  % Sampling frequency
t = -durt/2:1/fs:durt/2-1/fs;
C0 = A/zeta; % DC term
%   Equation for calculating the k'th harmonic
syms g(k)
g(k) = (zeta/((k^2)*2*pi^2))...
        * ( 2-cos(2*pi*k/zeta)-cos(2*pi*k*((zeta-1)/zeta)) );
%
sum = C0;
for n=1:100
    
    if(n<=N)
        T2 = vpa(g(n)); % for numeric value
        Ck = T2*cos(2*pi*n*t/T0);   % k'th harmonic 
        sum = sum + Ck;
        figure(1)
        plot1 = plot(t,sum,'LineWidth',1.2);
        grid on;
        plot1.Color = '#11D422';
        title(['Iteration = ', num2str(n)])
        axis([-durt/2 durt/2 -0.2 1.2*A])
        pause(0.4); % Wait for sometime 
        if(n ~= N) 
            delete(plot1);
        else
            y_aprox = sum;
        end
    else
        T2 = vpa(g(n)); % for numeric value
        Ck = T2*cos(2*pi*n*t/T0);   % k'th harmonic 
        sum = sum + Ck;
    end


end

figure(2)
plot2 = plot(t,sum,'LineWidth',1.2);
grid on;
hold on
plot3 = plot(t,y_aprox,'LineWidth',1.2);
plot2.Color = '#000000'
plot3.Color = '#11D422';
title(['Fourier series approximation of triangular wave. N = ', num2str(N)])
legend('Function','approximation')
axis([-durt/2 durt/2 -0.2 1.2*A])
%% 
lin_width = 2;
LableFontsize = 13;
TitleFontsize = 14;
position = 2;
FigureWidth = 6;
Proportion = 1;
res = 600;
%%