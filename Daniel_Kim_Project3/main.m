%Dan Kim, Phil Blumin, Tony Belladonna
%The Cooper Union
%Professor Keene
%The Cooper Union

%% Clear Stage 
clc;
clear;
close all;

%% Load File
load('projIB.mat');

%% Specifications

Fpass = 2500;
Fstop = 4000;
Apass = 3;
Astop = 55;
match = 'stopband';

%% Butterworth
Butterworth = designfilt('lowpassiir','PassbandFrequency',Fpass,...
    'StopbandFrequency',Fstop,'PassbandRipple',Apass,'StopbandAttenuation',...
    Astop,'SampleRate',fs,'DesignMethod','butter');

order_butter = filtord(Butterworth);
disp("Order of Butterworth: " + order_butter);
noisybutter = filter(Butterworth,noisy);

[H,f] = freqz(Butterworth,fs);
hdb = 20*(log10(abs(H)));
[gd,w] = grpdelay(Butterworth,fs);
[hz,hp,ht] = zplane(Butterworth);
[himp,wimp] = impz(Butterworth,100);

disp("Number of Multipies (Butterworth): " + (length(hz) + length(hp) + 2) );

figure;
sgtitle('Butterworth Filter');

subplot(3,1,1);
plot(f,hdb);
title('Magnitude Response in DB');
xticks([0, pi/4, pi/2, pi*3/4, pi]);
xticklabels({'0','\pi/4','\pi/2','3\pi/4','\pi'})
xlabel('\omega (rads)');

subplot(3,1,2);
plot(f,abs(H));
title('Magnitude Response (Linear Scale)');
xlim([0,.5]);
ylim ([0.8,1.2]);
%xticks([0, 2*pi*2500/fs]);
%xticklabels({'0','\pi/4','\pi/2','3\pi/4','\pi'});
xlabel('\omega (rads)');

subplot(3,1,3);
plot(w,gd);
title('Groupdelay');
xticks([0, pi/4, pi/2, pi*3/4, pi]);
xticklabels({'0','\pi/4','\pi/2','3\pi/4','\pi'});
xlabel('\omega (rads)');

figure;
sgtitle('Butterworth (d & e)');

subplot(2,1,1);
zplane(hz,hp);
title('Pole-Zero Plot');

subplot(2,1,2);
stem([1 : 100],himp);
title('Impulse Response (100 Samples)');
xlabel('Samples');

soundsc(noisybutter,fs); % sounds good

%% Chebyshev Type I

Cheby1 = designfilt('lowpassiir','PassbandFrequency',Fpass,...
    'StopbandFrequency',Fstop,'PassbandRipple',Apass,'StopbandAttenuation',...
    Astop,'SampleRate',fs,'DesignMethod','cheby1');

order_Cheby1 = filtord(Cheby1);
disp("Order of Chebyshev Type I: " + order_Cheby1);
noisycheby1 = filter(Cheby1,noisy);

[H,f] = freqz(Cheby1,fs);
hdb = 20*(log10(abs(H)));
[gd,w] = grpdelay(Cheby1,fs);
[hz,hp,ht] = zplane(Cheby1);
[himp,wimp] = impz(Cheby1,100);

%Plot
disp("Number of Multipies (Chebyshev Type I): " + (length(hz) + length(hp) + 2) );

figure;
sgtitle('Cheby1 Filter');

subplot(3,1,1);
plot(f,hdb);
title('Magnitude Response in DB');
xticks([0, pi/4, pi/2, pi*3/4, pi]);
xticklabels({'0','\pi/4','\pi/2','3\pi/4','\pi'})
xlabel('\omega (rads)');

subplot(3,1,2);
plot(f,abs(H));
title('Magnitude Response (Linear Scale)');
xlim([0,.5]);
ylim ([0.6,1.2]);
%xticks([0, 2*pi*2500/fs]);
%xticklabels({'0','\pi/4','\pi/2','3\pi/4','\pi'});
xlabel('\omega (rads)');

subplot(3,1,3);
plot(w,gd);
title('Groupdelay');
xticks([0, pi/4, pi/2, pi*3/4, pi]);
xticklabels({'0','\pi/4','\pi/2','3\pi/4','\pi'});
xlabel('\omega (rads)');

figure;
sgtitle('Cheby1 (d & e)');

subplot(2,1,1);
zplane(hz,hp);
title('Pole-Zero Plot');

