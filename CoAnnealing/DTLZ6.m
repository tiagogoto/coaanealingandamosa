function sol = DTLZ6(x)
g = 0;
for i = 3:12
    g = g + (x(i))^(0.1);
end

theta(1) = x(1);
theta(2) = pi * (1 + 2 * g * x(2))/ (4 * (1 + g));

sol(1) = (1 + g)*cos(pi*theta(1)*0.5)*cos(theta(2));
sol(2) = (1 + g)*cos(pi*theta(1)*0.5)*sin(theta(2));
sol(3) = (1 + g) * sin(0.5*theta(1)*pi);
end