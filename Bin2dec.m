%file:Bin2dec.m
%change from function bin2dec
%adding: the solution of negative integer
function number = Bin2dec( bits )
    [~,n] = size(bits);
    if bits(1) == '1'
        number = -bin2dec(bits(2:n));
    else
        number = bin2dec(bits);
    end
end