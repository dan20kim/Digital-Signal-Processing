function [out, calcs,total] = srconvert_baseline(in);
    [out,c1,t1] = upsample2(in,5);
    [out,c2,t2] = upsample2(out,2);
    [out] = downsample(out,7);

    [out,c3,t3] = upsample2(out,2);
    [out,c4,t4] = upsample2(out,2);
    [out,c5,t5] = upsample2(out,2);
    [out] = downsample(out,7);

    [out,c6,t6] = upsample2(out,2);
    [out,c7,t7] = upsample2(out,2);
    [out] = downsample(out,3);
    calcs = [c1,c2,c3,c4,c5,c6,c7];
    total = [t1,t2,t3,t4,t5,t6,t7];
end