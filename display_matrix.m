function display_matrix(mat)

[H, W] = size(mat);

for i = 1:H
    for j = 1:W
        fprintf('%.2f ', mat(i, j));
    end
    fprintf('\n');
end
