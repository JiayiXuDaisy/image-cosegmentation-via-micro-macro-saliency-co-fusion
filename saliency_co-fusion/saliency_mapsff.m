function [ ] = saliency_mapsff(df)


%para = makeDefaultParameters;
% parameters for global self-resemblance

param1.P = 3; % LARK window size
param1.alpha = 0.42; % LARK sensitivity parameter
param1.h = 0.2; % smoothing parameter for LARK
param1.L = 7; % # of LARK in the feature matrix 
param1.N = inf; % size of a center + surrounding region for computing self-resemblance
param1.sigma = 0.07; % fall-off parameter for self-resemblamnce. **For visual purpose, use 0.2 instead of 0.06**

%%
files=[dir([df '*.jpg']);dir([df '*.png']);dir([df '*.bmp']);dir([df '*.jpeg']);dir([df '*.tiff']);dir([df '*.gif'])];

mkdir(strcat(df,'/saliency_maps/sal1/'));
mkdir(strcat(df,'/saliency_maps/sal2/'));
mkdir(strcat(df,'/saliency_maps/sal3/'));
mkdir(strcat(df,'/saliency_maps/sal4/'));
mkdir(strcat(df,'/saliency_maps/sal5/'));
mkdir(strcat(df,'/saliency_maps/sal6/'));
%mkdir(strcat(df,'/saliency_maps/sal7/'));
%mkdir(strcat(df,'/saliency_maps/sal8/'));
mkdir(strcat(df,'/backups/'));


numel(files)

for k = 1:numel(files)
    FN = strcat(df,'/',files(k).name);
    RGB = imread(FN);
    [~,fl,ext]=fileparts(files(k).name);
    
    if ~strcmp(ext,'.jpg')
        imwrite(RGB,strcat(df,'/',fl,'.jpg'));
        movefile(FN,strcat(df,'/backups/',files(k).name));
        
    end
end
clear files;



%op=pwd;
%cd('./saliencydetection/');

gmf_sal(strcat(df,'/'),strcat(df,'/saliency_maps/sal1/'));
%cd(op);

cmd = [fullfile('./saliencydetection/ImgSaliency.exe') ' "' strcat(df,'/', '*.jpg') '" "' strcat(df,'/saliency_maps/sal2/') '"'];
    %end
    system(cmd);
    
    cmd = [fullfile('./saliencydetection/HSaliency.exe') ' "' strcat(df,'/', '*.jpg') '" "' strcat(df,'/saliency_maps/sal3/') '"'];
    
    system(cmd);



files=dir([df '*.jpg']);

for k = 1:numel(files)
    FN = strcat(df,'/',files(k).name);
    RGB = imread(FN);
    [~,fl,ext]=fileparts(files(k).name);
   

    
   movefile(strcat(df,'/saliency_maps/sal3/',fl,'_res.png'),strcat(df,'/saliency_maps/sal3/',fl,'.png'));
    
  
 
   smap4 = GetDSR(strcat(df,'/',files(k).name));
   imwrite(smap4,strcat(df,'/saliency_maps/sal4/',fl,'.png'));
   
   smap5 = GetGR(strcat(df,'/',files(k).name));
   imwrite(smap5,strcat(df,'/saliency_maps/sal5/',fl,'.png'));
   
   smap6 = GetRBD(strcat(df,'/',files(k).name));
   imwrite(smap6,strcat(df,'/saliency_maps/sal6/',fl,'.png'));
    
end

end

