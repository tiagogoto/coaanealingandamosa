function [archive, sol] = init_sol(nof, nov, maxv, minv, SL)
hill_climb = 20;
b = 0.5;
for ii = 1:SL
    for col = 1:nov
        archive(ii, col) = rand() * (maxv(col) - minv(col)) + minv(col);
    end
end
sol = [];
for i = 1:SL
    for j = 1:hill_climb
        sol(i, :) = ZDT6(archive(i, :));
        xnew = newsolution_amosa(archive(i, :), b, nov, maxv, minv);
        solnew = ZDT6(xnew);
        count = 0;
        for iii = 1:nof
            if sol(i, iii) >= solnew(iii)
                count = count + 1 ;
            end
        end
        if count == nof
            sol(i, : ) = solnew;
            archive(i, :) = xnew;
        end
    end
end
end