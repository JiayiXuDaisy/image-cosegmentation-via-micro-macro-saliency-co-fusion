clear all;
clc;

mainDir = './icoseg_fusion';
subDir = dir(mainDir);

for i = 3:length(subDir)
    subsubDir = [mainDir,'\',subDir(i).name,'\','saliency_maps'];
    sal1Dir = [subsubDir,'\sal1'];
    sal2Dir = [subsubDir,'\sal2'];
    sal3Dir = [subsubDir,'\sal3'];
    sal4Dir = [subsubDir,'\sal4'];
    sal5Dir = [subsubDir,'\sal5'];
    sal6Dir = [subsubDir,'\sal6'];
    sal1Img = dir([sal1Dir,'\*.png']);
    sal2Img = dir([sal2Dir,'\*.png']);
    sal3Img = dir([sal3Dir,'\*.png']);
    sal4Img = dir([sal4Dir,'\*.png']);
    sal5Img = dir([sal5Dir,'\*.png']);
    sal6Img = dir([sal6Dir,'\*.png']);
    for j= 1:length(sal1Img)
        sal1(i,j)= separation_measure([sal1Dir,'\',sal1Img(j).name]);
        sal2(i,j)= separation_measure([sal2Dir,'\',sal2Img(j).name]);
        sal3(i,j)= separation_measure([sal3Dir,'\',sal3Img(j).name]);
        sal4(i,j)= separation_measure([sal4Dir,'\',sal4Img(j).name]);
        sal5(i,j)= separation_measure([sal5Dir,'\',sal5Img(j).name]);
        sal6(i,j)= separation_measure([sal6Dir,'\',sal6Img(j).name]);
        min = sal1(i,j);
        max = sal1(i,j);
        if(sal2(i,j)<min)
            min = sal2(i,j);
        end
        if(sal3(i,j)<min)
            min = sal3(i,j);
        end
        if(sal4(i,j)<min)
            min = sal4(i,j);
        end
        if(sal5(i,j)<min)
            min = sal5(i,j);
        end
        if(sal6(i,j)<min)
            min = sal6(i,j);
        end
        if(sal2(i,j)>max)
            max = sal2(i,j);
        end
        if(sal3(i,j)>max)
            max = sal3(i,j);
        end
        if(sal4(i,j)>max)
            max = sal4(i,j);
        end
        if(sal5(i,j)>max)
            max = sal5(i,j);
        end
        if(sal6(i,j)>max)
            max = sal6(i,j);
        end
        sep1(i,j) = (sal1(i,j)-min)/(max-min);
        sep2(i,j) = (sal2(i,j)-min)/(max-min);
        sep3(i,j) = (sal3(i,j)-min)/(max-min);
        sep4(i,j) = (sal4(i,j)-min)/(max-min);
        sep5(i,j) = (sal5(i,j)-min)/(max-min);
        sep6(i,j) = (sal6(i,j)-min)/(max-min);
    end 
end

% filepath = './MSRC_fusion/Bike/co-fusion_result/img_1013.png';
% overlap = separation_measure(filepath);