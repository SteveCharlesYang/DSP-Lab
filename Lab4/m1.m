T = 1;
omega = [0.3 0.45 0.65 0.75]*pi;
Omega_prewarped = (2/T)*tan(omega/2);

Omega_0 = sqrt(Omega_prewarped(2)*Omega_prewarped(3));
Omega_prewarped(1) = Omega_0^2/Omega_prewarped(4);

BW = Omega_prewarped(3)-Omega_prewarped(2);

Omega_p = 1;
Omega_s = (Omega_0^2-Omega_prewarped(1)^2)/(Omega_prewarped(1)*BW);

[N,Wn] = buttord(Omega_p,Omega_s,1,40,'s');
[B,A] = butter(N,Wn,'s');

LPFpoles = roots(A);
BPFpoles = zeros(1,2*N);
index = 1;
for i=1:N
    tmp = roots([1 -LPFpoles(i)*BW/Omega_p +Omega_0^2]);
    BPFpoles(index) = tmp(1);
    BPFpoles(index+1) = tmp(2);
    index = index+2;
end
A_BPF = poly(BPFpoles);
B_BPF = [B(end)*BW^N zeros(1,N)];

[num,den] = bilinear(B_BPF,A_BPF,T);

[h,w] = freqz(num, den, 100);