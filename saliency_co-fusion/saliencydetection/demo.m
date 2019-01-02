addpath(genpath('./drfi'));

image_name = './bird.jpg';
image = imread( image_name );

para = makeDefaultParameters;

% acclerate using the parallel computing
% matlabpool

t = tic;

smap = drfiGetSaliencyMap( imresize(image,[128,128]), para );
smap = imresize(smap,[size(image,1),size(image,2)]);
time_cost = toc(t);
fprintf( 'time cost for saliency computation using DRFI approach: %.3f\n', time_cost );

subplot('121');
imshow(image);
subplot('122');
imshow(smap);