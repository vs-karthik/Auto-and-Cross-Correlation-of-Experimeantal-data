clc;
clear all;
close all;
%%
Piv=load("PIVdata (1).txt");
u_value=Piv(:,3);
V_value=Piv(:,4);

%% 
% *PREALLOCATION*

fluctuating=zeros(100,400);
fluctuating_1=zeros(100,400);
a=zeros(40000,1);
b=zeros(40000,1);
u_rmsvalueflux=zeros(100,1);
v_rmsvalueflux=zeros(100,1);
u_avgvalue=zeros(100,1);
v_avgvalue=zeros(100,1);
y=zeros(100,1);

%% 
% *EXTRACTING U AND V VELOCITY VALUES FROM X=30MM. AND FINDING FLUCTUATING VALUES 
% OF U AND V*

p=40:100:4000000;
for h=1:40000
    k=p(h);
    a(h)=u_value(k);
    b(h)=V_value(k);
end
Matrix_1=reshape(a,[100,400]);
Matrix_2=reshape(b,[100,400]);

for i=1:100
    for j=1:400
        fluctuating(i,j)=Matrix_1(i,j)-mean(Matrix_1(i,:));
        fluctuating_1(i,j)=Matrix_2(i,j)-mean(Matrix_2(i,:));
    end
end

%%
p=1:100:10000;
for h=1:100
    y(h)=Piv(p(h),2);
end
%% 
% *FINDING THE AVERGAGE VLAUES OF U AND V VELOCITIES*

for l=1:100
    sum=0;
    sum1=0;
    for v=0:399
        sum=sum+a(l+v*100);
        sum1=sum1+b(l+v*100);
    end
    u_avgvalue(l)=sum/400;
    v_avgvalue(l)=sum1/400;
end


%% 
% *FINDING THE URMS OF U AND V FLUCTUATING VELOCITIES*

for l=1:100
    sum2=0;
    sum3=0;
    for v=1:400
        sum2=sum2+(fluctuating(l,v)*fluctuating(l,v));
        sum3=sum3+(fluctuating_1(l,v)*fluctuating_1(l,v));
    end
    u_rmsvalueflux(l)=sum2/400;
    v_rmsvalueflux(l)=sum3/400;
end

%%

plot(y,u_avgvalue)
title("U-AVERAGE at x=30 along Y=0")
xlabel("Y (in mm)")
ylabel("U-AVG VELOCITY")
plot(y,v_avgvalue)
title("V-AVERGAE at x=30 along Y=0")
xlabel("Y (in mm)")
ylabel("V-AVG VELOCITY")
plot(y,u_rmsvalueflux)
title("U RMS at x=30 along Y=0")
xlabel("Y (in mm)")
ylabel("U-RMS")
plot(y,v_rmsvalueflux)
title("V RMS at x=30 along Y=0")
xlabel("Y (in mm)")
ylabel("V-RMS")