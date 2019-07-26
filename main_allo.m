%%%%%%%%%%%%%%%%%%%  Q -Learning Based Power Control Algorithm  %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%  for D2D Communication  %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                                 
%%% Author   : Pranay & D.Nikhil
%%% Roll no  : EE15RESCH11001 & EE15MTECH11021
%%%                                                                     
%%% Input:                                                              
%%%     % Speech Input.txt                                           
%%% Output:                                                        
%%%     % CVSD Encoded output bits  
%%%
%% Initalization of distance
clc;
clear all;
close all;
N=10; % number of D2D user
r=200+250*rand(1,N);
theta=360*rand(1,N);
phi=60*rand(1,N);
dist=25+25*rand(1,N);
dtx=r.*cosd(theta);
dty=r.*sind(theta);
drx=dtx+dist.*cosd(phi);
dry=dty;
bs_x=0;
bs_y=0;
len=200*rand(1);
angle=rand(1);
cx=len*cosd(angle);
cy=len*sind(angle);
theta2=0:360;
x1=500.*cosd(theta2);
y1=500.*sind(theta2);
figure();
plot(x1,y1,'k-');
hold all; grid on;
plot(dtx,dty,'^');
plot(drx,dry,'v');
plot(bs_x,bs_y,'o');
plot(cx,cy,'sq');
a=2:22;
%% interference calculation
P=23*ones(1,N);
[BI, DI]=SINR(P,dtx,dty,drx,dry,cx,cy);
%% distributed algorithm
Q=zeros(2,length(a),N);
