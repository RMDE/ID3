clc;clear;
path = "D:\Project\dataset\Helen\";
Qua_Factor=90;%��������,��СΪ0.01,���Ϊ255,������0.5��3֮��,ԽС����Խ���ļ�Խ��
k = 12;
p = 4;
thr = 4;
count = 1;
res = zeros(25,3);
for Qua_Factor = 60:10:100
for thr = 1 : 1 : 5
    sum = 0;
for xx = 1 : 100
img2 = imread(strcat('D:\Project\ID3\experiments\Helen\origin_th',"\th_",num2str(xx),".jpg"));
img1 = imread(strcat('D:\Project\ID3\experiments\Helen\', strcat('Q=',num2str(Qua_Factor),"\th_",num2str(xx),".jpg")));
% img2 = imread(strcat('D:\Project\ID3\experiments\Helen\', strcat('Q=',num2str(Qua_Factor),",thr=",num2str(thr),"\th_",num2str(xx),".jpg")));
sum = sum + ssim(img1,img2);
end
sum = sum/100;
res(count,:) = [Qua_Factor,thr,sum];
count = count + 1;
end
end
res

