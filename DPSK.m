clear all
close all
clc

% Transmitter 

bitstream = randn(1,10)>0              % Generating a bitstream to be transmitted
dk = zeros(1,length(bitstream));

dk(1) = not(xor(bitstream(1),1));       % Generating DPSK of the first bit with 1
for i = 2:length(bitstream)
    dk(i) = not(xor(bitstream(i),dk(i-1)));   % Generating DPSK of rest of the bitstream
end

% To create the line code
linecode = repelem(dk,100);                                 % Replicating each bit 100 times
linecode = 2*linecode-1;       % Converting to a Polar Linecode

%Plotting the linecode
t = 0:(100*length(bitstream)-1);            %Creating time axis.
subplot(2,1,1)
plot(t,linecode)
xlabel('Time');
title('Differentially Encoded input');

n = 5;                                      % No. of cycles in one time period (100 samples = 1 time Period).
cosine = cos(2*pi*n*t/100);


trans = (linecode.*cosine);                 % Multiplying Line code with cosine wave.
subplot(2,1,2)
plot(t,trans)
xlabel('time');
title('Transmitted signal');

% Receiver
trans(1)=not(trans(1));
rece = (trans);                               % Received signal = Transmitted signal.
m = [cos(2*pi*n*(0:99)/100), rece(1:end-100)];  % delayed signal;
m = rece.*m;                                % received signal multiplied by delayed signal
rb = buffer(m,100) ;                        % integrator
rb = sum(rb,1);                    
rb = rb>0;                                 % threshold detector

display('received bits')
display(rb)