function [timeOfFlight, jumpHeight] = calculateTimeOfFlightAndJumpHeight(participants, allLandingFrames, allTakeOffFrames, timePeriod, gravity)
timeOfFlightValues = zeros(1, participants); % Vector for Time of Flight
jumpHeightUsingTimeOffFlight = zeros(1, participants);   % Vector for Jump Height

for i = 1:participants
 % Check if the current elements are valid
        if ~isempty(allLandingFrames{i}) && ~isempty(allTakeOffFrames{i})
            % Ensure the data contains only one element
            if numel(allLandingFrames{i}) == 1 && numel(allTakeOffFrames{i}) == 1
                % Perform calculations
                timeOfFlight(i) = (allLandingFrames{i} - allTakeOffFrames{i}) * timePeriod;
                jumpHeight(i) = (gravity * timeOfFlight(i).^2) / 8;
            else
                warning('Participant %d has invalid data dimensions.', i);
                timeOfFlight(i) = NaN;
                jumpHeight(i) = NaN;
            end
        else
            warning('Participant %d has missing data.', i);
            timeOfFlight(i) = NaN;
            jumpHeight(i) = NaN;
end
end
end
