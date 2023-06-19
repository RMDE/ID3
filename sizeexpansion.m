%sizeExpansion
%function: calculate the file size of images
clc;clear;
path = "D:\Project\dataset\Helen\";
count = 1;
res = zeros(25,3);
for Qua_Factor = 60:10:100
for thr = 1 : 1 : 5
    sum = 0;
for xx = 1 : 100
img1 = strcat("D:\Project\dataset\Helen\",num2str(xx),".png");
img2 = strcat('D:\Project\ID3\experiments\Helen\', strcat('Q=',num2str(Qua_Factor),"\",num2str(xx),".jpg"));
% img2 = strcat('D:\Project\ID3\experiments\Helen\', strcat('Q=',num2str(Qua_Factor),",thr=",num2str(thr),"\",num2str(xx),".jpg"));
info1 = imfinfo(img1);
size1 = info1.FileSize;
info2 = imfinfo(img2);
size2 = info2.FileSize;
sum = sum + size2/size1;
end
sum = sum/100;
res(count,:) = [Qua_Factor,thr,sum];
count = count + 1;
end
end
res