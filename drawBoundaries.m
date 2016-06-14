function [h,boundary_x, boundary_y]=drawBoundaries(im,suppix,color,mkSize)
% function drawBoundaries(I,suppix,color)
% 
% Draw boundaries induced by (over)segmentation in suppix on the image I;
% boundaries are drawn at true locations (between pixels) as dots of specified
% color
%
% If I is empty, just the boundaries are drawn on current figure axes (holding the
% previous content)
%
% Zhile Ren <jrenzhile@gmail.com>
% July 2012

if ~exist('color','var')
    color = 'k';
end

if ~exist('mkSize','var')
    mkSize = 1;
end

if (iscell(suppix))
  [h(1),boundary_x{1} boundary_y{1}]=drawBoundaries(im,suppix{1},color,mkSize);
  for s=2:length(suppix)
    [h(s),boundary_x{s} boundary_y{s}]=drawBoundaries([],suppix{s},color,mkSize);
  end
  return;
end


% get boundary map (shifted by 1/2 pixel)
bmap=seg2bmap(suppix); 

[boundary_x boundary_y]=find(bmap==1);



% if exist('gPb','var')
%     im_boundary=gPb;
%     for i=1:length(boundary_x)
%         im_boundary(boundary_x(i),boundary_y(i))=0.6;
%     end
%     imagesc(im_boundary); axis image;
% else
    if (~isempty(im))
       hold off;
       imagesc(im);axis image;axis off;
    end
    hold on
    h = plot(boundary_y,boundary_x,'s','Color', color,'MarkerSize',mkSize,'MarkerFaceColor',color);
    hold off
    return;
% end
