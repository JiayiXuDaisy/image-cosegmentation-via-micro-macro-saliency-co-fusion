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
%         mask = zeros(size(img));
%         mask(25:end-25,25:end-25) = 1;
%         contourImg = activecontour(img,mask,300);
%         filepath = pwd;
%         cd('./Contour_result/icoseg');
%         cd(desname);
%         imwrite(contourImg,filename);
%         cd(filepath);
%     end
% end

% %segmentation on single image
% mainDir = './Dataset/iCoseg/dataset_public/images';
% subDir = dir(mainDir);
% 
% for i = 3:length(subDir)
%     fusionImg = dir([mainDir,'\',subDir(i).name,'\*jpg']);
%     desname = subDir(i).name;
%     filepath = pwd;
%     cd('./Contour_result/icoseg_single');
%     cd(desname);
%     delete *.jpg;
%     delete *.png;
%     cd(filepath);
%     for j = 1:length(fusionImg)
%         I = imread([mainDir,'\',subDir(i).name, '\',fusionImg(j).name]);
%         filename = fusionImg(j).name;
%         img = rgb2gray(I);
%         mask = zeros(size(img));
%         mask(25:end-25,25:end-25) = 1;
%         contourImg = activecontour(img,mask,300);
%         filepath = pwd;
%         cd('./Contour_result/icoseg_single');
%         cd(desname);
%         imwrite(contourImg,filename);
%         cd(filepath);
%     end
% end


%segmentation on new cofusion images
mainDir = './MSRC_new-co-fusion_result';
subDir = dir(mainDir);

for i = 3:length(subDir)
    fusionImg = dir([mainDir,'\',subDir(i).name,'\*png']);
    desname = subDir(i).name;
    filepath = pwd;
    cd('./Contour_result/MSRC_new');
    cd(desname);
    delete *.jpg;
    delete *.png;
    cd(filepath);
    for j = 1:length(fusionImg)
        img = imread([mainDir,'\',subDir(i).name, '\',fusionImg(j).name]);
        filename = fusionImg(j).name;
        mask = zeros(size(img));
        mask(25:end-25,25:end-25) = 1;
        contourImg = activecontour(img,mask,300);
        filepath = pwd;
        cd('./Contour_result/MSRC_new');
        cd(desname);
        imwrite(contourImg,filename);
        cd(filepath);
    end
end