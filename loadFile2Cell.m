function loaded_cell = loadFile2Cell(filename)
% load an entile file into a cell structure, each element correspond to a
% line in the file.

    fid = fopen(sprintf('%s', filename),'r');

    if fid<0
        error('No such file');
    end

    i = 1;
    tline = fgetl(fid);
    loaded_cell{i} = tline;
    while ischar(tline)
        i = i+1;
        tline = fgetl(fid);
        loaded_cell{i} = tline;
    end
    fclose(fid);


end