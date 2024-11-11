function [archive, sol] = clusterh9(archive, sol, HL)
[num, nof] = size(sol);
indexhull = [];
flag = zeros(num, 1);

%check solutions with bad solution

indexhull = conv( sol);
flag(indexhull) = 1;
[f_max(1:nof), arg_max(1:nof)] = max(sol(:, 1:nof));
%flag(arg_max) = 1;
% 1, eliminar todas as soluções ruins
% 2. eliminar ios que não estão no outer-shell
% 3. depois faz single-linkage
to_remove = num - HL;

[archive, sol] = remove_bad(archive, sol, flag, to_remove);
[num, ~] = size(sol);

%  etapa 2
if num > HL
    [archive, sol] = single_linkage(archive, sol, HL);
end

end


function [index_hull] = conv(sol)
[L, nof] = size(sol);
newflag = [];
z = convhull(sol);
index_hull = unique(z);
[aux, ~ ] = size(index_hull);
count = 1;
while count <= aux 
    for i = 1:aux
        if aux ~= count
            if domination(sol(index_hull(count), :), sol(index_hull(i) , :))
                newflag(end + 1) = i;
            end
        end
    end
    count = count + 1;
end
newflag = unique(newflag);
index_hull(newflag) = [];

end

function [archive, sol] = remove_bad(archive, sol, flag, HL)
[num, ~] = size(sol);
index = [];
count = 1;
stop = 0;
aux2 = 0;
while count < num && stop ~= 1
    for i = 1:num
        aux = 0;
        if i ~= count
            aux = domination(sol(count, :), sol(i, :));
            if aux == 1 && flag(i) == 0
                index(end + 1) = i;
            end
        end
    end
    [~, aux2] = size(unique(index));
    if aux2(1) >= HL
        stop = 1;
    end
    count = count +1;
end
index = unique(index);
aux2 = size(index);
%fprintf('removed: %f \n', aux);
sol(index, :) = [];
archive(index, :) = [];
end

function [archive, sol] =  single_linkage(archive, sol, HL)
[lines, ~] = size(sol);
    needs_remove =  lines - HL; %+ preserved;
    count = 0;
    stop_cri = 0;
    aditional = 0;
    while count < needs_remove || stop_cri > (HL*2)
        [aa, bb] = size(archive);
        if aa == 0
            break;
        end
        [z] = linkage(archive);
        [b, c] = size(z);
        if  z(1+ aditional,1) <= aa
            archive(z(1 + aditional,1), :) = [];
            sol(z(1 + aditional,1), :) = [];
            count = count + 1;
            aditional = 0;
        elseif z(1 + aditional, 2) <= aa
            archive(z(1 + aditional,2), :) = [];
            sol(z(1 + aditional,2), :) = [];
            count = count + 1;
            aditional = 0;
        else
            aditional = 1;
            stop_cri = stop_cri + 1;           
        end
    end 
end

function [dominance] = domination(a, b)
[~,nof] =size(a);
equal = 0;
less = 0;
larger = 0;
for j = 1:nof
   if a(j) < b(j) || abs(a(j) - b(j)) < 10^(-3)
       less = less +1;
   elseif abs(a(j) - b(j)) <= 10^(-4)
       equal = equal + 1;
   else
       larger = larger + 1;
   end
end
% Dominance 
% if a dominate b dominance is equal a 1
% if a is dominated by b, domionance is equal a 2
% if a and b is non-dominate, dominance is equal a 0

if (less + equal ) == nof && larger == 0
    dominance = 1;
elseif (larger + less) == nof && equal == 0
    dominance = 0;
elseif (larger + equal) == nof && less == 0
    dominance = 2;
else
    dominance = 1;
end 
end