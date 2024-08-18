clc;
clear all;
close all;
%%
Uavg = zeros(400,1);
Vavg = zeros(400,1);
addU = 0;
addV = 0;
for s = 1:10000
    for g = 0:399
        addU = addU + piv(s+g*10000,3);
        addV = addV + piv(s+g*10000,4);
    end
    Uavg(s) = addU/400;
    Vavg(s) = addV/400;
    addU = 0;
    addV = 0;
end
%%
for s = 1:10000
    for g = 0:399
        Uval(s,g+1) = Piv(s+g*10000,3);
        Vval(s,g+1) = Piv(s+g*10000,4);
    end
end
%%
for h = 1:10000
    Urmsval(h) = rms(Uval(h,:));
    Vrmsval(h) = rms(Vval(h,:));
end