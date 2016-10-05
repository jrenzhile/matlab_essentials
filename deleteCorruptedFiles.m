function deleteCorruptedFiles(loaddir, isDelete)
% delete all the corrupted files in directory "loaddir". If "isDelete==0",
% it will only output the corrupted file info

if ~exist('isDelete', 'var')
    isDelete = 1;
end

warning('off','all')
fnames_all = dir(sprintf('%s/*.mat', loaddir));

for i = 1:length(fnames_all)
    cur_name = sprintf('%s/%s', loaddir, fnames_all(i).name);
    try
        tmp = load(cur_name, 'tmpTestVariable');
    catch
        if isDelete
            delete(cur_name);
            fprintf('Deleted %s\n', cur_name);
        else
            fprintf('%s\n',fnames_all(i).name);
        end
    end
    if mod(i, round(length(fnames_all)/10)) == 0
        fprintf('.');
    end
end
fprintf('\n');

warning('on','all')

end