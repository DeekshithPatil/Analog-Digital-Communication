clear all
close all
clc

%%Pulse Code Modulation

Ts=1/8000;
f=500;
t=0:Ts/32:2/f-Ts/32;
s=cos(2*pi*f*t);
plot(t,s);hold on;

mu=255;
smu=sign(s).*log(1+mu*abs(s))/log(1+mu);
s=smu;
s=s-min(s);
s=s/max(s);
s=s*(2^8-1);
ds=buffer(s,32)
ds=ds(1,:)

ups=[ds(:),zeros(length(ds),31)];
ups=ups';
ups=ups(:);

pcms=dec2bin(ups,8);
pcms=pcms';
pcms=pcms(:);

t1=0:Ts/32/8:2/f-Ts/32/8;
plot(t1,bin2dec(pcms),'k');

%% Demodulation

%% TDM demultiplexing and decoding
b = bin2dec(buffer(pcms,8)');                   % groups of 8 bits created and converted to decimal
b = b(1:32:end)                                 % choose 1 out of 32 samples-demultiplexing
b = b/max(b);                                   % convert amplitude range back to -1 to 1
b = (b - 0.5)*2;

%% Inverse mu-Law with mu = 255
b = sign(b).*((1+mu).^abs(b)-1)/mu;

%% reconstructed signal samples
t2=0:Ts:2/f-Ts;
plot(t2,b,'r');                                 % reconstruction shown as plot

legend('Original Signal','PCM','Reconstructed Signal');
