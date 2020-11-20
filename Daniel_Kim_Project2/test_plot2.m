%% Plot Function that accepts an Hd from dfilt
function [y, y_filtered] = test_plot2(Hd,speech, N)
w = linspace(0,pi,N);
y = filter(Hd, speech);
Hd_cascaded = dfilt.cascade(repmat(Hd,1,50));
y_filtered = filter(Hd_cascaded,speech);
zplane(Hd_cascaded);
grid;

figure;

subplot(2,2,1);
plot(impz(Hd_cascaded,N));
xlabel("Samples (n)");
title("Impulse Response");

subplot(2,2,2);
plot(w/pi,abs(freqz(Hd_cascaded,N)));
xlabel('Normalized Frequency (\times\pi rad/sample)')
ylabel('Magnitude')
title("Frequency Response");
ax = gca;
ax.XTick = 0:.1:1;

subplot(2,2,3);
plot(w/pi, unwrap(angle(freqz(Hd_cascaded,N))));
xlabel('Normalized Frequency (\times\pi rad/sample)')
ylabel('Phase (Radians)')
title("Phase Response");
ax = gca;
ax.XTick = 0:.1:1;

subplot(2,2,4);
plot(w/pi,abs(grpdelay(Hd_cascaded,N)));
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('Magnitude');
title("Group Delay");
ax = gca;
ax.XTick = 0:.1:1;
end