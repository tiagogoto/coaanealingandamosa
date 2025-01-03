%run ZDT2 
% Amosa  

% run the Viennet
clear all
fun_name = "ZDT2_";
problem = "ZDT2";
score = [];
timetable =[];
for run_num = 1:50
%run_num = string(2);

filename = strcat(fun_name, string(run_num));
filename = strcat('amosa/', filename);
file_solutions = strcat(filename, "_solutions");
file_archive = strcat(filename, "_archive");
tic;
initime = cputime();
time1 = clock;
Tmax = 200;
Tmin = 0.00000001;
N = 600;
HL = 75;
SL = 100;
alpha = 0.85;
Temp = Tmax;
nof = 2;
nov = 30;
xmax = ones(1,nov);
xmin = zeros(1, nov);
b = 0.5;
% inicializando o archive e soluções
evaluate = 0;
[archive, solution] = iarchive(SL, nov, xmin, xmax);
%figure(1)
%scatter(solution(:, 1), solution(:,2))
ale_index = randi([1,SL]);
xi(:) = archive(ale_index, :);
solutioni(:) = solution(ale_index, :);
aux_fun = [];
aux_cont = 1;
temp_array = [];
fun = [];
%fh = figure;
% inicializando o Loop, 
while Temp > Tmin
    lenght = 0;
    while lenght <= N
        cont = 0;
        res = 0;
        while res == 0
            xj = newsolution(xi, b, nov, xmax, xmin); %xi, b, nov,  maxv, minv
            res = restriction(xj);
            cont = cont + 1; 
        end
        %disp('new solution was generate!')
        solutionj = fobj(xj);
        evaluate = evaluate + 1;
        R = maxmin(solution);
        aux1 = 0;
        aux2 = 0;
        for j = 1:nof
            if solutioni(j) <= solutionj(j)
                aux1 = aux1 +1;
            elseif solutionj(j) <= solutioni(j)
                aux2 = aux2 +1;
            end
        end
            
        % If to determine the cases will be analysis
        % Case 1 -  the current solution dominate the 
        if aux1 == nof
            deldom = 0;
            amount = 0;
            %disp('case 1')
            dom_i_j = dom(solutioni, solutionj, R);
            [lines, ~] =size(archive);
            for i = 1:lines
                aux3 = 1;
                if is_dominated(solution(i, :), solutionj) == 1
                    amount = dom(solution(i, :), solutionj, R);
                    deldom = deldom + amount;
                end 
            end
            dom_avg = deldom + dom_i_j;
            prob = 1/ (1 + exp(dom_avg/Temp));
            p = rand();
            if p <= prob
                xi = xj;
                solutioni = solutionj;
                %disp('New solution was accepted, case 1')
            end
            %---------------------------------------------------------
            %case 3 -  the new solution dominate the current solution
        elseif (aux2 == nof) 
            % case 3 - a)
            ind_k = 0;
            count = 0;
            deldom = 10000000000;
            [lines, ~] = size(archive);
            for o = 1:lines
                isdom = is_dominated(solution(o, :), solutionj);
                if isdom == 1
                    count = count + 1;
                    amount  = dom(solution(o, :), solutionj, R);
                    if amount < deldom
                        deldom = amount;
                        ind_k = o;
                    end
                end
            end
            if count > 0
                %disp('New solution was accepted, case 3-a')
                prob = 1/(1 + exp(-deldom));
                if rand() <= prob
                    xi = archive(ind_k, :);
                    solutioni = solution(ind_k,:);  
                else
                    xi = xj;
                    solutioni = solutionj;
                end
