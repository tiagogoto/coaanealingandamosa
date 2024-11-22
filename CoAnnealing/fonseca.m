function [sol] - fonseca(x)

sol(1) = 1 - exp(-sum( ( x(:) - 1 / sqrt(5) )^2 ) );
sol(2) = 1 - exp(- sum((x(:) +  1 / sqrt(5) )^2 ) );
end