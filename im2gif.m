function im2gif(outfilename, varargin)

% function im2gif(outfilename, varargin)
% 
% There are three ways to specify the input of gif

para.vid = [];
para.infilePath = '';
para.idxRange = [];
para.delayTime = 1;
para.colorIdxNo = 256;
para.fileList = [];
para = propval(varargin, para);

if ~isempty(para.vid)
    colorIf = length(size(para.vid)) == 4;
    if colorIf
        nfile = size(para.vid,4);
    else
        nfile = size(para.vid,3);
    end
elseif ~isempty(para.idxRange)
    nfile = length(para.idxRange);
elseif ~isempty(para.fileList)
    nfile = length(para.fileList);
end

for i=1:nfile
    if ~isempty(para.vid)
        if colorIf
            im = para.vid(:,:,:,i);
        else
            im = repmat(para.vid(:,:,i),[1,1,3]);
        end
    elseif ~isempty(para.idxRange)
        if isempty(para.infilePath)
            error('Missing parameter: infilePath');
        end
        im = imread(sprintf(para.infilePath, para.idxRange(i)));
    elseif ~isempty(para.fileList)
        im = imread(para.fileList{i});
    end
    [A,map] = rgb2ind(im,para.colorIdxNo,'nodither');
    if i==1
        imwrite(A,map,outfilename,'gif','LoopCount',Inf,'DelayTime',para.delayTime);
    else
        imwrite(A,map,outfilename,'gif','WriteMode','append','DelayTime',para.delayTime);
    end
end

end



















