function plot_filter(b_val, d_val)
    [H,w]=freqz(b_val,1,512); 
    figure; 
    subplot(2,1,1);
    stem(b_val); 
    title('Impulse Response Coefficients'); 
    xlabel('Time index n'); 
    ylabel('h[n]'); 
    subplot(2,1,2);
    plot(w/pi, 20*log10(abs(H))); 
    grid; 
    xlabel('\omega/\pi'); 
    ylabel('Gaim, dB') 
    title(d_val)
end