subplot(2,1,2);
stem([1 : 100],himp);
title('Impulse Response (100 Samples)');
xlabel('Samples');

soundsc(noisycheby1,fs); % sounds good

%% Chebyshev Type II

Cheby2 = designfilt('lowpassiir','PassbandFrequency',Fpass,...
    'StopbandFrequency',Fstop,'PassbandRipple',Apass,'StopbandAttenuation',...
    Astop,'SampleRate',fs,'DesignMethod','cheby2');

order_Cheby2 = filtord(Cheby2);
disp("Order of Chebyshev Type II: " + order_Cheby2);
noisycheby2 = filter(Butterworth,noisy);

[H,f] = freqz(Cheby2,fs);
hdb = 20*(log10(abs(H)));
[gd,w] = grpdelay(Cheby2,fs);
[hz,hp,ht] = zplane(Cheby2);
[himp,wimp] = impz(Cheby2,100);

% Plot
disp("Number of Multipies (Chebyshev Type II): " + (length(hz) + length(hp) + 2) );

figure;
sgtitle('Cheby2 Filter');

subplot(3,1,1);
plot(f,hdb);
title('Magnitude Response in DB');
xticks([0, pi/4, pi/2, pi*3/4, pi]);
xticklabels({'0','\pi/4','\pi/2','3\pi/4','\pi'})
xlabel('\omega (rads)');

subplot(3,1,2);
plot(f,abs(H));
title('Magnitude Response (Linear Scale)');
xlim([0,.6]);
ylim ([0.6,1.2]);
%xticks([0, 2*pi*2500/fs]);
%xticklabels({'0','\pi/4','\pi/2','3\pi/4','\pi'});
xlabel('\omega (rads)');

subplot(3,1,3);
plot(w,gd);
title('Groupdelay');
xticks([0, pi/4, pi/2, pi*3/4, pi]);
xticklabels({'0','\pi/4','\pi/2','3\pi/4','\pi'});
xlabel('\omega (rads)');

figure;
sgtitle('Cheby2 (d & e)');

subplot(2,1,1);
zplane(hz,hp);
title('Pole-Zero Plot');

subplot(2,1,2);
stem([1 : 100],himp);
title('Impulse Response (100 Samples)');
xlabel('Samples');

soundsc(noisycheby2,fs); % sounds good

%% Elliptic

Elliptic = designfilt('lowpassiir','PassbandFrequency',Fpass,...
    'StopbandFrequency',Fstop,'PassbandRipple',Apass,'StopbandAttenuation',...
    Astop,'SampleRate',fs,'DesignMethod','ellip');

order_Elliptic = filtord(Elliptic);
disp("Order of Elliptic: " + order_Elliptic);
noisyElliptic = filter(Elliptic,noisy);

[H,f] = freqz(Elliptic,fs);
hdb = 20*(log10(abs(H)));
[gd,w] = grpdelay(Elliptic,fs);
[hz,hp,ht] = zplane(Elliptic);
[himp,wimp] = impz(Elliptic,100);

% Plot
disp("Number of Multipies (Elliptic): " + (length(hz) + length(hp) + 2) );

figure;
sgtitle('Elliptic Filter');

subplot(3,1,1);
plot(f,hdb);
title('Magnitude Response in DB');
xticks([0, pi/4, pi/2, pi*3/4, pi]);
xticklabels({'0','\pi/4','\pi/2','3\pi/4','\pi'})
xlabel('\omega (rads)');

subplot(3,1,2);
plot(f,abs(H));
title('Magnitude Response (Linear Scale)');
xlim([0,.6]);
ylim ([0.6,1.2]);
%xticks([0, 2*pi*2500/fs]);
%xticklabels({'0','\pi/4','\pi/2','3\pi/4','\pi'});
xlabel('\omega (rads)');

subplot(3,1,3);
plot(w,gd);
title('Groupdelay');
xticks([0, pi/4, pi/2, pi*3/4, pi]);
xticklabels({'0','\pi/4','\pi/2','3\pi/4','\pi'});
xlabel('\omega (rads)');

figure;
sgtitle('Elliptic (d & e)');

subplot(2,1,1);
zplane(hz,hp);
title('Pole-Zero Plot');

subplot(2,1,2);
stem([1 : 100],himp);
title('Impulse Response (100 Samples)');
xlabel('Samples');

soundsc(noisyElliptic,fs); % sounds good except there's static in the back
%% Parks-McClellan

