Omegap=4;
Omegas=6;
Omegat=18;
wp=2*pi*Omegap/Omegat;
ws=2*pi*Omegas/Omegat;
alphap=0.2;
alphas=42;
NUM_Hamming=1;
NUM_Hann=2;
NUM_Blackman=3;
c=[3.32,3.11,5.56]*pi;
wc=(ws+wp)/2;
delt_w=ws-wp;
freq_labels={'用海明窗设计的FIR频率响应','用汉宁窗设计的FIR频率响应','用布莱克曼窗设计的FIR频率响应'};
ht_labels={'海明窗FIR冲激响应','汉宁窗FIR冲激响应','布莱克曼窗FIR响应'};
for filter_kind=NUM_Hamming:NUM_Blackman
    M=ceil(c(filter_kind)/delt_w);
    N=2*M+1;
    switch filter_kind
        case NUM_Hamming
            win=hamming(N);
            disp(['海明窗生成的冲激响应系数：','  (阶数N=',num2str(N),')']);
            figure
        case NUM_Hann
            win=hann(N);          
            disp(['汉宁窗生成的冲激响应系数：','  (阶数N=',num2str(N),')']);
            figure
        case NUM_Blackman
            win=blackman(N);           
            disp(['布莱克曼窗生成的冲激响应系数：','(阶数N=',num2str(N),')']);
            figure
        otherwise
            disp('error');
    end
    n=-M:M;
    hd=sin(wc*n)./(pi*n);
    hd(n==0)=wc*cos(wc*0)/pi;
    ht=hd.*win';
    display(['',num2str(ht)]);
    subplot(1,2,1);
    plot(n,ht,'.-');
    title(ht_labels(filter_kind));
    xlabel('n','FontSize',12);
    ylabel('ht','fontsize',12);
    grid on
    [h,w]=freqz(ht,1,512);
    W=w/pi;
    H=20*log10(abs(h));
    subplot(1,2,2);
    hold on
    title(freq_labels(filter_kind));
    plot(W,H);
    xlabel(['\pi (\omega/\omega','s)']);
    ylabel('增益(dB)');
    grid on  
    dotp=round(mean(find(w>wp-0.1&w<wp+0.1)));
    dots=round(mean(find(w>ws-0.1&w<ws+0.1)));
    plot(W(dotp),H(dotp),'.r','MarkerSize',25);
    plot(W(dots),H(dots),'.r','MarkerSize',25);
    text(W(dotp),H(dotp),['[','',num2str(round(W(dotp)*1000)/1000),',',num2str(round(H(dotp)*1000)/1000),'dB]'],'FontSize',15);
    text(W(dots),H(dots),['[','',num2str(round(W(dots)*100)/100),',',num2str(round(H(dots)*100)/100),'dB]'],'fontsize',15);
    hold off
end