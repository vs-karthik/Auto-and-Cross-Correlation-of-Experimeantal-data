clc;
clear all;
close all;
%%
Piv=load("PIVdata (1).txt");
%%
U_values=Piv(:,3);
%%
j=1:10000:4000000;
u_values=zeros(400,1);
u_values1=zeros(400,1);
u_values2=zeros(400,1);
for i=0:length(j)-1
    u_values(i+1)=U_values(3840+i*10000,1);
    u_values1(i+1)=U_values(3844+i*10000,1);
    u_values2(i+1)=U_values(3848+i*10000,1);
end
u_meanvalue=mean(u_values);
u_meanvalue1=mean(u_values1);
u_meanvalue2=mean(u_values2);
for i=0:length(j)-1
    u_valuesflux(i+1)=U_values(3840+i*10000,1)-u_meanvalue;
    u_valuesflux1(i+1)=U_values(3844+i*10000,1)-u_meanvalue1;
    u_valuesflux2(i+1)=U_values(3848+i*10000,1)-u_meanvalue2;
end
%%
subplot(3,1,1)
x=1:400;
plot(x,u_values)
xlabel("no.of frames")
ylabel("instantaneous velocity")
subplot(3,1,2)
y=1:400;
plot(y,u_values1)
xlabel("no.of frames")
ylabel("instantaneous velocity")
subplot(3,1,3)
z=1:400;
plot(z,u_values2)
xlabel("no.of frames")
ylabel("instantaneous velocity")
%%

tiledlayout('flow')
nexttile
q=1:400;
plot(q,u_valuesflux)
xlabel("no.of frames")
ylabel("fluctuating velocity")
nexttile
n=1:400;
plot(n,u_valuesflux1)
xlabel("no.of frames")
ylabel("fluctuating velocity")
nexttile
t=1:400;
plot(t,u_valuesflux2)
xlabel("no.of frames")
ylabel("fluctuating velocity")