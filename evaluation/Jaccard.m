% gtPath = './GT/MSRC';
% ostuPath = './Ostu_result/MSRC_new';
% contourPath = './Contour_result/MSRC_new';
% gtDir = dir(gtPath);
% ostuDir = dir(ostuPath);
% contourDir = dir(contourPath);
% 
% % for i = 3:length(ostuDir)
% %     imgDir = dir([ostuPath,'\',ostuDir(i).name,'\*.png']);
% %     gtimgDir = dir([gtPath,'\',gtDir(i).name,'\*.png']);
% %     for j = 1:length(imgDir)
% %         ostuImg = imread([ostuPath,'\',ostuDir(i).name,'\',imgDir(j).name]);
% %         gt = imread([gtPath,'\',ostuDir(i).name,'\',imgDir(j).name]);
% %         sim_pic(j) = jaccard(ostuImg,gt);
% %     end
% %     sim_set(i) = mean(sim_pic(:));
% % end
% 
% for i = 3:length(contourDir)
%     imgDir = dir([contourPath,'\',contourDir(i).name,'\*.png']);
%     gtimgDir = dir([gtPath,'\',gtDir(i).name,'\*.png']);
%     for j = 1:length(imgDir)
%         contourImg = imread([contourPath,'\',contourDir(i).name,'\',imgDir(j).name]);
%         gt = imread([gtPath,'\',contourDir(i).name,'\',imgDir(j).name]);
%         sim_pic(j) = jaccard(contourImg,gt);
%     end
%     sim_set(i) = mean(sim_pic(:));
% end

imgDir = './pre/seg_contour_new.png';
gtDir = './GT/MSRC/Cat/img_1017.png';

img = imread(imgDir);
gt = imread(gtDir);
sim_pic = jaccard(img,gt);