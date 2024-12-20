function allTakeOffFrames = findAllInitialTakeoffPoints(jumpData, numfiles)
frameDataArray ={};

for i = 1:numfiles
    Frame_of_takeoff = find(jumpData{i} == 0, 1, 'first'); 
    frameDataArray{i} = Frame_of_takeoff;
end

    allTakeOffFrames = frameDataArray;
end

