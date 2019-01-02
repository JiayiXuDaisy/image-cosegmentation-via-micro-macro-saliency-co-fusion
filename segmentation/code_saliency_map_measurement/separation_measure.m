function y = separation_measure(filepath)

img = imread(filepath);
[m,n] = size(img);
fore_gray_avg = 0;
back_gray_avg = 0;
fore_gray_var = 0;
back_gray_var = 0;
fore_num = 0;
back_num = 0;

for i=1:1:m
    for j=1:1:n
        bimg(i,j) = img(i,j)/255;
    end
end

level = graythresh(img);

for i=1:1:m
    for j=1:1:n      
        if(bimg(i,j) >= level)
            fore_gray_avg = fore_gray_avg + double(img(i,j));
            fore_num = fore_num + 1;
        end
        if(bimg(i,j)<level)
            back_gray_avg = back_gray_avg + double(img(i,j));
            back_num = back_num + 1;
        end
    end
end
fore_gray_avg = fore_gray_avg / fore_num;
back_gray_avg = back_gray_avg / back_num;

for i=1:1:m
    for j=1:1:n      
        if(bimg(i,j) >= level)
            fore_gray_var = fore_gray_var + double((img(i,j) - fore_gray_avg)^2);
        end
        if(bimg(i,j)<level)
            back_gray_var = back_gray_var + double((img(i,j) - back_gray_avg)^2);
        end
    end
end

fore_gray_var = sqrt(fore_gray_var / (fore_num-1));
back_gray_var = sqrt(back_gray_var / (back_num-1));

% x = -300:500;
% plot(x,normpdf(x,fore_gray_avg,fore_gray_var));
% hold on;
% plot(x,normpdf(x,back_gray_avg,back_gray_var));

fore =@(x) normpdf(x,fore_gray_avg,fore_gray_var);
back =@(x) normpdf(x,back_gray_avg,back_gray_var);


y = @(x)normpdf(x,fore_gray_avg,fore_gray_var)-normpdf(x,back_gray_avg,back_gray_var);

if(y(0)*y(255)>=0 )
    overlap = 0;
else
    if(isnan(y(0)) || isnan(y(255)))
        overlap = 0;
    else
        y(0)
        y(255)
        point = fzero(y,[0,255]);
        if(point<=255 && point>=0)
            overlap = integral(fore,0,point) + integral(back,point,255);
        else
            overlap = 0;   
        end
    end
end
y = overlap;

