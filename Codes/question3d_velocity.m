clc;
clear all;
close all;
%%
piv=load("PIVdata (1).txt");
%%
p1 = zeros(400,4);
p2 = zeros(400,4);
p3 = zeros(400,4);
%% 
% EXTRACTING THE 

for pt = 0:399
    p1(pt+1,:) = piv(3840+(pt*10000),:);
    p2(pt+1,:) = piv(3844+(pt*10000),:);
    p3(pt+1,:) = piv(3848+(pt*10000),:);
end
%%
Uvel1=p1(:,3);
Uvel2=p2(:,3);
Uvel3=p3(:,3);
U1temp=zeros(400,1);
Utemp1=zeros(399,1);
U2temp=zeros(400,1);
Utemp2=zeros(399,1);
U3temp=zeros(400,1);
Utemp3=zeros(399,1);
U1fluctating=Uvel1-mean(Uvel1);
U1rms=(rms(U1fluctating));
U2fluctating=Uvel2-mean(Uvel2);
U2rms=(rms(U2fluctating));
U3fluctating=Uvel3-mean(Uvel3);
U3rms=(rms(U3fluctating));
Utau=0:399;
for Uj=1:400
    Utau_value=Utau(Uj);
    Uk1=0;
    Uk2=0;
    Uk3=0;
    for Ui=1:(400-Utau_value)
        Uk1=U1fluctating(Ui)*U1fluctating(Ui+Utau_value)+Uk1;
        Uk2=U1fluctating(Ui)*U2fluctating(Ui+Utau_value)+Uk2;
        Uk3=U1fluctating(Ui)*U3fluctating(Ui+Utau_value)+Uk3;
    end
    U1temp(Uj)=(Uk1/400);
    Utemp1(Uj)=U1temp(Uj)/(U1rms*U1rms);
    U2temp(Uj)=(Uk2/400);
    Utemp2(Uj)=U2temp(Uj)/(U1rms*U2rms);
    U3temp(Uj)=(Uk3/400);
    Utemp3(Uj)=U3temp(Uj)/(U1rms*U3rms);
    

end

%%
Ux=0:0.0027:0.0081;
subplot(4,1,1)
plot(Ux,Utemp1(1:4,1))
title("AUTOCORRELATION OF P1")
xlabel("LAGS IN SEC")
ylabel("Correlation Coefficient")
subplot(4,1,2)
plot(Ux,Utemp2(1:4,1))
title("CROSS-CORRELATION OF P1 AND P2 ")
xlabel("LAGS IN SEC")
ylabel("Correlation Coefficient")
subplot(4,1,3)
plot(Ux,Utemp3(1:4,1))
title("CROSS-CORRELATION OF P1 AND P3 ")
xlabel("LAGS IN SEC")
ylabel("Correlation Coefficient")
subplot(4,1,4)
a = plot([(find(Utemp1 == max(Utemp1))-1)/364,(find(Utemp2 == max(Utemp2))-1)/364],0:3:3);
title("DISTANCE - TIME PLOT")
xlabel("time (in sec)")
ylabel("Distance (in mm)")
max_time1=(find(Utemp1 == max(Utemp1))-1)/(364);
max_time2=(find(Utemp2 == max(Utemp2))-1)/(364);
y=[max_time1,max_time2];
x=[0 3];
convection_velocity=mean(gradient(x,y));