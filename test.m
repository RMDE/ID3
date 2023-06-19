clc;clear;
img = imread('original.png');
% figure, imshow(img);
 Thumbnail(img,8);
% 1，对整个图像dct变换
% dct_img = dct2(img);
 
% 2，量化, 使得矩阵中小于0.1的值置为0，变得稀疏
% [M,N]=size(dct_img);
% fun = @(block_struct) mean2(block_struct.data);
% I_th = blockproc(img,[8 8],fun);
% figure, imshow(I_th);
% dct_img = dct_img-2;
% dct_img(abs(dct_img)<20)=0;
% figure, imshow(log(abs(dct_img)), colormap(gray(5)));
% colorbar;


% % 3，反变换回来
% new_img = idct2(dct_img);
% new_img = int32(new_img);
% % [M,N] = size(new_img);
% % count2 = 0;
% % for i = 1 : M
% %     for j = 1 : N
% %         if img(i,j) ~= new_img(i,j)
% % %             i,j,img(i,j),new_img(i,j)
% % %             count2 = count2 + 1;
% %         end
% %     end
% % end
% % new_img = mat2gray(new_img);
% % figure, imshow(img);
% dct_new = dct2(new_img);
% dct_new(abs(dct_new)<19)=1;
% dct_new(abs(dct_new)>=19)=0;
% sum(sum(dct_new))
% count1