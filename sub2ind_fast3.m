function ind = sub2ind_fast3(siz, i, j, k)
% Fast replacement of SUB2IND (Linear index from multiple subscripts)
% in dimension 3; no check is performed.
    ind = i + (j-1)*siz(1) + (k-1)*siz(1)*siz(2);
end
