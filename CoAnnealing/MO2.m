function [sol] = MO2(x)
if x(1) <= 1
    sol(1) = -x(1);
elseif x(1) > 1 && x(1) <= 3 
    sol(1) = (x(1) - 2);
elseif x(1) > 3 && x(1) <= 4
    sol(1) = (4 - x(1));
elseif x(1) > 4 
    sol(1) = (x(1) - 4);
end
    sol(2) = (x(1) - 5 )^2;
end