%-----------------------------------------------------------------
            % case 3 - b) the newsolution and archive solution are
            % non-dominating
            elseif count == 0
                %disp('New solution was accepted, case 3-b')
                [linhas, col] = size(archive);
                % check if the current solution is in archive, If is in
                % archive, it is removed.
                 for i = 1:linhas
                    if xi == archive(i, :)
                        archive(i, :) = [];
                        solution(i, :) = [];
                        break;
                    end
                end
                % remove all solution in archive dominated by new solution
                [archive, solution] = delete(archive, solution, solutionj);
                %disp('Deletados')
                % if archive > HL, do the cluster
                if size(archive) > SL
                    [archive, solution] = clust(archive, solution, HL);
                    %disp('clusterizado')
                end
                %set the new solution as current solution 
                [lines, ~] = size(archive);
                xi = xj;
                solutioni = solutionj;
                archive(lines + 1,: ) = xi;
                solution(lines + 1, : ) = solutioni;               
                
            end
%--------------------------------------------------------------------------
            % case 2
        else
            count = 0;
            deldom = 0;
            [lines, ~] = size(archive);
            for o = 1:lines
                isdom = is_dominated(solution(o, :), solutionj);
                if isdom == 1
                    count = count + 1;
                    amount  = dom(solution(o, :), solutionj, R);
                    deldom = deldom + amount;
                end
            end
        % case 2 - a)
            if count > 0
                dom_avg = deldom;
                prob = 1 / (1.0 + exp(dom_avg/Temp));
                p = rand();
                if p <= prob
                    xi = xj;
                    solutioni = solutionj;
                    %disp('New solution was accepted, case 2-a')
                end
                % case 2 b)
            elseif (count == 0)
                %disp('New solution was accepted, case 2-b')
                ind_del = [];
                [archive, solution] = delete(archive, solution, solutionj);
                %disp('Deletados')
                [lines, ~] = size(archive);
                xi = xj;
                solutioni = solutionj;
                archive(lines + 1,: ) = xi;
                solution(lines + 1, : ) = solutioni;
                % if the acrhive size is greater than SL, do the clusterization
                if (lines + 1) > SL
                    [archive, solution] = clust(archive, solution, HL);
                end
            end  % end of IF of case 2
        end
        [arc_size, ~] = size(archive);
        %fprintf('size: %d \n', arc_size);
        lenght = lenght + 1;
        aux_fun(lenght, :, aux_cont) = solutioni;
    end % end of second While
    temp_array(aux_cont) = Temp;
    fun(aux_cont, :) = solutioni;
    Temp = Temp * alpha;
    [linhas, ~] = size(archive);
    fprintf('temp: %f, archive size %d \n', Temp, linhas);
    aux_cont = aux_cont + 1;
    %figure(2)
    %scatter(solution(:,1), solution(:,2))
    
    
end % first while
fintime = cputime;
elapsed = toc;
time2 = clock;

fprintf('TIC TOC: %g\n', elapsed);
fprintf('CPUTIME: %g\n', fintime - initime);
fprintf('CLOCK:   %g\n', etime(time2, time1));
fprintf('Evaluate: %g\n', evaluate);

filenamepareto = strcat(problem, "_pareto.dat");
true_sol = readmatrix(filenamepareto);
figure(2)
scatter(solution(:,1), solution(:,2), 35, 'r', 'filled')
hold on;
scatter(true_sol(:, 1), true_sol(:, 2), 'c')
hold off;
title('AMOSA')
xlabel('f1(x)')
ylabel('f2(x)')
zlabel('f3(x)')
legend('ZDT2', 'location', 'best')
saveas(figure(2), strcat(filename, '.png'));

%vv=0:0.0001:1;
%ff = (1 - sqrt(vv));
%plot(vv, ff);
%legend({'Pareto Front', 'Pareto Front Reference'}, 'location','best' )
save(filename)
save(file_solutions, 'solution')
save(file_archive, 'archive')
timetable(run_num, :) = [elapsed, abs(fintime - initime), etime(time2, time1), evaluate ];
[score(run_num, :)] = benchmark(solution, problem);
end
path_score = strcat(filename, '_score.txt');
path_time = strcat(filename, '_time.txt');
writematrix(score, path_score, 'Delimiter', 'space');
writematrix(timetable, path_time, 'Delimiter', 'space');
%--------------------------------------------
function [sol] = fobj(x)
  [l, nov] = size(x);
    sol( 1 ) = x(1);
    aux = 0;
    for i = 2:30
        aux = aux + x(i);
    end 
    g = 1 + 9 / 29 * aux;
    %h = 1 - sqrt(solution(1) / g);
    h = 1 - (sol(1)/g)^2;
    %h = 1 - sqrt(solution(1)/g) - (solution(1)/g)*sin(10*pi*x(1));
    sol( 2 ) = g * h;
