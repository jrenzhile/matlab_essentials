function vec_partitioned = partitionVector(vec, nPartition)

id_all = cell(1, nPartition);
cur_imgId = 1;
n_all = length(vec);
for i = 1:nPartition
    cur_imgId_max = min(cur_imgId + round(n_all/nPartition) - 1, n_all);
    if n_all - cur_imgId_max < round(n_all/nPartition)
        cur_imgId_max = n_all;
    end
    id_all{i} = cur_imgId:cur_imgId_max;
    cur_imgId = cur_imgId_max + 1;
    if cur_imgId >= n_all
        break;
    end
end

vec_partitioned = cell(1, nPartition);

for i = 1:nPartition
    vec_partitioned{i} = vec(id_all{i});
end
