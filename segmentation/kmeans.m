% fusionPath = './co-fusion_result';
% fusionDir = dir([fusionPath,'\*.png']);
% 
% for i = 1:length(fusionDir)
%     img = imread([fusionPath,'\',fusionDir(i).name]);
%     filename = fusionDir(i).name;
%     level = graythresh(img);
%     ostuImg = imbinarize(img,level);
%     filepath = pwd;
%     cd('./Ostu_result');
%     imwrite(ostuImg,filename);
%     cd(filepath);
% end

fusionPath = './Dataset/MSRC/MSRC/images/House';
fusionDir = dir([fusionPath,'\*.jpg']);

img = imread([fusionPath,'\',fusionDir(7).name]);
[L,Centers] = imsegkmeans(img,12);
kmeansImg = labeloverlay(img,L);
imshow(kmeansImg);