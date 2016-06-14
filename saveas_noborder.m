function saveas_noborder(fig_handle, savename,  additional_option)

[parent_folder, imname, ext] = fileparts(savename);
tmp_imname = sprintf('TMP_%s', imname);
tmp_fullname = sprintf('%s/%s%s', parent_folder, tmp_imname, ext);

saveas(fig_handle, tmp_fullname, additional_option);
im = imread(tmp_fullname);
im = crop_img_border(im);
imwrite(im, savename);
delete(tmp_fullname);
