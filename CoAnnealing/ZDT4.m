function [sol] = ZDT4(x)
    sol( 1 ) = x(1);
    aux = 0;
    for i = 2:10
        aux = aux + ( x(i)^2 - 10 * cos(4 * pi * x(i)));
    end 
    g = 91 + aux;
    h = 1 - sqrt(sol(1) / g);
    %h = 1 - (solution(1)/g)^2;
    %h = 1 - sqrt(solution(1)/g) - (solution(1)/g)*sin(10*pi*x(1));
    sol( 2 ) = g * h;
end
