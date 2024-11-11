function [sol] = ZDT1(x)
    sol(1) = x(1);
    aux = 0;
    for i = 2:30
      aux = aux + x(i);
    end 
    g = 1 + 9/29*aux;
    h = 1 - sqrt(sol(1)/g);
    sol(2) = g * h;
end