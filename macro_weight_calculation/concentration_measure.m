function y = concentration_measure(filepath)

img = imread(filepath);
imshow(img);
stats = regionprops(img ,'Centroid');
[m,n] = size(img);
center_m = m/2;
center_n = n/2;
centroid = [stats.Centroid];
num_obj = length(centroid)/2;
min_concentration = sqrt((center_m^2+center_n^2)/2);
total_concentration = 0;
for i = 1:num_obj
    obj_x(i) = centroid(2*i-1);
    obj_y(i) = centroid(2*i);
    concentration(i) = sqrt(((obj_x(i)-center_m)^2+(obj_y(i)-center_n)^2)/2);
    if(concentration(i)<min_concentration)
        min_concentration = concentration(i);
    end
end

for i = 1:num_obj
    total_concentration = total_concentration + concentration(i);
end

for i = 1:num_obj
    concentration_norm(i) = concentration(i)/total_concentration;
end

con_mea = min_concentration + (1-min_concentration)/num_obj;

y = con_mea;