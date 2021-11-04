%% Setup

clear;
clc;

%% Simulation parameters

% Power plant info
task1PPs = struct(...
    "filenames",    ["grid-config.txt", "circle-config.txt"], ...
    "lat",          37.442222, ...
    "lon",          -6.254167, ...
    "tz",           "Europe/Madrid", ...
    "startDate",    datetime(2021, 1, 1, "TimeZone", "Europe/Madrid"), ...
    "H",            50, ...
    "sigma",        6.0, ...
    "kappa",        0.21 ...
);

% Conditions and resolution
task1Params = struct(...
    "dt", 1.0, ...
    "variableWeather", false);

%% Task 1a: Compare two grid configurations

res = simulation(task1PPs, task1Params);


%% Plotting

f = figure(1);
hold on;
for i = 1:length(task1PPs.filenames)
    plot(1:task1Params.dt:24, res(i,:))
end
legend(task1PPs.filenames)
title("Comparison of mirror configurations, averaged over 1 year");
xlabel("T [hrs]");
ylabel("Hourly power output [MW]");


%% Task 1b: Determine how many mirrors are required for a yearly power output of 3000 MWh
requiredEnergy  = 3000;
dt              = task1Params.dt;
ppLs            = getL(task1PPs.filenames);

for i = 1:length(task1PPs.filenames)
    
    fprintf("Finding required mirrors for configuration: %s \n", task1PPs.filenames(i));
    yearlyEnergy            = sum(res(i, :) * dt * 365);
    currNumMirrors          = size(ppLs{i}, 1);
    fprintf("Current yearly energy and mirrors: %f, %i \n", yearlyEnergy, currNumMirrors);
    mirrorsRequired         = int8(requiredEnergy / yearlyEnergy * currNumMirrors);
    fprintf("Required mirrors: %i \n", mirrorsRequired)
end

%% Task 2:

task2Params = struct(...
    "dt", 0.25, ...
    "variableWeather", true);

res2 = simulation(task1PPs, task2Params);

%% Plotting

g = figure(2);
hold on;
for i = 1:length(task1PPs.filenames)
    plot(1:task2Params.dt:24, res2(i,:))
end
legend(task1PPs.filenames)
title("Weather comparison");
xlabel("T [hrs]");
ylabel("Hourly power output [MW]");

%% Background

hArr = [];

for i = 1:length(task1PPs.filenames)
    h(i) = plotLocationOfHeliostats(task1PPs.filenames(i));
end