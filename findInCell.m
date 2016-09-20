function ind = findInCell(cell_struct, target)
% find the target string's index in a given cell with strings


ind = find(strcmp(cell_struct,target));
if (isempty(ind))
    ind = -1;
end
end