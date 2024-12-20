function timeOfflight = calculateTimeOfFlight (participants, allLandingFrames, allTakeOffFrames, timePeriod)
timeOfFlightValues = {};

for i = 1:participants
   timeOfFlightValues{i} = (allLandingFrames{i} - allTakeOffFrames{i})*timePeriod;
end
timeOfflight = timeOfFlightValues;
end

