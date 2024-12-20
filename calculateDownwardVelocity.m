function maximumDownwardVelocity = calculateDownwardVelocity(participants, jumpData, g, timePeriod, takeoffIndex, landingIndex)
    % Preallocate for maximum downward velocities
    maximumDownwardVelocity = zeros(1, participants); 

    % Loop through participants to calculate maximum downward velocity
    for i = 1:participants
        % Ensure jumpData contains sufficient data
        if length(jumpData{i}) < 50
            error('Not enough data in jumpData{%d}', i);
        end

        % Calculate mass and net force
        averageWeight = mean(jumpData{i}(1:50));
        Mass = averageWeight / g;
        takeOffForce = jumpData{i}(takeoffIndex:landingIndex);

        % Calculate time vector and velocity
        timeVector = (0:length(takeOffForce)-1) * timePeriod;
        netForce = takeOffForce - (Mass * g);
        velocity = cumtrapz(timeVector, netForce) / Mass;

        % Store minimum velocity (maximum downward velocity)
        maximumDownwardVelocity(i) = min(velocity);
    end
end
