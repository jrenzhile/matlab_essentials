function genHTML(saveName, savedir, loaddir, ...
                 inds, prefixes, extensions, ...
                 title, columnTitle)
% generate a HTML of visualizations
% each row, img src follow the format of [loaddir]/[prefix][ind][extension]
% 
% prefixes and extensions are cell structures, each cell contains a pattern
% for images in each column.

f = fopen(sprintf('%s/%s.html', savedir, saveName), 'w');
fprintf(f, '<center><h2>%s</h2>\n', title);
fprintf(f, '<center><table border="1" align="center">\n');

fprintf(f, '<tr>\n');
fprintf(f, '<td>ID</td>\n');
for i = 1:length(columnTitle)
    fprintf(f, '<td align="center">%s</td>\n', columnTitle{i});
end
fprintf(f, '</tr>\n');

for i = 1:length(inds)
    cur_ind = inds(i);
    fprintf(f, '<tr>\n');
    fprintf(f, '<td>%d</td>\n', i);
    for ii = 1:length(extensions)
        fprintf(f, '<td><img src = "%s/%s%d%s" width="600"></td>\n', ...
            loaddir{ii}, prefixes{ii}, cur_ind, extensions{ii});
    end
    fprintf(f, '</tr>\n');
end
fprintf(f, '</table>\n</center>\n');
fclose(f);


