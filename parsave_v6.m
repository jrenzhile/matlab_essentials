function parsave_v6(fname,varargin)
    numvars=numel(varargin);
    for i=1:numvars
	   eval([inputname(i+1),'=varargin{i};']);
    end
    
    if ~exist(fname,'file')
        save('-mat',fname,inputname(2), '-v6');
    else
        save('-mat',fname,inputname(2), '-append');
    end
    
	for i = 2:numvars    
		save('-mat',fname,inputname(i+1),'-append');
	end
end