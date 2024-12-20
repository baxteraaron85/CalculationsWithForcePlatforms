function maximumDownwardDisplacement = calculateMaximumDownwardDisplacement (participant, takeoffIndex, timePeriod)
maximumDownwardDisplacement = zeros(1, participant);

for i = 1:participant

    % Loop through participants to calculate maximum displacement
    for i = 1:participants
       
        % Calculate time vector and velocity
        takeoffTime = takeoffIndex * timePeriod;

       displacement = cumtrapz(takeoffTime, displacement);

        % Store minimum velocity (maximum downward velocity)
        maximumDownwardDisplacement(i) = min(displacement);
    end

end