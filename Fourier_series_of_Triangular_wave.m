% =======================================================================
% This program plot the Fourier series representation of a triangular wave
% with variable raise/fall time 
% =======================================================================
%%
A = 1; % Amplitude
zeta = 4;   % For controlling raise\fall time. zeta >= 2 
C0 = A/zeta; % DC term
T0 = 2; % Fundamental period in [Sec]. Fall time equals T0/zeta
N = 10; % Number of iterations
durt = 6; % Duration of the signal in [Sec]
fs = 1000; % Sampling frequency
t = -durt/2:1/fs:durt/2-1/fs;
%   Equation for calculating the k'th harmonic
syms g(k)
g(k) = (zeta/((k^2)*2*pi^2))...
        * ( 2-cos(2*pi*k/zeta)-cos(2*pi*k*((zeta-1)/zeta)) );
%
y = C0;
for n=1:N
    
    T2 = vpa(g(n)); % for numeric value
    Ck = T2*cos(2*pi*n*t/T0);   % k'th harmonic 
    y = y + Ck;
    figure(1)
    plot2 = plot(t,y,'LineWidth',1.2);
    grid on;
    plot2.Color = '#11D422';
    title(['N = ', num2str(n)])
    axis([-durt/2 durt/2 -0.2 1.2*A])
    pause(0.4); % Wait for sometime 
    if(n ~= N) 
        delete(plot2);
    end

end

%% 
lin_width = 2;
LableFontsize = 13;
TitleFontsize = 14;
position = 2;
FigureWidth = 6;
Proportion = 1;
res = 600;
%%