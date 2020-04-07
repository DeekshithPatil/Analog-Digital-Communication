close all;

%% Unipolar Raised Cosine


alpha = 0.8;                     
t = linspace(0,(1+alpha)/2,50);
h = 1*(t<=(1-alpha)/2) + (0.5+0.5*cos(pi/alpha*(t-(1-alpha)/2))) .* (t>(1-alpha)/2);
h = [fliplr(h),h];

bk = rand(1,100)>0.5;
x = bk'*h;
x = x';
x = x(:)';
t = 0:1/100:100-1/100;
subplot(211);plot(t,x); axis([0,10,-1,1]);

X = abs(fftshift(fft(x)));
X = X/max(X);
f = linspace(-50,50,length(X));
subplot(212);plot(f,X);axis([-5,5,0,1]);


%% Polar Raised Cosine


bk = 2*bk-1;
x = bk'*h;
x = x';
x = x(:)';
t = 0:1/100:100-1/100;
figure();
subplot(211);plot(t,x); axis([0,10,-1,1]);

X = abs(fftshift(fft(x)));
X = X/max(X);
f = linspace(-50,50,length(X));
subplot(212);plot(f,X);axis([-5,5,0,1]);






