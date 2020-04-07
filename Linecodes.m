clear all
close all
clc
%Line codes 

% NRZ
N = input('Enter the length of bitstream');
bitstream = rand(1,N) > 0.5
%bitstream=input('Enter the bitstream: ');
duration = 100 ;                                   %samples
time = 0:(duration*length(bitstream)-1);         %Time period = 100 samples.
NRZP = repelem(bitstream,duration);

%Unipolar
NRZU = NRZP;
figure(1)
subplot(2,2,1);
plot(time,NRZU);
axis([0,N*duration,-1.5,1.5]);
title('NRZ Unipolar');
xlabel('Time(s)');
ylabel('Voltage(V)');

%Polar
NRZP = 2*NRZP - 1;
subplot(2,2,2);
plot(time,NRZP);axis([0,N*duration,-1.5,1.5]);
title('NRZ Polar');
xlabel('Time(s)');
ylabel('Voltage(V)');

%RZ
intermediate = ones(1,length(bitstream)*2);
intermediate(2:2:length(intermediate)) = 0;
intermediate = repelem(intermediate,duration/2);

%Unipolar
RZU = NRZU .* intermediate;
subplot(2,2,3)
plot(time,RZU);axis([0,N*duration,-1.5,1.5]);
title('RZ Unipolar')
xlabel('Time(s)')
ylabel('Voltage(V)')

%Polar
RZP = NRZP .* intermediate;
subplot(2,2,4)
plot(time,RZP);axis([0,N*duration,-1.5,1.5]);
title('RZ Polar')
xlabel('Time(s)')
ylabel('Voltage(V)')

%Power Spectrum

freq = linspace(-duration/2,duration/2,length(NRZP));
NRZUK = ((abs(fftshift(fft(NRZU)))));
NRZPK = ((abs(fftshift(fft(NRZP)))));
RZUK = ((abs(fftshift(fft(RZU)))));
RZPK = ((abs(fftshift(fft(RZP)))));

NRZUK = NRZUK/max(NRZUK);
NRZPK = NRZPK/max(NRZPK);
RZUK = RZUK/max(RZUK);
RZPK = RZPK/max(RZPK);

figure(2)
subplot(221)
plot(freq,NRZUK); axis([-5,5,0,1.2]);
xlabel('frequency(f)')
ylabel('S(X(f))')
title('NRZ Unipolar')

subplot(222)
plot(freq,NRZPK); axis([-5,5,0,1.2]);
xlabel('frequency(f)')
ylabel('S(X(f))')
title('NRZ Polar')

subplot(223)
plot(freq,RZUK); axis([-5,5,0,1.2]);
xlabel('frequency(f)')
ylabel('S(X(f))')
title('RZ Unipolar')

subplot(224)
plot(freq,RZPK); axis([-5,5,0,1.2]);
xlabel('frequency(f)')
ylabel('S(X(f))')
title('RZ Polar')


