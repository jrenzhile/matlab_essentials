function im = imPaintLabel(im, inds_label, color, strength)

[h, w, c] = size(im);

im = reshape(im, [], c);
im(inds_label, :) = (1-strength)*im(inds_label, :) + strength*repmat(color, length(inds_label), 1);
im = reshape(im, [h, w, c]);
