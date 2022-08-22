% =======================================================================
% This program plot the Fourier series representation of a triangular wave
% with variable raise/fall time 
% =======================================================================
%%
clc 
clear all
close all
A = 1;      % Amplitude
zeta = 2;   % For controlling raise\fall time. zeta >= 2 
            % zeta is a fraction of the period of the signal

T0 = 2;     % Fundamental period in [Sec]. Fall time equals T0/zeta
N = 6;     % Number of iterations (<30)
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
DC_shift = repmat(C0 ,[1,length(t)]);
harmonics = [];
harmonics = [harmonics,DC_shift];
for n=1:N
    
        T2 = vpa(g(n)); % for numeric value
        Ck = T2.*cos(2*pi*n*t/T0);   % k'th harmonic 
        sum = sum + Ck;
        figure(1)
        p1 = plot(t,sum,'LineWidth',1.2);
        yline(0,'--')
        grid on;
        p1.Color = '#11D422';
        title(['Iteration = ', num2str(n)])
        axis([-durt/2 durt/2 -0.2 1.2*A])
        harmonics = [harmonics;Ck];    % Store the harmonic
        pause(0.4); % Wait for sometime 
        if(n ~= N) 
            delete(p1);
        end
end

figure(2)
p2 = plot(t,sum,'LineWidth',1.2);
yline(0,'--')
grid on;
hold on;
p2.Color = '#11D422';
title(['Fourier series approximation of triangular wave. N = ', num2str(N)])
legend('approximation')
axis([-durt/2 durt/2 -0.2 1.2*A])

figure(3)
[p,q] = ndgrid(t,1:1:N+1);
plot3(p,q,harmonics);
yline(0,'--')
grid on;
xlabel('Time [Sec]');
ylabel('Harmonic number');
title('Harmonics of the Fourier series of a triangular wave');
lgnd = [];
lgnd = ['DC shift  ']
for(i=1:N)
    txt = ['harmonic ',num2str(i)];
    lgnd = [lgnd;txt];
end

legend(lgnd)
%% 
LableFontsize = 13;
TitleFontsize = 14;
position = 2;
FigureWidth = 6;
Proportion = 1;
res = 600;
%%