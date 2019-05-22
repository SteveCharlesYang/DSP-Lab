wp1=0.65*pi; wp2=0.75*pi; 
ws1=0.6*pi; ws2=0.8*pi; 
ap=0.2; as=42; 
dw1=wp1-ws1; 
dw2=ws2-wp2; 
dw=min(dw1,dw2); 
wc1=mean([ws1 wp1]); 
wc2=mean([ws2 wp2]);  

N=2*ceil((3.32*pi)/dw); 
b=fir1(N,[wc1/pi wc2/pi]); 

plot_filter(b, 'Bandpass filter designed using Hamming window');  

N=2*ceil((3.11*pi)/dw); 
b=fir1(N,[wc1/pi wc2/pi],hanning(N+1)); 

plot_filter(b, 'Bandpass filter designed using Hann window');  

ds=10^(-as/20); 
dp=10^(-ap/20); 
[N,Wn,beta,type]=kaiserord([wc1/pi wc2/pi],[1 0],[dp ds]); 
b=fir1(2*N,[wc1/pi wc2/pi],kaiser(2*N+1,beta)); 

plot_filter(b, 'Bandpass filter designed using Kaiser window');