function saveFileFromCell(cellWithText, savename)

    fid = fopen(savename, 'w');
    if fid < 0 
        error('Cannot write to file');
    end
    for ii = 1:numel(cellWithText)
        if cellWithText{ii+1} == -1
            fprintf(fid,'%s', cellWithText{ii});
            break
        else
            fprintf(fid,'%s\n', cellWithText{ii});
        end
    end
    fclose(fid);
    
end