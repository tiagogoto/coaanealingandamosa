function [res] = TNK_res(x)
aux1 = - x(1)^2 - x(2)^2 + 1 + 0.1*cos(16*atan(x(1)/x(2)));
    aux2 = (x(1) - 0.5)^2 +  (x(2) - 0.5)^2;
    if aux1 <= 0 && aux2 <= 00.5
        res = 1;
    else
        res= 0;
    end
end