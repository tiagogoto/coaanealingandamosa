function sol = ZDT6(x)
    sol( 1 ) = 1 - exp(-4*x(1))*(sin(6*pi*x(1)))^6;
    aux = 0;
    for i = 2:10
        aux = aux + x(i);
    end 
    g = 1 + 9*(aux/9)^0.25;
    h = 1 - (sol(1) / g)^2;
    sol( 2 ) = g * h;
end