end

function res = restriction(x)
    res = 1;
end

function [arc,sol] = iarchive(SL, nov, minv, maxv)
arc = [];
sol = [];
for ii=1:SL
    for jj = 1:nov
        arc(ii, jj) = minv(jj) + rand() * (maxv(jj) - minv(jj));
    end
        sol(ii, :) = fobj(arc(ii, :));
end
end


function [archive, solution] = clust(archive, solution, HL)
    [a, b] = size(archive);
    while (a - HL) > 0
        cont = 1;
        min_list = zeros(a,a);
        while cont <= a 
            for k = 1:(a)
                if k == cont
                    min_list(k , k) = 0;
                else
                    aux = 0;
                    for i = 1:b
                        aux = aux + abs(archive(cont, i)^2 - archive(k, i)^2);
                    end
                    min_list(cont, k) = sqrt(aux); 
                end
            end
            cont = cont + 1;
        end
        %[min_value, posi] = min(min_list(min_list>0))
        %[position] = find(min_list == min_value)
        minimo = 100000;
        posi = [];
        for i = 1:a
            for j = 1:a
                if min_list(i,j) < minimo && i ~=j
                    minimo  = min_list(i, j);
                    posi = [i, j];
                else
                    continue;
                end
            end
        end
        archive(posi(1), :) = [];
        solution(posi(1), :) = [];
        [a, b] = size(archive);
    end
end
function [R] = maxmin(solarchive)
    [~, col] = size(solarchive);
    for i = 1:col
        R(i) = max(solarchive(:,i)) - min(solarchive(:,i));
    end
end

function [deltadom] = dom(soli, solj, R)
   deltadom = 1;
   [~, col] = size(soli);
    for  i = 1:col
        if soli(i) ~= solj(i)
            deltadom = deltadom * abs(soli(i) - solj(i))/R(i);
        end
    end
end
function [xj] = newsolution(xi, b, nov,  maxv, minv)
    status = 0;
    while status ~= 1
        xj = xi;
        res = 0;
        cont = 0;
        delta = 0;
        var_ind = randi([1,nov], 1,1);
        number = rand();
        if (number - 0.5) < 0
            delta = b * log(1 - 2 * b * abs(number - 0.5));
        else
            delta = - b * log(1 - 2 * b * abs(number - 0.5));
        end
        xj(var_ind) = xi(var_ind) + delta;
        if (xj(var_ind) >= minv(var_ind)) && (xj(var_ind) <= maxv(var_ind))
            status = 1;
        else
            status = 0;
        end
    end
end

function [dominance] = is_dominated(a, b)
[~, nof] = size(a);
cont_less = 0;
cont_equal = 0;
for i = 1:nof
    if a(i) < b(i)
        cont_less = cont_less + 1;
    elseif a(i) == b(i)
        cont_equal = cont_equal + 1;
    end
end
if ((cont_equal + cont_less) == nof) && cont_less > 0
    dominance = 1;
else
    dominance = 0;
end
end

function [archive, sol] = delete(archive, sol, a)
    [lines, nof] = size(archive);
    k = 0;
    h = 1;
    list_remove = [];
    for uu = 1:lines
        if is_dominated(a, sol(uu, :)) == 1
            k = k + 1;
            list_remove(end +1) = uu;
        else
            
            h = h + 1;
        end
    end
    archive(list_remove, :) = [];
    sol(list_remove, :) = [];
end
