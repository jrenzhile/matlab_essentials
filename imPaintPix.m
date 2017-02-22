function im = imPaintPix(imTarget, imSource, imMask, strength)



[h, w, c] = size(imTarget);
inds_label = find(imMask);
im = reshape(imTarget, [], c);
imSource = reshape(imSource, [], c);
im(inds_label, :) = (1-strength)*im(inds_label, :) + strength*imSource(inds_label, :);
im = reshape(im, [h, w, c]);
