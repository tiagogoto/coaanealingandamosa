function [res] = Chankong_res(x)
aux1 = x(1)^2 + x(2)^2;
    aux2 = x(1) - 3*x(2) + 10;
    if aux1 <= 225 && aux2 <= 0
        res = 1;
    else
        res= 0;
    end
end