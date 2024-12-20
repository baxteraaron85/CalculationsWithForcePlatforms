function allLandingFrames = findAllInitialLandingPoints(jumpData, numfiles, allTakeOffFrames)
allLandingPoints = {};
for i = 1:numfiles
    % Find the landing frame, finds first number after takeoff that isnt
    % equal to zero
    Frame_of_landing = find(jumpData{i}(allTakeOffFrames{i}+1:end) ~= 0, 1, 'first') + allTakeOffFrames{i};
    allLandingPoints{i} = Frame_of_landing;
    % Display or store results 

end
allLandingFrames = allLandingPoints;
end