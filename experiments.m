function experiments
path = "D:\Project\dataset\Helen\";
Qua_Factor=100;%��������,��СΪ0.01,���Ϊ255,������0.5��3֮��,ԽС����Խ���ļ�Խ��
k = 12;
p = 4;
thr = 4;
for Qua_Factor = 100:10:100
for thr = 6 : 1 : 9
mkdir('D:\Project\ID3\experiments\Helen', strcat('Q=',num2str(Qua_Factor),",thr=",num2str(thr)));
time = 0;
t1=clock;
for xx = 5 : 5
    xx
tic
filename = strcat(path,num2str(xx),".png");
img=imread(filename);
img_ycbcr = rgb2ycbcr(img);            % rgb->yuvת��
[row,col,~]=size(img_ycbcr);      % ȡ����������~��ʾ3��ͨ����1��
%��ͼ�������չ
row_expand=ceil(row/16)*16;       %������ȡ���ٳ�16������չ��16�ı���
if mod(row,16)~=0           %��������16�ı����������һ�н�����չ
   for i=row:row_expand
       img_ycbcr(i,:,:)=img_ycbcr(row,:,:);
   end
end
col_expand=ceil(col/16)*16; %������ȡ��
if mod(col,16)~=0        %��������16�ı����������һ�н�����չ
   for j=col:col_expand
       img_ycbcr(:,j,:)=img_ycbcr(:,col,:);
   end
end
 
%��Y,Cb,Cr��������4:2:2����
Y=img_ycbcr(:,:,1);                   %Y����
Cb=zeros(row_expand/2,col_expand/2);       %Cb����
Cr=zeros(row_expand/2,col_expand/2);       %Cr����
for i=1:row_expand/2
    for j=1:2:col_expand/2-1         %������
       Cb(i,j)=double(img_ycbcr(i*2-1,j*2-1,2));     
       Cr(i,j)=double(img_ycbcr(i*2-1,j*2+1,3));     
    end
end
for i=1:row_expand/2
    for j=2:2:col_expand/2           %ż����
       Cb(i,j)=double(img_ycbcr(i*2-1,j*2-2,2));     
       Cr(i,j)=double(img_ycbcr(i*2-1,j*2,3));     
    end
end


%�ֱ��������ɫ�������б���
Y_Table=[16 11  10  16 24  40  51 61
   12  12  14 19  26  58 60  55
   14  13  16 24  40  57 69  56
   14  17  22 29  51  87 80  62
   18  22  37 56  68 109 103 77
   24  35  55 64  81 104 113 92
   49  64  78  87 103 121 120 101
   72  92  95  98 112 100 103  99];%����������
CbCr_Table=[17, 18, 24, 47, 99, 99, 99, 99;
   18, 21, 26, 66, 99, 99, 99, 99;
   24, 26, 56, 99, 99, 99, 99, 99;
   47, 66, 99 ,99, 99, 99, 99, 99;
   99, 99, 99, 99, 99, 99, 99, 99;
   99, 99, 99, 99, 99, 99, 99, 99;
   99, 99, 99, 99, 99, 99, 99, 99;
    99, 99, 99, 99, 99, 99, 99, 99];%ɫ��������



%������ͨ���ֱ�DCT������
Y_dct_q=Dct_Quantize(Y,Qua_Factor,Y_Table);
Cb_dct_q=Dct_Quantize(Cb,Qua_Factor,CbCr_Table);
Cr_dct_q=Dct_Quantize(Cr,Qua_Factor,CbCr_Table);

colt = zeros([2 10]);
colt(1,:) = [8,8,7,8,7,6,8,7,6,5];
colt(2,:) = [8,7,8,6,7,8,5,6,7,8];
ws = 3;
[Y1,res1] = Embedding(Y_dct_q,Y_Table,k,p,colt,ws);
if any(any(Cr_dct_q))
    [Cr1,res2] = Embedding(Cr_dct_q,CbCr_Table,k,p,colt,ws);
