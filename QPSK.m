clear all
close all
clc

%QPSK

%Modulation
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
bitstream = randi([0,1],1,10)               % 10 random bits
oddstream = bitstream(1:2:end)              % even bits
evenstream = bitstream(2:2:end)             % odd bits

linecode = repelem(bitstream,100);          % linecode for the bitstream in polar form
linecode = 2* linecode - 1;

oddline = repelem(oddstream,200);           % linecode for odd stream in polar
oddline = 2* oddline - 1;

evenline = repelem(evenstream,200);         % linecode for even stream in polar
evenline = 2* evenline - 1;

t = 0:(100*length(bitstream)-1);            % defining time axis
n = 4;                                      % frequency of carrier
basis1 = cos(2*pi*n*t/100);                 % cos - I channel
basis2 = sin(2*pi*n*t/100);                 % sin - Q channel

bpsk1 = (oddline.*basis1);                  % I channel bpsk
bpsk2 = (evenline.*basis2);                 % Q channel bpsk
modulated_sig = bpsk1 + bpsk2;              % qpsk

% input bitstream plot
figure(1)
plot(t,linecode)
xlabel('time (s)')
ylabel('Voltage (V)')
title('Linecode')

% plot of the modulated signals
figure(2)
subplot(311)
plot(t,bpsk1)
xlabel('time (s)')
ylabel('Voltage (V)')
title('Bpsk1')

subplot(312)
plot(t,bpsk2)
xlabel('time (s)')
ylabel('Voltage (V)')
title('Bpsk2')

subplot(313)
plot(t,modulated_sig)
xlabel('time (s)')
ylabel('Voltage (V)')
title('Modulated Signal')

%De-Modulation
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
de_mod_basis1 = modulated_sig .* basis1;        % I channel basis and modulated signal product
de_mod_basis2 = modulated_sig .* basis2;        % Q channel basis and modulated signal product

% plots of received signal and basis products
figure(3)
subplot(211)
plot(t,de_mod_basis1)
xlabel('time (s)')
ylabel('Voltage (V)')
title('qpsk * basis1')

subplot(212)
plot(t,de_mod_basis2)
xlabel('time (s)')
ylabel('Voltage (V)')
title('qpsk * basis2')

odd = buffer(de_mod_basis1,200);            % integration over a bit period
odd = sum(odd,1);
odd = odd>0 ;                               % threshold detection

even = buffer(de_mod_basis2,200);           % integration over a bit period
even = sum(even,1);
even = even > 0;    

demod1=zeros(1,length(bitstream));
%demod2=zeros(1,length(bitstream));
k=1
for i=1: length(demod1)
    if(rem(i,2)==1)
        demod1(i)=odd(k);
        k=k+1;
    end
end
k=1;
for i=1:length(demod1)
    if(rem(i,2)==0)
        demod1(i)=even(k);
        k=k+1;
    end
 end
demod1



