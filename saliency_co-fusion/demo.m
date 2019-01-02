%warning('off');
addpath(genpath('./grabcut/'));
addpath(genpath('./mdaisy-v1.0/'));
addpath(genpath('./saliencydetection/'));

Tau_parameter=0.75;
globals;
run('./vlf2\vlfeat-0.9.17\toolbox\vl_setup');


  db='./data/';
  db_ar={'women','cow'};
%   fl=dir(db);
%   clear db_ar;
% for k=3:numel(fl)
%     fl(k).name
%      
%     db_ar{k-2}=fl(k).name;
% end
%  delete([tmp_dir '/*']);
for vb=1:numel(db_ar)
image_dir = strcat(db,'\',db_ar{vb},'\');
saliency_mapsff(image_dir);
addpath(genpath(image_dir));


mkdir(strcat(image_dir,'/otsuseg/'));
mkdir(strcat(image_dir,'/otsumask/'));
mkdir(strcat(image_dir,'/grabseg/'));
mkdir(strcat(image_dir,'/grabmask/'));
mkdir(strcat(image_dir,'/co-fusion_result/'));
addpath(strcat(image_dir,'/otsuseg/'));
addpath(strcat(image_dir,'/otsumask/'));
addpath(strcat(image_dir,'/grabseg/'));
addpath(strcat(image_dir,'/grabmask/'));
addpath(strcat(image_dir,'/co-fusion_result/'));


para4=10;
disp('Generate list of images...');
im_list = {};
D = [dir([image_dir '*.jpg']);dir([image_dir '*.bmp'])];
j=1;

    param.imageSize = [256 256];
    param.orientationsPerScale = [8 8 8 8];
    param.numberBlocks = 4;
    param.fc_prefilt = 4;
    gist_ar=zeros(numel(D),512);
    numel(D)
for i=1:numel(D)
     I=imread([image_dir D(i).name]);
     if size(I,3)~=3;
            I=I(:,:,ones(1,1,3));
     end
     gist_ar(i,:)=LMgist(I,'',param);
end


    if numel(D)>para4*1.5 
    [gist_cl,gist_cr]=kmeans(gist_ar,round(numel(D)/para4),'distance','cityblock','emptyaction','singleton');
    else 
    gist_cl=ones(numel(D),1);gist_cr=mean(gist_ar);  
    end
    
gist_cl2=gist_cl;
tyu=unique(gist_cl);
mt=max(tyu);

for g=1:numel(tyu)
    list=find(gist_cl2==tyu(g));
    if numel(list)>1.5*para4
        gist_cl(list(round(numel(list))/2:end))=mt+1;
        mt=mt+1;
    end
    if numel(list)<0.5*para4
        gist_cl(list)=tyu(g)+1;
        
    end
end

tyu=unique(gist_cl);
for k=1:numel(unique(gist_cl))
    t1=tyu(k);
    list=find(gist_cl==t1);
for i = 1:numel(list)
	im_list{i} = [image_dir D(list(i)).name];
end


extract_feat(im_list,image_dir);

[yspn,ysp2,ysp3]=precompute_matrix3;

dt=solve_qp(im_list,image_dir,yspn,ysp2,ysp3,Tau_parameter);

im_list = {};

delete('./tmp/*');

end
end
% VISUALIZE RESULTS
% disp('Visualize co-localization results...');
% load([tmp_dir 'qp_sol']);
% for i = 1:numel(im_list)
% 	visualize(im_list{i}, box_sol(i,:));
% 	disp('Press any key to continue...');
% 	pause;
% end
