 function [sol] = DTLZ1(x)
aux = 0;
for i = 3:12
    aux = aux + (x(i) - 0.5)^2 - cos(20 * pi * (x(i) - 0.5));
end
g = 100 * (10  + aux);
sol(1) = 0.5 * x(1)*x(2)*(1 + g);
sol(2) = 0.5 * x(1)*(1 - x(2))*(1 + g);
sol(3) = 0.5 * (1-x(1))*(1 + g);
end