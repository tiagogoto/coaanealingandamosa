function [sol] = DTLZ7(x)
M = 3; % number of function
K = 10;
D = M + K - 1;
g = 0;
for i = 3:12
    g = g + x(i); 
end
g = 1 + 9/10 * g;
sol(1) = x(1);
sol(2) = x(2);
h = 0;

for jj = 1:(M-1)
    h = h + sol(jj)/(1 + g)*(1 + sin(3*pi*sol(jj)));
end
h = M - h;
sol(3) = (1 + g) * h;

end