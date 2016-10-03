function seg_map_new = constructUniqueLabelMap(seg_map)
% from a label map, extract unique elements and re-assign its label as
% continuous integer labels

unique_seg = unique(seg_map(:));
seg_map_new = zeros(size(seg_map));

for i = 1:length(unique_seg)
    seg_map_new(seg_map==unique_seg(i)) = i;
end

if min(unique_seg) == 0
    seg_map_new = seg_map_new - 1;
end