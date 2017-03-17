function im_withBoundary = drawBoundaries_paintPix(im, suppix, color, mkSize)

bmap=seg2bmap(suppix); 

colorMap = zeros(size(im));
for i = 1:3
    colorMap(:, :, i) = color(i);
end

if mkSize > 1
    bmap = imdilate(bmap, strel('disk', mkSize));
end

im_withBoundary = imPaintPix(im, colorMap, bmap, 1);





