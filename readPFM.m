function im = readPFM(infile)

% function im = readPFM(infile)

fid = fopen(infile, 'r');
str = fgetl(fid);
if sum(findstr(str, 'PF'))>0
    c = 3;
else
    c = 2;
end
dims = fgetl(fid);
scale = fgetl(fid);
dims = sscanf(dims, '%d %d');
w = dims(1); h = dims(2); 
if c==3
    
    im = reshape(fread(fid,prod(dims*3),'float=>double',0,'n'),[w,h,3])';
    im = im(end:-1:1,:, :);
else
    im = reshape(fread(fid,prod(dims),'float=>double',0,'n'),[w,h])';
    im = im(end:-1:1,:);
end
fclose(fid);
end




