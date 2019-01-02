% close all;
% clear;
% clc;
% i=imread('./MSRC_fusion/Bike/co-fusion_result/img_1001.png'); %�������ɫͼ��·��
% i=double(i);  %��uint8��ת��Ϊdouble�ͣ������ܼ���ͳ����
% % [m,n]=size(i);
% % s=0;
% % for x=1:m
% %     for y=1:n
% %         s=s+i(x,y); %������ֵ�ܺ� s  �� i(x,y)��ʾλ��ĳ�������µ�����ֵ
% %     end
% % end
% mean=mean2(i);
% a1=var(i(:)); 

mu_x1 = 10;

mu_x2 = 20;



bpdf_vec1=@(x,y,mu_x,mu_y)(exp(-((x-mu_x).^2)./2.-((y-mu_y)^2)/2)./(2*pi)); 

    %calcualting overlap of two distributions at the point x,y 
    overlap_point = @(x,y) min(bpdf_vec1(x,y,mu_x1,mu_y1),bpdf_vec1(x,y,mu_x2,mu_y2)); 

    %calculating overall overlap area 
    oa=dblquad(overlap_point,-100,100,-100,100); 

% I=imread('./MSRC_fusion/Bike/co-fusion_result/img_1001.png'); 
% subplot(1,2,1)
% imshow(I);
% imhist(I); 
% title('Histogram');