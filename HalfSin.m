close all;

%% Unipolar Half-sinusoid
bk = rand(1,100)>0.5;
x = bk'*sin(2*pi/200*(0:99));
x = x';
x = x(:)';

t = 0:1/100:100-1/100;
subplot(211);plot(t,x);axis([0,10,-1,1]);

X = abs(fftshift(fft(x)));
X = X/max(X);
f = linspace(0,100,length(X));
subplot(212);plot(f,X);axis([-5,5,0,1]);



%% Polar Half Sinusoid

bk = 2*bk-1;
x = bk'*sin(2*pi/200*[0:99]);
x = x';
x = x(:)';

t = 0:1/100:100-1/100;
figure();
subplot(211);plot(t,x);axis([0,10,-1,1]);

X = abs(fftshift(fft(x)));
X = X/max(X);
f = linspace(-50,50,length(X));
subplot(212);plot(f,X);axis([-5,5,0,1]);