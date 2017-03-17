function genGridScript(saveLoc, saveName, isEditGrid)

fname_submit = sprintf('%s_submit.sh', saveName);
fname_driver = sprintf('%s_grid_driver.sh', saveName);
fname_code = sprintf('%s_grid.m', saveName);
if exist(fname_code, 'file')
    fprintf('File already exist\n');
    return;
end

% generate file to submit to grid
f = fopen([saveLoc, '/', fname_submit], 'w');
fprintf(f, '#! /bin/sh\n');
fprintf(f, '# Bash script for sumbitting matlab jobs to an SGE cluster queue.\n\n');
fprintf(f, '# Parameters\n');
fprintf(f, 'NGT=1;\n');
fprintf(f, 'savedir=''savedir'';\n\n\n');
fprintf(f, '# MATLAB Path\n');
fprintf(f, 'matlabpath=''/local/projects/matlab/R2016b/bin''\n\n');
fprintf(f, '# Schedule Job\n');
fprintf(f, 'qsub -t 1:$NGT -l "inf" %s $matlabpath $savedir \n\n', fname_driver);
fprintf(f, '# Use for benchmarking\n');
fprintf(f, '# qsub -pe smp 2 -q ''*@@ang'' -l arch=lx26-amd64 \n\n');
fprintf(f, '# Option explanations:\n');
fprintf(f, '#  Mail Option (-m bea):  trigger email alerts at beginning, end, and aborting of jobs\n');
fprintf(f, '#  Arch Option: (-l arch=...):  make sure 64 bit machines only\n');
fprintf(f, '#  Batch option: (-t 1-3): submit array of jobs, each numbered 1,2, or 3\n');
fclose(f);
eval(sprintf('!chmod a+x %s/%s', saveLoc, fname_submit));

% generate file of grid drivers
f = fopen([saveLoc, '/', fname_driver], 'w');
fprintf(f, '#!/bin/sh\n');
fprintf(f, '#$ -S /bin/sh\n');
fprintf(f, '#$ -cwd\n');
fprintf(f, '#$ -r y\n');
fprintf(f, '#$ -o ../../log/$JOB_ID.$TASK_ID.out\n');
fprintf(f, '#$ -e ../../log/$JOB_ID.$TASK_ID.err\n\n');
fprintf(f, 'echo "JOB ID: " $JOB_ID\n');
fprintf(f, 'echo "SGE TASK ID: "$SGE_TASK_ID\n\n');
fprintf(f, '# run\n');
fprintf(f, 'matlabpath=$1\n');
fprintf(f, 'echo "LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libstdc++.so.6 $matlabpath/matlab -nodesktop -nojvm -nodisplay -nosplash -r"\n');
fprintf(f, 'echo "cd ../;init_setup; %s_grid(''$SGE_TASK_ID'', ''$2'', ''$3'', ''$4'', ''$5'', ''$6'', ''$7'', ''$8'', ''$9'', ''${10}'', ''${11}''); exit;"\n', saveName);
fprintf(f, '      LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libstdc++.so.6 $matlabpath/matlab -nodesktop -nojvm -nodisplay -nosplash -r \\\n');
fprintf(f, '    "cd ../; init_setup; %s_grid(''$SGE_TASK_ID'', ''$2'', ''$3'', ''$4'', ''$5'', ''$6'', ''$7'', ''$8'', ''$9'', ''${10}'', ''${11}''); exit;"\n', saveName);
fprintf(f, 'echo "all done"\n');
fprintf(f, 'exit\n');
fclose(f);
eval(sprintf('!chmod a+x %s/%s', saveLoc, fname_driver));



% generate file of grid code
f = fopen([saveLoc, '/', fname_code], 'w');
fprintf(f, 'function %s_grid( ...\n', saveName);
fprintf(f, '  idx, ...\n');
fprintf(f, '  savedir)\n\n');
fprintf(f, '  tic;\n');
fprintf(f, '    %% convert parameters\n');
fprintf(f, '    idx = str2num(idx);\n\n');
fprintf(f, '    fprintf(''idx = %%d\\n'', idx);\n');
fprintf(f, '    fprintf(''savedir = %%s\\n'', savedir);\n\n\n');
fprintf(f, '    fprintf(''Saved to %%s, Matlab Done\\n'', savedir);\n');
fprintf(f, '    toc;\n\n');
fprintf(f, 'end');
fclose(f);

if ~exist('isEditGrid', 'var')
    isEditGrid = 1;
end

if isEditGrid
    editGridScript(saveLoc, saveName);
end