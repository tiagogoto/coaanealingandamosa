function sol = constr(x)
    sol(1) = x(1);
    sol(2) = (1 + x(2))/x(1);
end