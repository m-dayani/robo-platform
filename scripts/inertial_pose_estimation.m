%% Init. the environment

clc
clear
close all

ds_root = 'path\dataset';


%% Load the target sequence and data

n_mea_avg = 5;


%% IMU-Only (EuRoC, TUM-VI, Public Event)

sequence = 'boxes_6dof';
seq_root = [ds_root, '\', sequence];

ts_scale = 1e9;

imu_data = readmatrix([seq_root, '\imu.txt']);
ts_imu = imu_data(:,1) * ts_scale;
gyro_data = [ts_imu, imu_data(:,2:4)];
accel_data = [ts_imu, imu_data(:,5:7)];
mag_data = [-1, 0, 0, 0];
gps_data = [-1, 0, 0, 0];
pose_data = readmatrix([seq_root, '\groundtruth.txt']);

ts_table = -1 * ones(length(imu_data), 4);
ts_table(:, 1) = ts_imu;
ts_table(:, 2) = ts_imu;

% Initial Values
ref_loc = gps_data(1,2:4);
q0 = pose_data(1,5:8);
r0 = mean(gyro_data(1:n_mea_avg, 2:4));
p0 = pose_data(1,2:4);
v0 = zeros(1,3); %pose_data(1,9:11);
a0 = mean(accel_data(1:n_mea_avg, 2:4));
b_a0 = zeros(1,3); %pose_data(1,15:17);
b_g0 = zeros(1,3); %pose_data(1,12:14);
b_m0 = zeros(1,3);
m0 = zeros(1,3);

AccN = 2.0000e-3;
AccW = 3.0000e-03;
GyroN = 1.7e-4;
GyroW = 1.9393e-05;
% AccN = 0.0028;
% AccW = 0.00086;
% GyroN = 0.00016;
% GyroW = 2.2e-05;


%% ADVIO

sequence = 'advio-20';
seq_root = [ds_root, '\', sequence, '\iphone'];

ts_table = readmatrix([seq_root, '\ins_ts_table.txt']);

gyro_data = readmatrix([seq_root, '\gyro.csv']);
accel_data = readmatrix([seq_root, '\accelerometer.csv']);
mag_data = readmatrix([seq_root, '\magnetometer.csv']);
gps_data = readmatrix([seq_root, '\platform-locations.csv']);
pose_data = readmatrix([ds_root, '\', sequence, '\ground-truth\pose.csv']);

% correct timestamps
gyro_data(:,1) = gyro_data(:,1) * 1e9;
accel_data(:,1) = accel_data(:,1) * 1e9;
mag_data(:,1) = mag_data(:,1) * 1e9;
gps_data(:,1) = gps_data(:,1) * 1e9;
pose_data(:,1) = pose_data(:,1) * 1e9;

% correct gps data order
gps_swap = gps_data;
gps_data(:,4) = gps_swap(:,5);
gps_data(:,5) = gps_swap(:,4);

% Initial Values
ref_loc = gps_data(1,2:4);
q0 = [pose_data(1,5),pose_data(1,2:4)];
r0 = mean(gyro_data(1:n_mea_avg, 2:4));
p0 = pose_data(1,6:8);
v0 = pose_data(2,6:8)-pose_data(1,6:8);
a0 = mean(accel_data(1:n_mea_avg, 2:4));
b_a0 = [0.0407, -0.0623, 0.1017];
b_g0 = [-0.0067, 0.0070, -0.0065];
b_m0 = zeros(1,3);
m0 = mean(mag_data(1:n_mea_avg, 2:4));

AccN = 4.8e-3;
AccW = 2.1e-4;
GyroN = 2.4e-3;
GyroW = 5.1e-5;


%% Complex Urban

sequence = 'urban25-highway';
seq_root = [ds_root, '\', sequence, '\sensor_data'];

ts_table = readmatrix([seq_root, '\ins_ts_table.txt']);

imu_mag_data = readmatrix([seq_root, '\imu_mag.csv']);
gyro_data = [imu_mag_data(:,1), imu_mag_data(:,2:4)];
accel_data = [imu_mag_data(:,1), imu_mag_data(:,5:7)];
mag_data = [imu_mag_data(:,1), imu_mag_data(:,8:10)];
gps_data = readmatrix([seq_root, '\gps.csv']);
pose_data = readmatrix([ds_root, '\', sequence, '\global_pose.csv']);

% Initial Values
ref_loc = gps_data(1,2:4);
q0 = [1., 0., 0., 0.];
r0 = mean(gyro_data(1:n_mea_avg, 2:4));
p0 = [0, 0, 0];
v0 = [0, 0, 0];
a0 = mean(accel_data(1:n_mea_avg, 2:4));
b_a0 = [0., 0., 0.];
b_g0 = b_a0;
b_m0 = zeros(1,3);
m0 = mean(mag_data(1:n_mea_avg, 2:4));

AccN = 2.0000e-3;
AccW = 3.0000e-03;
GyroN = 1.7e-4;
GyroW = 1.9393e-05 ;


%% Robo-Platform

sequence = 'koohestan-park';
seq_root = [ds_root, '\', sequence];

ts_table = readmatrix([seq_root, '\ins_ts_table.txt']);

gyro_data = readmatrix([seq_root, '\imu\gyro_raw.txt']);
accel_data = readmatrix([seq_root, '\imu\accel.txt']);
mag_data = readmatrix([seq_root, '\magnetic_field\mag_raw.txt']);
gps_data = readmatrix([seq_root, '\gnss\fused_gps.txt']);

% merge biases
% accel_data(:, 2:4) = accel_data(:, 2:4) - accel_data(:, 5:7);
gyro_data(:, 2:4) = gyro_data(:, 2:4) - gyro_data(:, 5:7);
mag_data(:, 2:4) = mag_data(:, 2:4) - mag_data(:, 5:7);

% Initial Values
ref_loc = zeros(1,3);
if ~isnan(gps_data(1,1))
    gps_data(1,2:4);
end
q0 = [1., 0., 0., 0.];
r0 = mean(gyro_data(1:n_mea_avg, 2:4));
p0 = [0, 0, 0];
v0 = [0, 0, 0];
a0 = mean(accel_data(1:n_mea_avg, 2:4));
b_a0 = [0., 0., 0.];
b_g0 = b_a0;
b_m0 = zeros(1,3);
m0 = mean(mag_data(1:n_mea_avg, 2:4));

AccN = 0.00186;
AccW = 0.000433;
GyroN = 0.001309;
GyroW = 6.98e-05;   


%% Align data by creating a TS table: 
%% Use the create_ts_table.py to do this


%% Init. the async filter

fusionfilt = insfilterAsync('ReferenceLocation', ref_loc);


%% Init. state
% Note: PoseEstimationFromAcynchronousSensorsExample.m
% The states are:
%
%       States                          Units    Index
%    Orientation (quaternion parts)             1:4  
%    Angular Velocity (XYZ)            rad/s    5:7  
%    Position (NED)                    m        8:10 
%    Velocity (NED)                    m/s      11:13
%    Acceleration (NED)                m/s^2    14:16
%    Accelerometer Bias (XYZ)          m/s^2    17:19
%    Gyroscope Bias (XYZ)              rad/s    20:22
%    Geomagnetic Field Vector (NED)    uT       23:25
%    Magnetometer Bias (XYZ)           uT       26:28
%
% You need to find an initial estimate from the raw input data

initstate = zeros(28,1);
initstate(1:4) = q0;
initstate(5:7) = r0;
initstate(8:10) = p0;
initstate(11:13) = v0;
initstate(14:16) = a0;
initstate(17:19) = b_a0;
initstate(20:22) = b_g0;
initstate(23:25) = m0;
initstate(26:28) = b_m0;

fusionfilt.State = initstate;


%% Set the Process Noise Values of the |insfilterAsync|
% The process noise variance describes the uncertainty of the motion model
% the filter uses. 
fusionfilt.QuaternionNoise = 1e-2; 
fusionfilt.AngularVelocityNoise = GyroN;
fusionfilt.AccelerationNoise = AccN;
fusionfilt.MagnetometerBiasNoise = 1e-7;
fusionfilt.AccelerometerBiasNoise = AccW;
fusionfilt.GyroscopeBiasNoise = GyroW;


%% Define the Measurement Noise Values Used to Fuse Sensor Data
% Each sensor has some noise in the measurements. These values can
% typically be found on a sensor's datasheet. 
Rmag = 0.4;
Rvel = 0.01;
Racc = 610;
Rgyro = 0.76e-5;
Rpos = 3.4; 

fusionfilt.StateCovariance = diag(1e-3*ones(28,1));


%% Initialize Scopes
% The |HelperScrollingPlotter| scope enables plotting of variables
% over time. It is used here to track errors in pose. The
% |PoseViewerWithSwitches| scope allows 3D visualization of the filter
% estimate and ground truth pose. The scopes can slow the simulation. To
% disable a scope, set the corresponding logical variable to false.

useErrScope = false; % Turn on the streaming error plot.
usePoseView = true; % Turn on the 3D pose viewer.
if usePoseView
    posescope = PoseViewerWithSwitches(...
        'XPositionLimits', [-30 30], ...
        'YPositionLimits', [-30, 30], ...
        'ZPositionLimits', [-10 10]);
end
f = gcf;


%% Estimation loop

% ts order: gyro, accel, mag, gps

ts_scale = 1e-9;
ts_th = 0.01;
first_ts = -1.0;
last_ts = -1.0;
last_ts_vec = ones(1, 4) * -1.0;
max_len = length(ts_table);

ts_gyro = gyro_data(:, 1);
ts_accel = accel_data(:, 1);
ts_mag = mag_data(:, 1);
ts_gps = gps_data(:, 1);

for ii = 1:max_len
    
    ts_vec = ts_table(ii, :);
    curr_ts = mean(ts_vec(ts_vec >= 0));
    
    if first_ts < 0
        first_ts = curr_ts;
        last_ts = curr_ts;
        last_ts_vec = ts_vec;
        continue
    end
    
    if abs(curr_ts - last_ts) * ts_scale < ts_th
        last_ts = curr_ts;
        last_ts_vec = ts_vec;
        continue
    end
    
    dt = curr_ts - last_ts;
    last_ts = curr_ts;
    
    fusionfilt.predict(dt * ts_scale);
    
    if ts_vec(2) > 0
        [a, b] = max(ts_accel==ts_vec(2));
        fusionfilt.fuseaccel(accel_data(b,2:4), Racc);
    end
    
    if ts_vec(1) > 0
        [a, b] = max(ts_gyro==ts_vec(1));
        fusionfilt.fusegyro(gyro_data(b,2:4), Rgyro);
    end
    
    if ts_vec(3) > 0
        [a, b] = max(ts_mag==ts_vec(3));
        fusionfilt.fusemag(mag_data(b,2:4), Rmag);
    end
    
    if ts_vec(4) > 0
        [a, b] = max(ts_gps==ts_vec(4));
        gps_row = gps_data(b,:);
        % calculate speed from bearing
%         bearing_deg = gps_row(6);
%         bearing_ned = bearing_deg + 90;
%         if bearing_ned >= 360
%             bearing_ned = bearing_ned - 360;
%         end
%         bearing_rad = bearing_ned / 180 * pi;
%         vel = gps_row(5) * [cos(bearing_rad), sin(bearing_rad), 0];
        
        % fusion filter
        fusionfilt.fusegps(gps_row(2:4), Rpos);%, vel, Rvel);
    end
    
    % Plot the pose error
    [p,q] = pose(fusionfilt);
    posescope(p, q, [0, 0, 0], quaternion(1, 0, 0, 0));
end

max_dur = max([ts_gyro(end)-ts_gyro(1), ts_accel(end)-ts_accel(1), ...
    ts_mag(end)-ts_mag(1), ts_gps(end)-ts_gps(1)]);
tracking_pct = (curr_ts - first_ts) / max_dur;
display(tracking_pct)
