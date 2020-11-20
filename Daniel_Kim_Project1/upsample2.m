function [out,calcs,total] = upsample2(input,L)
    in_upsampled = upsample(input,L);
    Wp = 1/L;
    Ws = 1.2*Wp;
    Rp = .1;
    Rs = 90;    
    [n,Ws] = cheb2ord(Wp,Ws,Rp,Rs);
    [b,a] = cheby2(n,Rs,Ws);
    [h,t] = impz(b,a);
    out = L*conv(h,in_upsampled);
    N = length(h);
    % note that we take the length of the signal at the upsampled signal
    % instead of the length of the input signal. This is a key
    % difference between the calculations of polyphased and non-polyphase
    % as the filtering occurs at a lower sampling rate when polyphased.
    calcs = 2*N-1; % N (multiplies) +  N-1 (adds) = 2N-1 (derived from basic convolution formula)
    total = calcs*length(in_upsampled);
end