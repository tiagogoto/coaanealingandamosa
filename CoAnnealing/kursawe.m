function [sol] = kursawe(x)
    aux = 0;
    for i = 1:2
        aux = aux + (-10 * exp(-0.2*sqrt(x(i)^2 + x(i + 1)^2)));
    end
    aux2 = 0;
    for i = 1:3
        aux2 = aux2 + (x(i)^0.8 + 5 * sin(x(i)^3));
    end
    
    sol(1) = aux;
    sol(2) = aux2;
end