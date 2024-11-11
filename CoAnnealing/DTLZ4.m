function sol = DTLZ4(x)
aux = 0;
for i = 3:12
    aux = aux + (x(i) - 0.5)^2;
end
g = aux;
sol(1) = (1 + g) * cos(pi * x(1)^100 * 0.5)*cos(pi * x(2)^100*0.5);
sol(2) = (1 + g) * cos(pi * x(1)^100 * 0.5)*sin(pi * x(2)^100*0.5);
sol(3) = (1 + g) * sin(0.5 * x(1)^100*pi);
end