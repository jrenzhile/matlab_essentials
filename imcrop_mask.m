function im = imcrop_mask(im, mask)
% Crop an image based on a given mask

[i, j] = find(mask);
im = im(min(i):max(i), min(j):max(j), :);

