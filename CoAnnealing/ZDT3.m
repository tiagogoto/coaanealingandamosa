function [solution] = ZDT3(x)
    [l, nov] = size(x);
    solution( 1 ) = x(1);
    aux = 0;
    for i = 2:30
        aux = aux + x(i);
    end 
    g = 1 + 9 / 29 * aux;
    %h = 1 - sqrt(solution(1) / g);
    %h = 1 - (solution(1)/g)^2;
    h = 1 - sqrt(solution(1)/g) - (solution(1)/g)*sin(10*pi*x(1));
    solution( 2 ) = g * h;
end
