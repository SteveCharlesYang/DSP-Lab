Fs = 20000;
T = 1/Fs;
L = 64;
N = (0:L-1)*T;
x = sin(0.1*pi*N)+2*cos(0.3*pi*N)+3*sin(0.5*pi*N);

Y = fft(x);

subplot(311)
stem(N,x);
xlabel('Time (s)');
ylabel('Amplitude');
title('Time domain - Input sequence')

subplot(312)
stem(N,Y)
xlabel('Frequency');
ylabel('|X(k)|');
title('Frequency domain - Magnitude response')

subplot(313)
stem(N,angle(Y))
xlabel('Frequency');
ylabel('Phase');
title('Frequency domain - Phase response')
