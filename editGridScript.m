function editGridScript(loaddir, scriptName)

if ~exist(sprintf('%s/%s_grid_submit.sh', loaddir, scriptName), 'file')
    error('File Does not Exist\n');
end

cur_dir = pwd;
cd(loaddir);
eval(sprintf('edit %s_grid_submit.sh', scriptName));
eval(sprintf('edit %s_grid_driver.sh', scriptName));
eval(sprintf('edit %s_grid.m', scriptName));
cd(cur_dir);