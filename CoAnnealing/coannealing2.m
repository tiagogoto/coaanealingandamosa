function [archive, sol, timetable] = coannealing2(problem, Tmin, Tmax, N, alpha, HL, SL, filename)
tic;
start_time_cputime = cputime();
start_time_time = clock();
%start paramenters
temp = Tmax;
[nof, nov, maxv, minv] = var_nof(problem);
C_i =  ones(1, nov);
max_r = 20;
r = 0;
r_count = 0;
% the maximum cristallyzation factor
Cmax = 20;
timetable = [];
%srting the archive 
[archive, sol] = iarchive(SL, nov, minv, maxv, problem);
%archive = readmatrix('DTLZ1_pp2.txt');
[aa, ~] = size(archive);
%for i = 1:aa
%    sol(i, :) =  fobj(archive(i, :), problem);
%end
%figure(10)
%scatter3(sol(:, 1), sol(:, 2), sol(:, 3))
% select the current solution and the new solution 
ale = randi([1,aa]);
xi = archive(ale, :);
soli = sol(ale, :);

% information storage variables
aux_fun = [];
aux_crystal_factor1 = [];
aux_crystal_factor2 = [];
aux_count = [];
aux_acceptance = [];
aux_rejected = [];
aux_temp = [];
aux_fun2 = [];
aux_count =  1;
aux_r = 0;
evaluate_historic = 0;
%fh = figure;
% the main loop 
while temp > Tmin
    count = 1;
    % the lenght of each temperature loop, stop if the thermal equilibrium
    % is reached
    accepted = 0;
    rejected = 0;
    while count < N && accepted < N/2
        res = 0;
        while res == 0
            [xj, C_ind] = newsolution3(xi, C_i, maxv, minv, Cmax);
            res = restriction(xj, problem);
        end
        solj = fobj(xj,problem);
        evaluate_historic = evaluate_historic + 1;
        R = maxmin(sol);
        deltaE = maxdom(solj, sol, R) - maxdom(soli, sol, R);
        p = exp(-deltaE/temp);
        rand_number = rand();
        if (deltaE <= 0) || (rand_number < p) %condição verificar
            xi(:,:) = xj(:,:);
            soli = solj;
            C_i(C_ind) = round(C_i(C_ind)-1);
           if C_i(C_ind) < 1
                C_i(C_ind) = 1;
           end
           mdom = maxdom(solj, sol, R); %condição verificar
           if mdom <= 0 
                [a, ~] =  size(sol);
                archive(a + 1,: ) = xj; 
                sol(a + 1, :) = solj;
                %[archive, sol] = delete(archive, sol, solj);
                [a, ~] =  size(sol);
                if (a ) >= SL
                    %disp('clustering')
                    [archive, sol] = clusterh9(archive, sol, HL);
                    if check(xi, archive) == 0
                        r_count = r_count + 1;
                        if r_count < max_r
                            archive(end + 1, :) = xi;
                            sol(end +1, :) = soli;
                            
                        else
                            [qtd_sol, ~] = size(sol);
                            rand_number = randi([1, qtd_sol], 1,1);
                            xi = archive(rand_number, :);
                            soli = sol(rand_number, :);
                            C_i = ones(1, nov);
                            aux_r = aux_r + 1;
                            r_count = 0;
                            %fprintf('novo sorteado, índice: %f \n', rand_number);
                        end
                    else
                        r_count = 0;
                    end
                end
           end
           accepted = accepted + 1;
        else
            %if C_i(C_ind) < 20
            C_i(C_ind) = C_i(C_ind) + 1;
            %end
            rejected = rejected + 1;
        end
        count = count + 1;
        aux_fun2(count, : ) = soli;
        
        aux_crystal_factor1(count, :) = C_i(:);
    end
aux_count = aux_count + 1;
aux_temp(aux_count) = temp;
aux_fun(aux_count, :) = mean(aux_fun2);
aux_acceptance(aux_count) = accepted; 
aux_rejected(aux_count) = rejected;
aux_crystal_factor2(aux_count,:) = mean(aux_crystal_factor1);
[qtd_sol, ~] = size(sol);
fprintf('Temp.: %f , archive size.: %f \n', temp, qtd_sol)
%fprintf('r_count: %f \n', r_count)
temp = temp * alpha;
end


