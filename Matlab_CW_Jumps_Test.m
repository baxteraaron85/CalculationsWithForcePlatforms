clear all
close all
clc

%% Constant Parameters

masterDataSheet = input("Enter the file path for the master data sheet (or press Enter to use default):\n ")

if ~isempty(masterDataSheet) % Check if varargin has input
    inputMasterDataSheet = masterDataSheet; % Use the first argument from varargin
else
    inputMasterDataSheet = "Group D master spreadsheet(Sheet1).csv"; % Use the default file name
end

forcePlatformDataSheet = input("Enter the folder name that contains all force platform data sheets (or press Enter to use default):\n ")

if ~isempty(forcePlatformDataSheet) % Check if varargin has input
    inputForcePlatformDataFolder = forcePlatformDataSheet; % Use the second argument from varargin
else
    inputForcePlatformDataFolder = "New Folder\test01.csv"; % Use a specified folder name
end

fz = readmatrix(inputForcePlatformDataFolder, 'range', 'E6:E3864'); %Jump data


masterFileParticipant = readmatrix(inputMasterDataSheet, "Range", "B:B");%Participant
masterFileParticipant = masterFileParticipant(~isnan(masterFileParticipant));

masterFileJumptype = readmatrix(inputMasterDataSheet, 'Range', 'C:C'); %1 = CM, 2 = SJ
masterFileJumptype = masterFileJumptype(~isnan(masterFileJumptype));

numfiles = 100;

fileprefix = 'test';

all_JD = {};

g = 9.81;

Freq = 1000;

timePeriod = 1/Freq; %Sampling rate is 1000Hz, to change into t is 0.001s

%% Functions for collecting relevant data
jumpData = extractJumpForceData(numfiles, fileprefix, fz, all_JD);
allTakeOffFrames = findAllInitialTakeoffPoints(jumpData, numfiles);
allLandingFrames = findAllInitialLandingPoints (jumpData, numfiles, allTakeOffFrames);


%% Calculating jump height using time of flight method

[timeOfFlight, jumpHeight] = calculateTimeOfFlightAndJumpHeight(100, allLandingFrames, allTakeOffFrames, timePeriod, g);

%% Parameters for calculating jump height using impulse
baseThreshold = 0.1; %Smooth results to ensure correct integration
weightThreshold = 10; %Range of weight values

allImpulseParameters = findAllImpulseParameters(jumpData, 100, weightThreshold, baseThreshold, timePeriod, g);
splitparamsMatrix = cell2mat(allImpulseParameters');
columnLabels = {'TakeoffIndex', 'LandingIndex', 'Impulse', 'InitialV0'}
dataTable = array2table(splitparamsMatrix, "VariableNames",columnLabels);
disp(dataTable)

%%Extracting data
initialVelocity = dataTable.InitialV0;
takeoffIndex = dataTable.TakeoffIndex;
landingIndex = dataTable.LandingIndex;
impulse = dataTable.LandingIndex;


%% Calculating jump height using impulse method
jumpHeightWithImpulse = calculateJumpHeightWithImpulse(g, initialVelocity)';

%% Calculating maximum downward velocity
maximumDownwardVelocity = calculateDownwardVelocity (100, jumpData, g, timePeriod, takeoffIndex, landingIndex);

%% Paremeters for displacement
maximumDownwardDisplacement = calculateMaximumDownwardDisplacement(jumpData, 100, takeoffIndex, landingIndex, timePeriod, g);

%% Parameters for mean and SD
Jump_type = masterFileJumptype;
Participant = masterFileParticipant;














