function ind = sub2ind_fast2(siz, i, j)
% Fast replacement of SUB2IND (Linear index from multiple subscripts)
% in dimension 2; no check is performed.
    ind = i + (j-1)*siz(1);
end