%determine the running time
elapsedtime = toc;
end_time_cputime = cputime();
end_time_time = clock();
fprintf('CPU time: %g \n', abs(start_time_cputime - end_time_cputime));
fprintf('TIC TOC time: %g \n', elapsedtime );
fprintf('Clock time: %g \n', etime(end_time_time, start_time_time));
fprintf('Evaluated: %d \n', evaluate_historic);
fprintf('aux_r %f \n', aux_r)
%timetable = [elapsedtime,abs(start_time_cputime - end_time_cputime), etime(end_time_time, start_time_time),evaluate_historic];
% save the date
%filename = strcat('', filename);
%save(filename)

%% Plotting informations
figure(1)
plot(aux_temp, aux_acceptance, 'r')
hold on;
plot(aux_temp, aux_rejected, 'b')
hold off;
set(gca, 'Xdir', 'reverse', 'XScale', 'log', 'fontsize', 11)
title('Solução Aceita vs Temperatura')
xlabel('Temperatura')
ylabel('Solução Aceita ou Rejeitada')
legend({'Aceito', 'Rejeitado'}, 'location', 'best')
%saveas(figure(1), strcat(filename, '_acceptance.png'));
figure(2)
plot(aux_temp, aux_fun(:, 1))
hold on;
for jj = 2:nof
plot(aux_temp, aux_fun(:, jj))
end
hold off
set(gca, 'Xdir', 'reverse', 'XScale', 'log', 'fontsize', 11)
title('Função Objetivo vs Temperatura')
xlabel('Temperatura')
ylabel('Valor da função Objetivo')
%saveas(figure(2), strcat(filename, '_objxtemp.png'));
figure(3)
plot(aux_temp, aux_crystal_factor2(:, 1))
hold on;
for jj=2:nov
    plot(aux_temp, aux_crystal_factor2(:, jj))
end
hold off;
set(gca, 'Xdir', 'reverse','XScale', 'log', 'fontsize', 11)
title('Fator de cristaliazação vs Temperatura')
xlabel('Temperatura')
ylabel('Fator de Cristalização')
%saveas(figure(1), strcat(filename, '_cristalization.png'));
end

function [R] = maxmin(sol)
[~, nof] = size(sol);
for col = 1:nof 
    R(col) = max(sol(:, col)) - min(sol(:, col));
end
end

function [maxd] = maxdom(soli, sol, R)
[L, nof] = size(sol);
aux = ones(1, L);
for i = 1:L
    for j = 1: nof
        if soli(j) < sol(i, j)
            aux(i) = 0;
            break
        elseif abs(soli(j) - sol(i, j)) < 1*10^(-6)
            aux(i) = aux(i);
        else
            aux(i) = aux(i)*(soli(j) - sol(i, j))*R(j);
        end
    end
end
maxd = max(aux);
end

function [status] = check(x, archive)
    [a, b] = size(archive);
    status = 0;
    for i = 1:a
        if archive(i, :) == x
            status = 1;
        end
    end
end

function [arc,sol] = iarchive(SL, nov, minv, maxv, problem)
arc = [];
sol = [];
for ii=1:SL
    res = 0;
    while res == 0
        for jj = 1:nov
            arc(ii, jj) = minv(jj) + rand() * (maxv(jj) - minv(jj));
        end
        res = restriction(arc(ii, :), problem);
    end
    sol(ii, :) = fobj(arc(ii, :), problem);
end
end
function [mx] = maxdomination2(sol, solarchive, R)
[L, nof] = size(solarchive);
aux = [];
for i = 1:L
   if  ~any(sol(1:nof) == solarchive(i, 1:nof))
       aux(i) = prod((sol(1:nof) - solarchive(i, 1:nof)).*R(1:nof));
   else
       aux(i) = NaN;
   end
end
mx = max(aux);
end
function [mx] = maxdomination(sol, solarchive, R)
    [L, col]=size(solarchive);
    aux=ones(1,L);
    for i=1:L 
      for j=1:col
        if sol(j) == solarchive(i, j)
          aux(i) = NaN;
          break;
        elseif sol(j) < solarchive(i,j)
          aux(i) = 0;
          break
        else
          aux(i) = aux(i) * (sol(j) - solarchive(i,j))*R(j);
        end
      end
    end
    mx = max(aux);
end
function [newarch, newsol] = delete(archive, sol, a)
    [lines, nof] = size(archive);
    k = 0;
    h = 1;
    for uu = 1:lines
        if is_dominated(a, sol(uu, :)) == 1
            k = k + 1;
        else
            newarch(h, :) = archive(uu, :);
            newsol(h, :) = sol(uu, :);
            h = h + 1;
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


