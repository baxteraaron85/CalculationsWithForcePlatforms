function maximumDownwardDisplacement = calculateMaximumDownwardDisplacement (jumpData, participants, takeoffIndex, landingIndex, timePeriod, g)
maximumDownwardDisplacement = zeros(1, participants);

    % Loop through participants to calculate maximum displacement
    for i = 1:participants
        % Ensure jumpData contains sufficient data
        if length(jumpData{i}) < 50
            error('Not enough data in jumpData{%d}', i);
        end
       
        % Calculate velocity and displacement
        averageWeight = mean(jumpData{i}(1:50));
        Mass = averageWeight / g;
        takeOffForce = jumpData{i}(takeoffIndex:landingIndex);
        timeVector = (0:length(takeOffForce)-1) * timePeriod;
        netForce = takeOffForce - (Mass * g);
        velocity = cumtrapz(timeVector, netForce) / Mass;
        takeoffTime = takeoffIndex * timePeriod;

       displacement = cumtrapz(timeVector, velocity);

        % Store minimum velocity (maximum downward velocity)
        maximumDownwardDisplacement(i) = min(displacement);
    end

end