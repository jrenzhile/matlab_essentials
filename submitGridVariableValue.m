function submitGridVariableValue(gridFileName, variable, value, execute)
% Change the value of a variable name in the grid script and execute the
% script immediately. Later the new script will be deleted.
%
% Important notes:
% - variable name and value need to be string structures.\
% - "excecute"=1 means excecuting it at once, otherwise the file will just
%   be saved for future usage.
% - Must cd to grid/
% Read original grid submission codes

if ~exist('execute', 'var')
    execute = 0;
end

gridFileName = sprintf('%s_grid_submit.sh', gridFileName);
if ~exist(['./' gridFileName], 'file')
    error('No such file or you are not in grid/');
end

gridSubmit_file = loadFile2Cell(gridFileName);
nlineToModify = findInCell(gridSubmit_file, sprintf('# Parameters'));
nlineToStop = findInCell(gridSubmit_file, sprintf('# MATLAB Path'));
if nlineToModify < 0 
    error('Please add a line called ''# Parameters'' in the grid submission script\n');
end
if nlineToStop < 0 
    error('Please add a line called ''# MATLAB Path'' in the grid submission script\n');
end

nlineToModify = nlineToModify + 1;
nlineToStop  = nlineToStop - 1;
flag = 0;
for i = nlineToModify:nlineToStop
    stringToModify = gridSubmit_file{i};
    if length(stringToModify) <= length(variable)
        continue;
    end
    if strcmp(stringToModify(1:length(variable)+1), [variable, '='])
        flag = 1;
        nlineToModify = i;
        break;
    end
end
if flag ==0
    error('No such variable in script');
end

stringToModify = gridSubmit_file{nlineToModify};
stringToModify(length(variable)+2:end) = [];
stringToModify = [stringToModify, value, ';'];

gridSubmit_file{nlineToModify} = stringToModify;
saveFileFromCell(gridSubmit_file, gridFileName);

if execute
    eval(sprintf('!chmod a+rx %s', gridFileName));
    eval(sprintf('!sh %s', gridFileName));
end




