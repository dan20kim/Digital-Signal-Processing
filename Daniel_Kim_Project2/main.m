%% DSP Project 2
% Author: Daniel Kim
% Professor: Keene
% Course: ECE 310
% Date: 10/22/2020

%% Clear Stage
clear; close all; clc;

%% Load Stage
load projIA;

%% Single filter
y  = test_plot1(b,a,speech, 100);

soundsc(y,11025);
%% Foiling 50 filters by hand
aa = a;
bb = b;

for N = 1:49
    aa = conv(aa,a);
    bb = conv(bb,b);
end

y  = test_plot1(bb,aa,speech, 5000); % Garbage Results due to machine precision (One big high order filter)
% Graphs are also all garbage
soundsc(y,11025); % sounds terrible
%% Direct Form 1
Hd_df1 = dfilt.df1(b,a);
[y_df1, y_df1_50]  = test_plot2(Hd_df1,speech, 5000);

%soundsc(y_df1,11025); % If the signal is filtered once, it sounds good!
%This holds for all of the different forms.
soundsc(y_df1_50,11025); % If cascaded 50 times, the group delay adds up and distorts the noise in an audible way.
% Note that the voice is still audible, as it is very low frequency and as
% shown by the group delay plot, very low and very high frequency
% components have very little phase shift.
%% Direct Form 1 SOS
[ss,gn] = tf2sos(b,a);
Hd_df1sos = dfilt.df1sos(ss,gn);
[y_df1sos, y_df1sos_50]  = test_plot2(Hd_df1sos,speech, 5000);

%soundsc(y_df1sos,11025);
soundsc(y_df1sos_50,11025);
%% Direct Form 2 SOS
[ss,gn] = tf2sos(b,a);
Hd_df2sos = dfilt.df2sos(ss,gn);
[y_df2sos, y_df2sos_50]  = test_plot2(Hd_df2sos,speech, 5000);

%soundsc(y_df2sos,11025);
soundsc(y_df2sos_50,11025);
%% Direct Form 2 Transposed SOS
[ss,gn] = tf2sos(b,a);
Hd_df2sos = dfilt.df2tsos(ss,gn);
[y_df2tsos, y_df2tsos_50]  = test_plot2(Hd_df2sos,speech, 5000);

%soundsc(y_df2tsos,11025);
soundsc(y_df2tsos_50,11025);