clc;
clear all;
close all;
%%
Piv=load("PIVdata (1).txt");
%% 
% *PREALLOCATION*

u_velocity=Piv(:,3);
v_velocity=Piv(:,4);
u_avg=zeros(10000,1);
v_avg=zeros(10000,1);
u_fluctuation=zeros(4000000,1);
v_fluctuation=zeros(4000000,1);
fluxmul=zeros(4000000,1);
fluxmulv=zeros(4000000,1);
fluxmul_sum=zeros(10000,1);
fluxmul_sumv=zeros(10000,1);
%% 
% *AVERAGING OVER ALL REALIZATIONS*

for j=1:10000
    sum=0;
    sum11=0;
    for i=0:399
        sum= sum + u_velocity(j+i*10000,1);
        sum11= sum + v_velocity(j+i*10000,1);
    end
      u_avg(j)= sum/400;
      v_avg(j)= sum11/400;
end

%% 
% *FINDING THE FLUCTATING VALUES*

for k=0:399
    for c=1:10000
        u_fluctuation(c+k*10000)=u_velocity(c+k*10000)-u_avg(c);
        v_fluctuation(c+k*10000)=v_velocity(c+k*10000)-v_avg(c);
    end
end
%% 
% *PRODUCT OF THE FLUCTUATING VALUE AT SPECIFIED LOCATION WITH ALL OTHER VALUES*

for q=0:399
    for o=1:10000
        fluxmul(o+q*10000)=u_fluctuation(4740+10000*q)*u_fluctuation(o+q*10000);
        fluxmulv(o+q*10000)=v_fluctuation(4740+10000*q)*v_fluctuation(o+q*10000);
    end
end
%%
for j=1:10000
    sum1=0;
    sum12=0;
    for i=0:399
        sum1 = sum1 + fluxmul(j+i*10000,1);
        sum12 = sum12 + fluxmulv(j+i*10000,1);
    end
    fluxmul_sum(j)= sum1/400;
    fluxmul_sumv(j)= sum12/400;
end
%% 
% *FINDING THE RMS VALUES OF U FLUCTUATING VALUES*

Urmsval=zeros(10000,1);
for s = 1:10000
    for g = 0:399
        Uval(s,g+1) = u_fluctuation(s+g*10000,1); 
        Vval(s,g+1) = v_fluctuation(s+g*10000,1); 
    end
end

for h = 1:10000
    Urmsval(h) = rms(Uval(h,:));
    Vrmsval(h) = rms(Vval(h,:));
   
end
%% 
% *FINDING THE CORRELATING COEFFICIENT*

u_final=zeros(10000,1);
v_final=zeros(10000,1);
for v = 1:10000
    u_final(v) = fluxmul_sum(v)/(Urmsval(4740)^2);
    v_final(v) = fluxmul_sumv(v)/(Vrmsval(4740)^2);
end
%%
matrix=transpose(reshape(transpose(u_final),[100,100]));
matrix1=transpose(reshape(transpose(v_final),[100,100]));
%%
contour(Piv(1:100,1), Piv(10000:-100:1,2),matrix)
title("Contour")
xlabel("x (in mm)")
ylabel("y (in mm)" )
contour(Piv(1:100,1), Piv(10000:-100:1,2),matrix1)