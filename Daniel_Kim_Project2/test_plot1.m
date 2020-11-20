%% Plot Function that accepts b,a coefficients
function [y] = test_plot1(b,a,speech, N)
w = linspace(0,pi,N);
y = filter(b,a, speech);
zplane(b,a);
grid;

figure;

subplot(2,2,1);
plot(impz(b,a,N));
xlabel("Samples (n)");

subplot(2,2,2);
plot(w/pi,abs(freqz(b,a,N)));
xlabel('Normalized Frequency (\times\pi rad/sample)')
ylabel('Magnitude')
ax = gca;
ax.XTick = 0:.1:1;

subplot(2,2,3);
plot(w/pi, unwrap(angle(freqz(b,a,N))));
xlabel('Normalized Frequency (\times\pi rad/sample)')
ylabel('Phase (Degrees)')
ax = gca;
ax.XTick = 0:.1:1;

subplot(2,2,4);
plot(w/pi,abs(grpdelay(b,a,N)));
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('Magnitude');
ax = gca;
ax.XTick = 0:.1:1;
end