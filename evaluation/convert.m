% %convert groundtruth
% gtPath = './GT_unit8/MSRC';
% gtDir = dir(gtPath);
% 
% for i = 3:length(gtDir)
%     imgDir = dir([gtPath,'/',gtDir(i).name,'/*.png']);
%     for j = 1:length(imgDir)
%         gt_unit8 = imread([gtPath,'/',gtDir(i).name,'/',imgDir(j).name]);
%         gt = im2bw(gt_unit8,0.5);
%         despath = ['./GT/MSRC','/',gtDir(i).name];
%         filepath = pwd;
%         cd(despath);
%         imwrite(gt,imgDir(j).name);
%         cd(filepath);
%     end
% end


%convert single segmentation result
gtPath = './Contour_result/MSRC_single_unit8';
gtDir = dir(gtPath);

for i = 3:length(gtDir)
    imgDir = dir([gtPath,'/',gtDir(i).name,'/*.jpg']);
    filepath = pwd;
    despath = ['./Contour_result/MSRC_single','/',gtDir(i).name];
    cd(despath);
    delete *.jpg;
    delete *.png;
    cd(filepath);
    for j = 1:length(imgDir)
        gt_unit8 = imread([gtPath,'/',gtDir(i).name,'/',imgDir(j).name]);
        gt = im2bw(gt_unit8,0.5);
        despath = ['./Contour_result/MSRC_single','/',gtDir(i).name];
        jpgfile = fullfile(gtPath,'/',gtDir(i).name,'/',imgDir(j).name);
        [path,name,ext] = fileparts(jpgfile);
        filepath = pwd;
        cd(despath);
        filename = strcat(name,'.png');
        imwrite(gt,filename);
        cd(filepath);
    end
end