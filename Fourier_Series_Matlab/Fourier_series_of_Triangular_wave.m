% =======================================================================
% This program plot the Fourier series representation of a triangular wave
% with variable raise/fall time 
% =======================================================================
%%
clc 
clear all
close all
A = 1;      % Amplitude
zeta = 3;   % For controlling raise\fall time. zeta >= 2 
            % zeta is a fraction of the period of the signal

T0 = 2;     % Fundamental period in [Sec]. Fall time equals T0/zeta
N = 5;     % Number of iterations (<30)
durt = 6;   % Duration of the signal in [Sec]
fs = 1000;  % Sampling frequency
t = -durt/2:1/fs:durt/2-1/fs;
C0 = A/zeta; % DC term

%   Equation for calculating the k'th harmonic
syms g(k)
g(k) = (zeta/((k^2)*2*pi^2))...
        * ( 2-cos(2*pi*k/zeta)-cos(2*pi*k*((zeta-1)/zeta)) );
%
DC_shift = repmat(C0 ,[1,length(t)]);
sum = DC_shift; 
harmonics = [];

for n=1:N
    
        T2 = vpa(g(n)); % for numeric value
        Ck = T2.*cos(2*pi*n*t/T0);   % k'th harmonic 
        sum = sum + Ck;
        harmonics = [harmonics;Ck];    % Store the harmonic
        figure(1)
        p1 = plot(t,sum,'LineWidth',1.2);
        yline(0,'--')
        grid on;
        p1.Color = '#11D422';
        title(['Iteration = ', num2str(n)])
        axis([-durt/2 durt/2 -0.2 1.2*A])
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

%%
% 3D plot 1

harmonics = [sum;DC_shift;harmonics]; % Subtracting the DC_shift
figure(3)
[p,q] = ndgrid(t,-1:1:N);
plot3(p,q,harmonics);
% yline(0,'--','LineWidth',1.2)
grid on;
xlabel('Time [Sec]');
title('Interpretation of the Fourier series');
lgnd = [];
lgnd = ['Harmonics ';'harmonic 0'];
for(i=1:N)
    txt = ['harmonic ',num2str(i)];
    lgnd = [lgnd; txt];
end
legend(lgnd);

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % 3D plot 2
% 
harmonics(1,:)= []; % 0'th harmonic = the DC_shift
% 
figure(4)
[p,q] = ndgrid(t,0:1:N);
plot3(p,q,harmonics);
% yline(0,'--','LineWidth',1.2)
grid on;
xlabel('Time [Sec]');
ylabel('Harmonic Number');
zlabel('Harmonic Amplitude')
title('Harmonics of the Fourier series of a triangular wave');
lgnd = [];
for(i=0:N)
    txt = ['harmonic ',num2str(i)];
    lgnd = [lgnd;txt];
end
legend(lgnd);
% 
figure(5)
spectrum = max(harmonics,[],2);
index = 0:1:N;
stem(index,spectrum,'LineWidth',1.2)
grid on;
title('Single-Sided Magnitude Spectrum')
xlabel('Harmonic Number')
ylabel('Harmonic Magnitude')
%% 
% LableFontsize = 13;
% TitleFontsize = 14;
% position = 2;
% FigureWidth = 6;
% Proportion = 1;
% res = 600;
%%