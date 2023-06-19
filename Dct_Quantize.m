function [Matrix]=Dct_Quantize(I,Qua_Factor,Qua_Table)
%Dct����
%I:
%Qua_Factor:
%Qua_Table
I=double(I)-128;  %����ƶ�128���Ҷȼ�

%t2�任����ImageSub�ֳ�8*8���ؿ飬�ֱ����dct2�任���ñ任ϵ������Coef

I=blkproc(I,[8 8],'dct2(x)');
if Qua_Factor < 50
    Qua_Matrix = round((Qua_Factor/50).*Qua_Table);             %��������
elseif Qua_Factor <= 100
    Qua_Matrix = max(round((2-Qua_Factor/50).*Qua_Table),1);
end

I=blkproc(I,[8 8],'round(x./P1)',Qua_Matrix); %��������������

Matrix=I;         %�õ�������ľ���

end