% PMC = designfilt('lowpassfir','PassbandFrequency',Fpass,...
%     'StopbandFrequency',Fstop,'PassbandRipple',Apass,'StopbandAttenuation',...
%     Astop,'SampleRate',fs,'DesignMethod','kaiserwin');
dev = [(10^(Apass/20)-1)/(10^(Apass/20)+1) 10^(-Astop/20)]; 
[n,fo,ao,w] = firpmord([Fpass Fstop],[1 0],[dev], fs);
PMC = firpm(abs(n),fo,ao,w);
%[hz,hp,ht] = zplane(PMC);
%order_PMC = filtord(PMC);
disp("Order of Parks-McClellan: " + abs(n));
noisyPMC = filter(PMC,abs(n),noisy);

[H,f] = freqz(PMC,abs(n),fs);
hdb = 20*(log10(abs(H)));
[gd,w] = grpdelay(PMC,fs);
[himp,wimp] = impz(PMC,abs(n),100);


% Plot
disp("Number of Multipies (Parks-McClellan): " + (44 + 44 + 2) );

figure;
sgtitle('Parks-McClellan Filter');

subplot(3,1,1);
plot(f,hdb);
title('Magnitude Response in DB');
xticks([0, pi/4, pi/2, pi*3/4, pi]);
xticklabels({'0','\pi/4','\pi/2','3\pi/4','\pi'})
xlabel('\omega (rads)');

subplot(3,1,2);
plot(f,abs(H));
title('Magnitude Response (Linear Scale)');
xlim([0,.6]);
ylim ([0.015,0.03]);
%xticks([0, 2*pi*2500/fs]);
%xticklabels({'0','\pi/4','\pi/2','3\pi/4','\pi'});
xlabel('\omega (rads)');

subplot(3,1,3);
plot(w,gd);
title('Groupdelay');
xticks([0, pi/4, pi/2, pi*3/4, pi]);
xticklabels({'0','\pi/4','\pi/2','3\pi/4','\pi'});
xlabel('\omega (rads)');

figure;
sgtitle('Parks-McClellan (d & e)');

subplot(2,1,1);
%zplane(hz,hp);
zplane(PMC);
title('Pole-Zero Plot');

subplot(2,1,2);
stem([1 : 100],himp);
title('Impulse Response (100 Samples)');
xlabel('Samples');

soundsc(noisyPMC,fs); % sounds similar to elliptic

%% Kaiser

Kaiser = designfilt('lowpassfir','PassbandFrequency',Fpass,...
    'StopbandFrequency',Fstop,'PassbandRipple',Apass,'StopbandAttenuation',...
    Astop,'SampleRate',fs,'DesignMethod','kaiserwin');

order_Kaiser = filtord(Kaiser);
disp("Order of Kaiser: " + order_Kaiser);
noisyKaiser = filter(Kaiser,noisy);

[H,f] = freqz(Kaiser,fs);
hdb = 20*(log10(abs(H)));
[gd,w] = grpdelay(Kaiser,fs);
[hz,hp,ht] = zplane(Kaiser);
[himp,wimp] = impz(Kaiser,100);

disp("Number of Multipies (Kaiser): " + (length(hz) + length(hp) + 2) );

figure;
sgtitle('Kaiser Filter');

subplot(3,1,1);
plot(f,hdb);
title('Magnitude Response in DB');
xticks([0, pi/4, pi/2, pi*3/4, pi]);
xticklabels({'0','\pi/4','\pi/2','3\pi/4','\pi'})
xlabel('\omega (rads)');

subplot(3,1,2);
plot(f,abs(H));
title('Magnitude Response (Linear Scale)');
xlim([0,.6]);
ylim ([0.6,1.2]);
%xticks([0, 2*pi*2500/fs]);
%xticklabels({'0','\pi/4','\pi/2','3\pi/4','\pi'});
xlabel('\omega (rads)');

subplot(3,1,3);
plot(w,gd);
title('Groupdelay');
xticks([0, pi/4, pi/2, pi*3/4, pi]);
xticklabels({'0','\pi/4','\pi/2','3\pi/4','\pi'});
xlabel('\omega (rads)');

figure;
sgtitle('Kaiser (d & e)');

subplot(2,1,1);
zplane(hz,hp);
title('Pole-Zero Plot');

subplot(2,1,2);
stem([1 : 100],himp);
title('Impulse Response (100 Samples)');
xlabel('Samples');

soundsc(noisyKaiser,fs); %sounds similar to elliptic but noise is quieter


