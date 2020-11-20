function [out, calcs,total] = srconvert(in)
% Converts an input signal from Fs = 11025 to Fs = 24000 
%% The Code
% Filters ordered this way to maintain as low of a sampling rate throughout 
% the process as possible. If we upsampled all first then downsampled all at 
% the end, by the time it reached the downsampler the sampling rate would
% be huge.

[out,c1,t1] = upsample1(in,5);
[out,c2,t2] = upsample1(out,2);
[out] = downsample(out,7);

[out,c3,t3] = upsample1(out,2);
[out,c4,t4] = upsample1(out,2);
[out,c5,t5] = upsample1(out,2);
[out] = downsample(out,7);

[out,c6,t6] = upsample1(out,2);
[out,c7,t7] = upsample1(out,2);
[out] = downsample(out,3);

calcs = [c1,c2,c3,c4,c5,c6,c7];
total = [t1,t2,t3,t4,t5,t6,t7];
end