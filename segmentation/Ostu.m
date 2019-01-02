% %segmentation on fused saliency
% mainDir = './icoseg_fusion';
% subDir = dir(mainDir);
% 
% for i = 3:length(subDir)
%     subsubDir = [mainDir,'\',subDir(i).name,'\','co-fusion_result'];
%     fusionImg = dir([subsubDir,'\*png']);
%     desname = subDir(i).name;
%     for j = 1:length(fusionImg)
%         img = imread([subsubDir, '\',fusionImg(j).name]);
%         filename = fusionImg(j).name;
%         level = graythresh(img);
%         ostuImg = imbinarize(img,level);
%         filepath = pwd;
%         cd('./Ostu_result/icoseg');
%         cd(desname);
%         imwrite(ostuImg,filename);
%         cd(filepath);
%     end
% end

% %segmentation on single image
% mainDir = './Dataset/MSRC/MSRC/images';
% subDir = dir(mainDir);
% 
% for i = 3:length(subDir)
%     fusionImg = dir([mainDir,'\',subDir(i).name,'\*jpg']);
%     desname = subDir(i).name;
%     filepath = pwd;
%     cd('./Ostu_result/MSRC_single');
%     cd(desname);
%     delete *.jpg;
%     delete *.png;
%     cd(filepath);
%     for j = 1:length(fusionImg)
%         I = imread([mainDir,'\',subDir(i).name, '\',fusionImg(j).name]);
%         filename = fusionImg(j).name;
%         img = rgb2gray(I);
%         level = graythresh(img);
%         ostuImg = imbinarize(img,level);
%         filepath = pwd;
%         cd('./Ostu_result/MSRC_single');
%         cd(desname);
%         imwrite(ostuImg,filename);
%         cd(filepath);
%     end
% end

%segmentation on new confusion images
mainDir = './MSRC_new-co-fusion_result';
subDir = dir(mainDir);

for i = 3:length(subDir)
    fusionImg = dir([mainDir,'\',subDir(i).name,'\*png']);
    desname = subDir(i).name;
    filepath = pwd;
    cd('./Ostu_result/MSRC_new');
    cd(desname);
    delete *.jpg;
    delete *.png;
    cd(filepath);
    for j = 1:length(fusionImg)
        img = imread([mainDir,'\',subDir(i).name, '\',fusionImg(j).name]);
        filename = fusionImg(j).name;
        level = graythresh(img);
        ostuImg = imbinarize(img,level);
        filepath = pwd;
        cd('./Ostu_result/MSRC_new');
        cd(desname);
        imwrite(ostuImg,filename);
        cd(filepath);
    end
end
  