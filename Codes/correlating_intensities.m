clc;
clear;
close all;
%% 
% *EXTRACTING INTENSITY VALUES AT GIVEN LOCATION*

video = VideoReader('acm.MP4');
for img = 1:video.NumFrames
    filename = strcat('frame', num2str(img), '.jpg');
    image_data= imread(filename);
    x=[2260 1930 1580];
    y=[1397 1397 1397];
    pixel_data=impixel(rgb2gray(image_data),x,y);
    temp_1(img)=pixel_data(1,1);  
    temp_2(img)=pixel_data(2,1);
    temp_3(img)=pixel_data(3,1);
end
%% 
% *PREALLOCATION*

temp_variable2=zeros(1059,1);
temp_variable3=zeros(1059,1);
temp_variable4=zeros(1059,1);
temp_variable5=zeros(1059,1);
temp_variable6=zeros(1059,1);
temp_variable7=zeros(1059,1);
%%
fluctating1=temp_1-mean(temp_1);
fluctating2=temp_2-mean(temp_2);
fluctating3=temp_3-mean(temp_3);
%% 
% *AUTOCORRELATION AND CROSS-CORRELATION OF THE FLUCTUATING INTENSITY VALUES*

Urms1=(rms(fluctating1))^2;
Urms2=(rms(fluctating2))*rms(fluctating1);
Urms3=(rms(fluctating3))*rms(fluctating1);
tau1=1:1059;
for j=1:1059
    tau_value=tau1(j);
    k1=0;
    k2=0;
    k3=0;
    for i=1:(1059-tau_value)
        k1=fluctating1(i)*fluctating1(i+tau_value)+k1;
        k2=fluctating1(i)*fluctating2(i+tau_value)+k2;
        k3=fluctating1(i)*fluctating3(i+tau_value)+k3;
        s=i;
    end
    temp_variable2(j)=(k1/1059);
    temp_variable3(j)=temp_variable2(j)/Urms1;
    temp_variable4(j)=(k2/1059);
    temp_variable5(j)=temp_variable4(j)/Urms2;
    temp_variable6(j)=(k3/1059);
    temp_variable7(j)=temp_variable6(j)/Urms3;


end
%%
x=0:0.0333982041587:35.3353000000;
subplot(4,1,1)
plot(x,temp_variable3)
title("AUTOCORRELATION")
xlabel("LAGS")
ylabel("correlation coefficient")
subplot(4,1,2)
plot(x,temp_variable5)
title("CROSS-CORRELATION BETWEEN POINTS P1 AND P2")
xlabel("LAGS")
ylabel("correlation coefficient")
subplot(4,1,3)
plot(x,temp_variable7)
title("CROSS-CORRELATION BETWEEN POINTS P1 AND P3")
xlabel("LAGS")
ylabel("correlation coefficient")
max_time1=(find(temp_variable3==max(temp_variable3))-1)/29.970029970029970;
max_time2=(find(temp_variable5==max(temp_variable5))-1)/29.970029970029970;
max_time3=(find(temp_variable7==max(temp_variable7))-1)/29.970029970029970;
y=[0 350 700];
x=[max_time1,max_time2,max_time3];
subplot(4,1,4)
plot(x,y,"Marker","*")
title("DISTANCE-TIME")
xlabel("time")
ylabel("distance")
convection_vel=mean(gradient(y,x))