else
    Cr1 = Cr_dct_q;
end
if any(any(Cb_dct_q))
    [Cb1,res3] = Embedding(Cb_dct_q,CbCr_Table,k,p,colt,ws);
else
    Cb1 = Cb_dct_q;
end

% Y2 = Extraction(Y1,k,p,colt,ws,res1);
% if any(any(Cr1))
%     Cr2 = Extraction(Cr1,k,p,colt,ws,res2);
% else
%     Cr2 = Cr1;
% end
% if any(any(Cb1))
%     Cb2 = Extraction(Cb1,k,p,colt,ws,res3);
% else
%     Cb2 = Cb1;
% end
% if ~isequal(Y_dct_q,Y2) || ~isequal(Cr_dct_q,Cr2) || ~isequal(Cb_dct_q,Cb2)
%     return
% end

key = 1;
Y_enc = Encryption(Y1,key,2^thr);
Cr_enc = Encryption(Cr1,key,2^thr);
Cb_enc = Encryption(Cb1,key,2^thr);
% % % Inverse
% % Y_enc = Encryption(Y_enc,key,thr);
% % Cb_enc = Encryption(Cb_enc,key,thr);
% % Cr_enc = Encryption(Cr_enc,key,thr);
% % ������ͨ���ֱ������ͷ�DCT
Y_in_q_dct=Inverse_Quantize_Dct(Y_enc,Qua_Factor,Y_Table);
Cb_in_q_dct=Inverse_Quantize_Dct(Cb_enc,Qua_Factor,CbCr_Table);
Cr_in_q_dct=Inverse_Quantize_Dct(Cr_enc,Qua_Factor,CbCr_Table);
% Y_in_q_dct=Inverse_Quantize_Dct(Y_dct_q,Qua_Factor,Y_Table);
% Cb_in_q_dct=Inverse_Quantize_Dct(Cb_dct_q,Qua_Factor,CbCr_Table);
% Cr_in_q_dct=Inverse_Quantize_Dct(Cr_dct_q,Qua_Factor,CbCr_Table);

%�ָ���YCBCRͼ��
YCbCr_in = uint8(zeros([row_expand col_expand 3]));
YCbCr_in(:,:,1)=Y_in_q_dct;
for i=1:row_expand/2
   for j=1:col_expand/2
       YCbCr_in(2*i-1,2*j-1,2)=Cb_in_q_dct(i,j);
       YCbCr_in(2*i-1,2*j,2)=Cb_in_q_dct(i,j);
       YCbCr_in(2*i,2*j-1,2)=Cb_in_q_dct(i,j);
       YCbCr_in(2*i,2*j,2)=Cb_in_q_dct(i,j);
       YCbCr_in(2*i-1,2*j-1,3)=Cr_in_q_dct(i,j);
       YCbCr_in(2*i-1,2*j,3)=Cr_in_q_dct(i,j);
       YCbCr_in(2*i,2*j-1,3)=Cr_in_q_dct(i,j);
       YCbCr_in(2*i,2*j,3)=Cr_in_q_dct(i,j);
   end
end
I_in=ycbcr2rgb(YCbCr_in);
I_in(row+1:row_expand,:,:)=[];%ȥ����չ����
I_in(:,col+1:col_expand,:)=[];%ȥ����չ����
% I_th = Thumbnail(I_in,8);
% imwrite(I_in,strcat('D:\Project\ID3\experiments\Helen\', strcat('Q=',num2str(Qua_Factor),",thr=",num2str(thr)),"\",num2str(xx),".jpg"));
% imwrite(I_th,strcat('D:\Project\ID3\experiments\Helen\', strcat('Q=',num2str(Qua_Factor),",thr=",num2str(thr)),"\th_",num2str(xx),".jpg"));
end
t2=clock;
end
end
etime(t2,t1)
end