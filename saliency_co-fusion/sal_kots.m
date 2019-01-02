function [fin_j,image] = sal_kots(Image,fj)


[O,Q,~]=size(Image);






% 
% para=1000000;para3=25;
% x=round(min(O,Q)/50);
rs=min(256/max(O,Q),0.8);
%ns=round([O,Q]/x);
image=imresize(Image,round([O Q]*rs),'nearest');
% im=mat2gray(im);
% im=imfilter(im,fspecial('gaussian',7,1));
% Iseg=imresize(Image,ns,'nearest');
% %Iseg = vl_xyz2lab(vl_rgb2xyz(Iseg));
% Iseg = vl_quickseg(Iseg,0.7,2,20);
% gray=(sum(Iseg,3)/3);
% % Iseg = vl_xyz2lab(vl_rgb2xyz(Iseg)) ;
% gray=imfilter(gray,fspecial('gaussian',7,1));
% fj=mat2gray(imresize(im,ns,'nearest'));
% 
% [M,N]=size(fj);
% otsu=graythresh(fj);
% 
% fjmask=im2bw(fj,otsu);
% 
% [g1,g2]=meshgrid(gray,gray);
% i=(1:M)';I=i(:,ones(1,N));j=1:N;J=j(ones(1,M),:);
% dist=sqrt( bsxfun(@minus,I(:),I(:).').^2 + bsxfun(@minus,J(:),J(:).').^2 );
% G=sum(abs(g1-g2).*exp(-dist/para3));
% kj=reshape(G,[M N]).*(~fjmask);
% kj=kj/max(kj(:));
% kj=mat2gray(kj);
% 
% fj=fjmask+kj;
% fj=imfilter(fj,fspecial('disk',6));
fin_j=(imresize(fj,round([O Q]*rs),'nearest'));


end

