function [ Matrix ] = Inverse_Quantize_Dct( I,Qua_Factor,Qua_Table )

%UNTITLED3 Summary of this function goes here

%   Detailed explanation goes here

if Qua_Factor < 50
    Qua_Matrix = round((Qua_Factor/50).*Qua_Table);             %量化矩阵
elseif Qua_Factor <= 100
    Qua_Matrix = max(round((2-Qua_Factor/50).*Qua_Table),1);
end

I=blkproc(I,[8 8],'x.*P1',Qua_Matrix);%反量化，四舍五入

[row,column]=size(I);

I=blkproc(I,[8 8],'idct2(x)');  %T反变换

I=uint8(I+128);

for i=1:row

   for j=1:column

       if I(i,j)>255

           I(i,j)=255;

       elseif I(i,j)<0

           I(i,j)=0;

       end

   end

end

Matrix=I;      %反量化和反Dct后的矩阵

end
