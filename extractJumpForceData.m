
function all_JumpData = extractJumpForceData(numfiles, fileprefix, fz, all_JD) 
for Jump_File = 1:numfiles
    fname = sprintf('%s%02d.csv',fileprefix,Jump_File);
    fz = readmatrix(fname,'range', 'E6:E3896');
    fprintf('processing file type: %s/n', fname)
    all_JD{Jump_File} = fz;
end
all_JumpData = all_JD;
end