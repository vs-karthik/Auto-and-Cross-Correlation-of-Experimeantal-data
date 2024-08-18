 clc;
 clear;
 close all;
%% 
% *AUTOCORRELATION*

hotwire=load("Hotwire.dat");
column1=hotwire(:,1);
column2=hotwire(:,2);
temp_variable=zeros(161,1);
temp_variable1=zeros(161,1);
fluctating=column2-mean(column2);
Urms=(rms(fluctating))^2;
tau=0:239999;
for j=1:161
    tau_value=tau(j);
    k=0;
    for i=1:(240000-tau_value)
        k=fluctating(i)*fluctating(i+tau_value)+k;
    end
    temp_variable(j)=(k/240000);
    temp_variable1(j)=temp_variable(j)/Urms;
end
%%
time=0:0.25:40;
plot(time,temp_variable1)
title("AUTOCORRELATION")
xlabel("LAGS")
ylabel("CORRELATION COEFFICIENT")

%% 
% *FINDING TIME INTEGRAL SCALE*

time=0:0.25:40;
y = temp_variable1;
n = length(time);
h = time(2) - time(1);
sum_odd = 0;
sum_even = 0;
for i = 2:2:n-1
    sum_even = sum_even + y(i);
end

for i = 3:2:n-2
    sum_odd = sum_odd + y(i);
end
area = (h/3) * (y(1) + 4*sum_odd + 2*sum_even + y(end));