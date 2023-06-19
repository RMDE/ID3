function I = Extraction(I,k,p,colt,ws,res)
    [m,n] = size(I);
    M = [];
    no = 1; %index of M
        for index = 1 : k
            x = res(2,index);
            y = res(3,index);
            for i = x : 8 : m
                for j = y : 8 : n
                    if I(i,j) < -2
                        I(i,j) = I(i,j) + 1;
                    elseif I(i,j) == -1
                        M(no) = 0;
                        no = no + 1;
                    elseif I(i,j) == -2
                        M(no) = 1;
                        no = no + 1;
                        I(i,j) = -1;
                    elseif I(i,j) == 1
                        M(no) = 0;
                        no = no + 1;
                    elseif I(i,j) == 2
                        M(no) = 1;
                        no = no + 1;
                        I(i,j) = 1;
                    elseif I(i,j) > 2
                        I(i,j) = I(i,j) - 1;
                    end
                end
            end
        end
    I = Selection2(I,p,colt,M,ws);
end

function I = Selection2(I,p,colt,M,ws)
    no = 1;
    [m,n] = size(I);
    temp = zeros([floor(m*n/64)*p ws]);
    M = Decode(M,floor(m*n/64)*p*ws);
    for i = 1 : ws
        temp(:,i) = M((i-1)*floor(m*n/64)*p+1:i*floor(m*n/64)*p);
    end
    for k = 1 : p
        x = colt(1,k);
        y = colt(2,k);
        for i = x : 8 : m
            for j = y : 8 : n
                I(i,j) = Bin2dec(char(temp(no,:)+'0'));
                no = no + 1;
            end
        end
    end
end

function M = Decode(data,n)
    [~,len] = size(data);
    M = zeros([1 n]);
    index = 1;
    for i = 1 : 8 : len
        if index > n
            return
        end
        count = bin2dec(char(data(i:i+6)+'0'));
        flag = data(i+7);
        M(index:index+count-1) = flag;
        index = index+count;
    end
end