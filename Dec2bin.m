%file:Dec2bin.m
%change from function dec2bin
%adding: the solution of negative integer
function bits = Dec2bin( number ,n)
if number > 0
    bits = dec2bin(number,n);
elseif number == 0
    bits(1:n) = '0';
else
    bits(2:n) = dec2bin(-number,n-1);
    bits(1) = '1';
end
end