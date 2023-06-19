function res = Selection1(I,q,k,colt,p)
    J = zeros(8);
    cap = zeros(8);
    for i = 1 : 8
        for j = 1 : 8
            if i == 1 && j == 1
                J(i,j) = 10000;
            else
                [J(i,j),cap(i,j)] = Calcu_J(i,j,I,q(i,j));
            end
        end
    end
    for i = 1 : p
        J(colt(1,i),colt(2,i)) = 10000;
    end
    [~,index] = sort(J(:));
    res = zeros([3 k]);
    res(2,:) = uint8(mod(index(1:k),8));
    res(3,:) = ceil(index(1:k)/8);
    flag = [res(2,:)==0];
    res(2,flag) = 8;
    for i = 1 : k
        res(1,i) = cap(res(2,i),res(3,i));
    end
end

function [distortion,capacity] = Calcu_J(u,v,I,q)
    [M,N,~] = size(I);
    sub = I(u:8:M,v:8:N,:);
    count1 = sum(sum([sub == 1]))+sum(sum([sub==-1]));
    count2 = sum(sum([sub ~= 0]))-count1;
    J = (0.5*count1+count2)*Cost(u,v,q);
    distortion = J/count1;
    if count1 == 0
        distortion = 10000;
    end
    capacity = count1;
end

function cost = Cost(u,v,q)
    cost = 0;
    for x = 0 : 7
        for y = 0 : 7
            cost = cost + (0.25*(C(u)*C(v)*q*cos((2*x+1)*(u-1)*pi/16)*cos((2*y+1)*(v-1)*pi/16)))^2;
        end
    end
    cost = cost / 64;
end

function res = C(u)
    if u == 1
        res = 1/sqrt(2);
    else
        res = 1;
    end
end