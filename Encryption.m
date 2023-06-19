function [Matrix]=Encryption(I,key,thr)
[M,N] = size(I);
rng('default');
rng(key);
I = int16(I);
stream = int16(randi(thr*2-1,M,N)-thr);
flag = logical(ones([M N]));
% flag = [abs(I) < thr];
flag(1:8:M,1:8:N) = 0;
I(flag) = bitxor(I(flag),stream(flag));
Matrix = I;
end