function editGridScript(scriptName)

if ~exist(sprintf('%s_submit.sh', scriptName), 'file')
    error('File Does not Exist\n');
end

eval(sprintf('edit %s_submit.sh', scriptName));
eval(sprintf('edit %s_grid_driver.sh', scriptName));
eval(sprintf('edit %s_grid.m', scriptName));
