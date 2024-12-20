function jumpHeightWithImpulse = calculateJumpHeightWithImpulse(g, initialVelocity)
    % Ensure initialVelocity is a numeric array
    if iscell(initialVelocity)
        initialVelocity = cell2mat(initialVelocity); % Convert cell array to numeric array
    end

    % Adjust participants to match the length of initialVelocity
    actualParticipants = length(initialVelocity);

    % Preallocate the array for storing jump heights
    impulseJumpHeight = zeros(1, actualParticipants);

    % Loop over actual participants
    for i = 1:actualParticipants
        % Calculate the jump height for each participant
        impulseJumpHeight(i) = (initialVelocity(i)^2) / (2 * g);
    end

    % Return the array of jump heights
    jumpHeightWithImpulse = impulseJumpHeight;
end
