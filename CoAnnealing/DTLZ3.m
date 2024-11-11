function [sol] =  DTLZ3(x)
   aux = 0;
for i = 3:12
    aux = aux + (x(i) - 0.5)^2 - cos(20 * pi * (x(i) - 0.5));
end
g = 100 * (10  + aux);
sol(1) = cos(x(1) * pi / 2) * cos(x(2) * pi / 2) * (1 + g);
sol(2) = cos(x(1) * pi / 2) * sin(x(2) * pi / 2) * (1 + g);
sol(3) = sin(x(1) * pi / 2) * (1 + g);

end