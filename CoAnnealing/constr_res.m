function [res] = constr_res(x)
aux1 = x(2) + 9 * x(1);
    aux2 = -x(2) + 9 * x(1);
    if aux1 >= 6 && aux2 >= 1
        res = 1;
    else
        res= 0;
    end
end