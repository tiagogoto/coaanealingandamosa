function [score] =  benchmark(solution, problem)
filename = strcat(problem, "_pareto.dat");
true_sol = readmatrix(filename);
score = [];

% IGD 
score(1) = igd(solution, true_sol);
%% Convergence

%fprintf('Displacement: %f \n', D);
%score(2) = purity(solution, true_sol);
%fprintf('Purity: %f \n', P);
P = 1;
score(2) = newspacing(solution);
%fprintf('Spacing: %f \n', S);
score(3) = spread(solution, true_sol);
score(4) = gd(solution, true_sol);
score(5) = convergence(solution, true_sol);
score(6) = displacement(solution, true_sol);




end


%% Convergence
function C = convergence(solution, R) 
[lines, nof] = size(solution);
[lines2, ~] = size(R); 
aux = 0;
for i = 1:lines
    dist = [];
    for j = 1:lines2
        dist(j) = pdist([solution(i, :); R(j, :)]); 
    end
    aux = aux + min(dist);
end
C = aux/lines;
end
%% Displacement 
function [D] = displacement(solution, R)
[P, ~] = size(R);
[L , ~] = size(solution); 
aux = 0;

for i = 1:P
    aux2 = zeros(1,L);
    for k = 1:L
        aux2(k) = pdist([R(i, :); solution(k, :)], 'euclidean');
    end
    aux(i) = min(aux2(:));
end
D = sum(aux(:))/abs(P);

end
%% Purity
function [P] = purity(solution, R )
[H, ~] = size(solution);
[Sh,  ~] = size(R);
solution = round(solution, 6);
R = round(R, 6);
S_as = union(solution, R, 'row');
b = intersect(solution, R, 'row');
rh = H;
[rh_as,~]  = size(b); 
P = rh_as/rh;
end
%% Spacing
function [S] = spacing2(solution)
[Q, M] = size(solution);
di = [];
for i = 1:Q
    aux_d = [];
    for k = 1:Q
        aux = 0;
        if i~=k
            for m = 1:M
                aux = aux + abs(solution(i, m) - solution(k, m));
            end
        else
            aux = NaN;
        end
        aux_d(k) = aux;
    end
        di(i) = min(aux_d);
end
d = mean(di);
aux_S = 0;
[nn, oo] = size(di);
for ii = 1:oo
    aux_S = aux_S + (di(ii) - d)^2;
end
S =  sqrt(1/Q * aux_S);
end

%% minspacing
function [MS] = minspacing(solution, R)
MS = 1
end
function dist = euc_dist(point_a, point_b)
 [col]= size(point_a);
 aux = 0;
 for i = 1:col
     aux = aux + ( point_a(i) - point_b(i) )^2;
 end
  dist = sqrt(aux);
end
%% Inverted Generation Distance Plus (IGD +)
function [IGD] = igd(solution, R)
IGD = mean(min(pdist2(solution, R), [], 2));
end
