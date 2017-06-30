function image2animation_ren(file_name, save_name, delay)

for i=1:length(file_name)    
    a=imread(file_name{i});
    if size(a, 3) == 1
        a = cat(3, a, a, a);
    end
    [M, c_map]= rgb2ind(a,256);

    if i==1
        imwrite(M,c_map,save_name,'gif','LoopCount',65535,'DelayTime',delay)
    else
        imwrite(M,c_map,save_name,'gif','WriteMode','append','DelayTime',delay)
    end
end
