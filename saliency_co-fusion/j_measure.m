function [acc] = j_measure(m1,m2)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
m2=logical(mat2gray(imresize(m2,[size(m1,1),size(m1,2)],'nearest')));

m=double(m1)+double(m2);

list1=find(m==2);
list2=find(m>=1);


acc=max(size(list1))/max(size(list2));


end

