transfer_type = 'global_outlier';
ff = rdir('mats/*.mat');
f = fopen('tmp.txt','w');
fprintf(f, '<center><table border="1" align="center">\n');
fprintf(f, '<tr><td></td><td>global</td><td>%s</td></tr>\n', transfer_type);
num = 0;
for i = 1:length(ff)
    loaded_info = load(ff(i).name);
    [~, fname, ~] = fileparts(ff(i).name);
    imageTriplets = loaded_info.imageTriplets;
    
    for j = 1:length(imageTriplets)
        num = num+1;
        fprintf(f, '<tr>\n');
        fprintf(f, '<td>%s</td>\n', fname);
        fprintf(f, '<td><img src = "global/%s_%d.jpg" width="600"></td>\n', fname, j);
        fprintf(f, '<td><img src = "%s/%s_%d.jpg" width="600"></td>\n',transfer_type, fname, j);
        fprintf(f, '</tr>\n');
    end
end
fprintf(f, '</table></center>\n');
eval(sprintf('!mv tmp.txt %s.html', transfer_type));


