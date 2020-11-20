function [out,calcs,total] = downsample1(input,M)
    % NOT USED IN SRCONVERT, WASN'T NEEDED
    %% Filter
    % create filter, and polyphase it
    Wp = 1/M;
    Ws = 1.2*Wp;
    Rp = .1;
    Rs = 90;
    [n,Ws] = cheb2ord(Wp,Ws,Rp,Rs);
    [b,a] = cheby2(n,Rs,Ws);
    [h,t] = impz(b,a);
    E = poly1(h',M);
    
    %% Downsample delayed copies of the signal
    in = zeros(M,ceil(length(input)/M));
    for n = 1:M
        in(n,:) = downsample([input(n:end), zeros(1,n-1)],M);
    end
    
    %% Convolution Stage
    % convolve the delayed copies of the downsampled signal with the 
    % polyphase components of the filter
    temp = zeros(M,length(E(1,:))+length(in(1,:))-1);    
    for n = 1:M
        temp(n,:) = conv(E(n,:),in(n,:));
    end    
    % sum of the filtered downsampled signals that are properly delayed
    % yields the filtered signal
    out = sum(temp);
    N = length(h);
    calcs = 2*(N/M)+M-2; % equation from the textbook: (N/M) + (N/M-1)+(M-1) pg 199
    total = length(input);
end