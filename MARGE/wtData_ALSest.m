close all; clear all

systems = [164 281 268];
for zz = 1:length(systems)
    datasets = {'20230816_DG4_R1','20230817_DG4_R1','20231018_pulse'};
for seed = zz
%% Model
dt = 1/50;

%% Define state space model

load(['./Models/q' num2str(systems(zz)) '.mat'])
sysc = sys;
syscKF = sys;
clear sys

G = [0 0; 1 0; 0 0; 0 1];
H = zeros(3,2);

OBS = rank(obsv(sysc.A,sysc.C));

sysc_noise = ss(sysc.A,[sysc.B G],sysc.C,[sysc.D H]);                       % define continuous state space plant model with process noise
sys = c2d(sysc_noise,dt);                                                   % convert to discrete time ss with 1/50 time step

sysc_KF = ss(syscKF.A,[syscKF.B G],syscKF.C,[syscKF.D H]);                  % define continuous state space plant model with process noise
sysKF = c2d(sysc_KF,dt);                                                    % convert to discrete time ss with 1/50 time step

%% Wind Tunnel Data

load(['./Data/WT_post/q' num2str(systems(zz)) '/' datasets{seed}]);


[z,p,k] = butter(5,.5/25,'high');
[b,a] = zp2tf(z,p,k);

tt = t;
y_noise = [y(1,:)-mean(y(1,:)); y(2,:)-mean(y(2,:));filtfilt(b,a,y(3,:)-mean(y(3,:)))];


%% Load ALS  Q and R

load('./Results/Constrained/meanQR.mat');

Qest = diag([meanQ0{1,1}(end)+meanQq{1,1}(end)*systems(zz)/100,meanQ0{2,2}(end)+meanQq{2,2}(end)*systems(zz)/100]);                                                                                        % arbitrary guess of inital noise covariance
Rest = diag([meanRb{1,1}(end), meanRb{2,2}(end), meanR0{1,1}(end)+meanRq{1,1}(end)*systems(zz)/100]);

[kest,L,P,M] = kalman(sysKF,Qest,Rest);                                     % define kalman filter

%% Play Data through Suboptimal Estimator

[y_est,t_est,x_est] = lsim(kest,[u;y_noise],tt);  

x_hat = [];
y_hat = [];
y_tilde = [];
inn = [];

x_hat =  x_est';

% measurements
zy = y_noise;
zy_hat = sys.C*x_hat+sys.D(:,1:4)*u;

% innovations
inn = zy-zy_hat; 

figure 
ax1(1) = subplot(3,1,1);
plot(tt,zy(1,:))
hold on; grid on;
plot(tt, zy_hat(1,:),'-.')
legend('Measurement','Measurment Estimate','Location','NorthWest')
ylabel('\epsilon')


ax1(3) = subplot(3,1,2);
plot(tt,zy(2,:))
hold on; grid on;
plot(tt, zy_hat(2,:),'-.')
ylabel('\theta')


ax1(5) = subplot(3,1,3);
plot(tt,zy(3,:),':')
hold on; grid on;
plot(tt, zy_hat(3,:),'-.')
ylabel('n_z')
xlabel('Time (sec)')

S = syscKF.C*(P)*syscKF.C'+Rest;

figure 

ax1(2) = subplot(3,1,1);
plot(tt,zy(1,:)-zy_hat(1,:))
hold on; grid on;
plot(t,3*(sqrt(S(1,1)))*ones(length(x_hat),1),'--k');
plot(t,-3*(sqrt(S(1,1)))*ones(length(x_hat),1),'--k');
ylabel('inn_{\epsilon}')


ax1(4) = subplot(3,1,2);
plot(tt,zy(2,:)-zy_hat(2,:))
hold on; grid on;
plot(t,3*(sqrt(S(2,2)))*ones(length(x_hat),1),'--k');
plot(t,-3*(sqrt(S(2,2)))*ones(length(x_hat),1),'--k');
ylabel('inn_{\theta}')


ax1(6) = subplot(3,1,3);
plot(tt,zy(2,:)-zy_hat(2,:))
hold on; grid on;
plot(t,3*(sqrt(S(3,3)))*ones(length(x_hat),1),'--k');
plot(t,-3*(sqrt(S(3,3)))*ones(length(x_hat),1),'--k');
ylabel('inn_{n_z}')
xlabel('Time (sec)')

end
end