function display_matrix(mat, spec)

if ~exist('spec', 'var')
    spec = '%.2f';
end

[H, W] = size(mat);

for i = 1:H
    for j = 1:W
        fprintf(spec, mat(i, j));
    end
    fprintf('\n');
end
