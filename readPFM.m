function im = readPFM(infile)

% function im = readPFM(infile)

fid = fopen(infile, 'r');
str = fgetl(fid);
dims = fgetl(fid);
scale = fgetl(fid);
dims = sscanf(dims, '%d %d');
scale = sscanf(scale, '%f');
w = dims(1); h = dims(2);
im = reshape(fread(fid,prod(dims),'float=>double',0,'n'),[w,h])';
im = im(end:-1:1,:);
fclose(fid);

end




