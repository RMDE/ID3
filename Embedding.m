function [I,res] = Embedding(I,q,k,p,colt,ws)
    res = Selection1(I,q,k,colt,p);
    M = Selection2(I,p,colt,ws);
    [~,len] = size(M);
    capacity = sum(res(1,:))
    len = len
    M(len+1:capacity) = 0;
    no = 1; %index of M
    [m,n] = size(I);
        for index = 1 : k
            x = res(2,index);
            y = res(3,index);
            for i = x : 8 : m
                for j = y : 8 : n
                    if I(i,j) < -1
                        I(i,j) = I(i,j) - 1;
                    elseif I(i,j) == -1
                        if M(no) == 1
                            I(i,j) = -2;
                        end
                        no = no + 1;
                    elseif I(i,j) == 1
                        if M(no) == 1
                            I(i,j) = 2;
                        end
                        no = no + 1;
                    elseif I(i,j) > 1
                        I(i,j) = I(i,j) + 1;
                    end
                end
            end
        end
end

function M = Selection2(I,p,colt,ws) %encode message
    no = 1;
    [m,n] = size(I);
    temp = zeros([floor(m*n/64)*p ws]);
    for k = 1 : p
        x = colt(1,k);
        y = colt(2,k);
        for i = x : 8 : m
            for j = y : 8 : n
                temp(no,:) = Dec2bin(I(i,j),ws)-'0';
                no = no + 1;
            end
        end
    end
    index = 1;
    for i = 1 : ws
        [tmp,len] = Encode(temp(:,i));
        M(index:index+len-1) = tmp;
        index = index + len;
    end
end

function [res,len] = Encode( data )
[length,~] = size(data);
i = 1;%the index of data
count = 0;%to store the number of '0' or '1'
res = [];%store the compression result, every progress result in one byte and the LSB is the type of number counted('0' or '1')
l = 1;%index of res
flag = 0;%means the number now to calculate is '0'
while i <= length
    if data(i)==0
        while i<=length && data(i)==0 && count<127  %calculate the number of '0'
            count = count+1;
            i = i+1;
        end
        flag = 0;
    elseif data(i)==1
        while i<=length && data(i)==1 && count<127  %calculate the number of '0'
            count = count+1;
            i = i+1;
        end
        flag = 1;
    end
    t = dec2bin(count,7);
    res(l:l+6) = t(1:7)-'0';
    res(l+7) = flag;
    l = l+8;
    count = 0;
end
len = l - 1;
end