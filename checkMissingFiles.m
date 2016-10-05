function [fname_notExist, ind_notExist] = ...
    checkMissingFiles(dirName, extension, fname_inds)
% check if files are missing in a directory "dirName".
% "fname_inds" represent file ids, and can be any sequences of numbers.
% "extension" are the appending strings after each file id. For example, if
% a file name is 4_pattern.mat, then extension='_pattern.mat'.
%
% Returned values are the file ids that are missing and the indices.


    ind_notExist = zeros(length(fname_inds), 1);
    for i = 1:length(fname_inds)
        if ~exist(sprintf('%s/%d%s', dirName, fname_inds(i), extension), 'file')
            ind_notExist(i) = 1;
        end
    end
    
    
    ind_notExist = find(ind_notExist);
    fname_notExist = fname_inds(ind_notExist);


end