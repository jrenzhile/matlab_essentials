function submitGridJobID(gridFileName, jobIds)
% Apply to cases where a certain number of jobs are not properly done or
% need to be recomputed. Just specify an array of job ids and pass to the
% script, and the script will generate temporary files to submit jobs with
% those ids.
%
% Important notes:
% - All the grid jobs are inside gridDir/ and follows the format of gridName_submit.sh
% - The submit job file need to have a line called '# Schedule job' to
% indicate the submit script. 
% - Must cd to grid/



% Read original grid submission codes
gridSubmit_file = loadFile2Cell(sprintf('%s_grid_submit.sh', gridFileName));
if ~exist(sprintf('./%s_grid_submit.sh', gridFileName), 'file')
    error('No such file or you are not in grid/');
end

nlineToModify = findInCell(gridSubmit_file, '# Schedule Job');

if nlineToModify < 0 
    error('Please add a line called ''# Schedule job'' in the grid submission script\n');
end


nlineToModify = nlineToModify + 1;
stringToModify = gridSubmit_file{nlineToModify};
newFileName = cell(length(jobIds), 1);

for i = 1:length(jobIds)
    cur_id = jobIds(i);
    cur_string = stringToModify;
    cur_split = strsplit(cur_string, ' ');
    indToModify = findInCell(cur_split, '-t');
    indToModify = indToModify + 1;
    cur_split{indToModify} = num2str(cur_id);
    gridSubmit_file{nlineToModify} = strjoin(cur_split, ' ');

    % Write cell into txt
    newFileName{i} =  sprintf('tmp%d_%s_grid_submit.sh', cur_id, gridFileName);
    saveFileFromCell(gridSubmit_file, newFileName{i});
    
    % submit job
    eval(sprintf('!chmod a+rx %s', newFileName{i}));
    eval(sprintf('!sh %s', newFileName{i}));
    delete(newFileName{i});
end




