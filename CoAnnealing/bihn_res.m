function [res] = bihn_res(x)
    aux1 = (x(1) - 5)^2 + x(2)^2;
    aux2 = (x(1) - 8)^2 + (x(2) + 3)^2;
    if aux1 <= 25 && aux2 >= 7.7
        res = 1;
    else
        res= 0;
    end
end