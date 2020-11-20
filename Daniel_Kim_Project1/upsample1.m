function [out,calcs,total] = upsample1(input,L)
    %% Filter
    % create filter, and polyphase it
    Wp = 1/L;
    Ws = 1.2*Wp;
    Rp = .1;
    Rs = 90;    
    [n,Ws] = cheb2ord(Wp,Ws,Rp,Rs);
    [b,a] = cheby2(n,Rs,Ws);
    [h,t] = impz(b,a);
    E = poly1(h',L);

    %% Create Copies of the Input
    in = repmat(input,L,1);
    	
    %% Convolution Stage
    % convolve the polystage components with the input
    temp = zeros(L,length(E)+length(in)-1);
    for n = 1:L
        temp(n,:) = conv(E(n,:),in(n,:));   
    end
    % assemble an array of delayed, polystage filtered outputs
    temp2 = zeros(L,L*(length(temp(1,:))));
    for n = 1:L
         temp2(n,:) = (upsample(temp(n,:)',L))'; % upsample
         temp2(n,:) = circshift(temp2(n,:),n-1); % delay
    end
    % Summing the properly delayed polystage filtered outputs yields the
    % filtered signal
    out = L*sum(temp2);
    
    %% Calculate number of computaions
    N = length(h);
    calcs = 2*N-1; % equation from textbook: L(N/L) + L(N/L-1) + (L-1) = 2*N-1 pg 200
    total = calcs*length(input);
end