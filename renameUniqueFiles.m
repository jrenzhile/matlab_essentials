function renameUniqueFiles(loaddir, filenames, extension)

count = 0;
for i = 1:length(filenames)
    if exist(sprintf('%s/%d%s', loaddir, filenames(i), extension), 'file')
        count = count + 1;
        movefile(sprintf('%s/%d%s', loaddir, filenames(i), extension), sprintf('%s/%d%s', loaddir, count, extension))
    end
end

