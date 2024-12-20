function allImpulseParameters = findAllImpulseParameters(jumpData, participants, weightThreshold, baseThreshold, timePeriod, g)
    impulseDataArray = {}; % Preallocate as empty cell array

    for i = 1:participants
        % Check jumpData{i} content
        if isempty(jumpData{i}) || ~any(jumpData{i})
            warning('jumpData for participant %d is empty or contains only zeros', i);
            continue;
        end

        % Detect average weight
        averageWeight = mean(jumpData{i}(1:50));
        
        % Detect takeoff point
        takeoffIndex = find(jumpData{i} > averageWeight + weightThreshold, 1, 'first');
        if isempty(takeoffIndex)
            warning('No takeoff index found for participant %d', i);
            continue;
        end

        % Detect landing point
        landingIndices = find(jumpData{i}(takeoffIndex:end) < averageWeight + baseThreshold, 1, 'first');
        if isempty(landingIndices)
            warning('No landing index found for participant %d', i);
            continue;
        end
        landingIndex = landingIndices + takeoffIndex - 1;

        % Gather force data
        takeoffForce = jumpData{i}(takeoffIndex:landingIndex);

        % Time vector
        takeoffTime = (0:length(takeoffForce)-1) * timePeriod;

        % Calculate Impulse and initial velocity
        Mass = averageWeight / g;
        Impulse = trapz(takeoffTime, takeoffForce);
        initialVelocity = Impulse / Mass;

      impulseDataArray{i} = [takeoffIndex, landingIndex, Impulse, initialVelocity];

    end
    allImpulseParameters = impulseDataArray;
end
        
  
   


 