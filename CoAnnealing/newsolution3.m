function [xj, var_ind] = newsolution3(xi, C, maxv, minv, Cmax)
[~ , nov] = size(xi);    
xj = xi;
status = 0;
while status ~= 1
    xj = xi;
    var_ind = randi([1,nov],1 ,1);
    if C(var_ind) <= Cmax
        rand_number = (rand(1, C(var_ind)) - 0.5);
        aux = sum(rand_number);
        delr = (maxv(var_ind) - minv(var_ind))/4;
        delta = delr * aux/C(var_ind);
        xj(var_ind) = xj(var_ind) + delta;
        if (xj(var_ind) >= minv(var_ind)) && (xj(var_ind) <= maxv(var_ind))
            status = 1;
        else
            status = 0;
        end
    else
        gaussdist = normrnd(0, exp(Cmax - C(var_ind) - 2));
        delr = (maxv(var_ind) - minv(var_ind))/4;
        delta = delr * gaussdist;
        xj(var_ind) = xj(var_ind) + delta;
        if (xj(var_ind) >= minv(var_ind)) && (xj(var_ind) <= maxv(var_ind))
            status = 1;
        else
            status = 0;
        end 
    end
end