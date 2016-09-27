function mkdir_ifnotexist(dirname)


if exist(dirname, 'dir')
    return;
else
    mkdir(dirname);
end
