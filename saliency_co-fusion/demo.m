%warning('off');
addpath(genpath('./grabcut/'));
addpath(genpath('./mdaisy-v1.0/'));
addpath(genpath('./saliencydetection/'));

Tau_parameter=0.75;
globals;
run('./vlf2\vlfeat-0.9.17\toolbox\vl_setup');

db='./data/MSRC';
load ('./macromat/MSRC_separation_saliency1.mat');
load ('./macromat/MSRC_concentration_saliency1.mat');
load ('./macromat/MSRC_separation_saliency2.mat');
load ('./macromat/MSRC_concentration_saliency2.mat');
load ('./macromat/MSRC_separation_saliency3.mat');
load ('./macromat/MSRC_concentration_saliency3.mat');
load ('./macromat/MSRC_separation_saliency4.mat');
load ('./macromat/MSRC_concentration_saliency4.mat');
load ('./macromat/MSRC_separation_saliency5.mat');
load ('./macromat/MSRC_concentration_saliency5.mat');
load ('./macromat/MSRC_separation_saliency6.mat');
load ('./macromat/MSRC_concentration_saliency6.mat');

fl=dir(db);
clear db_ar;
for k=3:numel(fl)  
   db_ar{k-2}=fl(k).name;
end

for vb=1:numel(db_ar)
image_dir = strcat(db,'\',db_ar{vb},'\');
saliency_mapsff(image_dir); 
addpath(genpath(image_dir));

mkdir(strcat(image_dir,'/otsuseg/'));
mkdir(strcat(image_dir,'/otsumask/'));
mkdir(strcat(image_dir,'/grabseg/'));
mkdir(strcat(image_dir,'/grabmask/'));
mkdir(strcat(image_dir,'/co-fusion_result/'));
%mkdir(strcat(image_dir,'test/',db_ar{vb}));
addpath(strcat(image_dir,'/otsuseg/'));
addpath(strcat(image_dir,'/otsumask/'));
addpath(strcat(image_dir,'/grabseg/'));
addpath(strcat(image_dir,'/grabmask/'));
addpath(strcat(image_dir,'/co-fusion_result/'));
%addpath(strcat(image_dir,db_ar{vb}));

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
     if size(I,3)~=3
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

H = zeros(length(yspn),length(yspn));
f = yspn;
A = zeros(length(yspn),length(yspn));
b = zeros(length(yspn),1);
beq = ones(length(yspn),1);
lb = zeros(length(yspn),1);
ub = ones(length(yspn),1);
AeqElement = zeros(50,300);

for ii=1:50
    AeqElement(ii,ii) = 1;
    AeqElement(ii,50+ii) = 1;
    AeqElement(ii,100+ii) = 1;
    AeqElement(ii,150+ii) = 1;
    AeqElement(ii,200+ii) = 1;
    AeqElement(ii,250+ii) = 1;
end

AeqElement = repmat(AeqElement, 6, 1);
Aeq = zeros(length(yspn),length(yspn));

for jj=1:length(im_list)
    Aeq((jj-1)*300+1:(jj-1)*300+1+299,(jj-1)*300+1:(jj-1)*300+1+299) = AeqElement;
end

result = quadprog(H,f,A,b,Aeq,beq,lb,ub);

dt=solve_qp(im_list,image_dir,yspn,ysp2,ysp3,Tau_parameter);

%delete('./tmp/*');

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
