clear all
%problem = "MO1";
%problem = "MO2";
%problem = "kursawe";
problem = "poloni";
%problem = "ZDT1";
%problem = "ZDT2";
%problem = "ZDT3";
%problem = "ZDT4";
%problem = "ZDT6";
%problem = "Viennet"
%problem = "DTLZ1";
%problem = "DTLZ2";
%problem = "DTLZ3"; % problema? 
%problem = "DTLZ4"; % não rodou verificar
%problem = "DTLZ5"; % roda
%problem = "DTLZ6"; %com problema referência ?
%problem = "DTLZ7"; 
%problem = "binh"; 
%problem = "chankong";
%problem = "constr"
%problem = "TNK";
%run = 133;
score = [];
timetable = [];
Tmax = 200;
Tmin = 0.00000001;
N = 500;
alpha = 0.95; %85;
HL = 75;
SL = 100;
filename_aux = strcat(problem, "coannealing");

filenamepareto = strcat(problem, "_pareto.dat");
true_sol = readmatrix(filenamepareto);
aux = [];
for run = 1:150
filename = filename_aux;    

filename = strcat(filename,string(run));

[nof, nov,~, ~] = var_nof(problem);
[archive, sol, aux(end+1, :)] = coannealing2(problem, Tmin, Tmax, N, alpha, HL, SL, filename);


filepath = strcat('results/sol', filename);
writematrix(sol, filepath, 'Delimiter', 'space')
[score(end +1, :)] = benchmark(sol, problem);



figure(4)
if nof == 2
    scatter(true_sol(:, 1), true_sol(:, 2), 'c')
    hold on;
    scatter(sol(:, 1), sol(:, 2),35, 'r', 'filled');
    hold off;
    xlabel('f1(x)');
    ylabel('f2(x)');
    title('Coannealing');
    legend({problem, 'Frente de Pareto Ótima'}, 'location', 'best')
else
    scatter3(sol(:, 1), sol(:, 2), sol(:, 3), 'r', 'filled')
    hold on;
    scatter3(true_sol(:, 1), true_sol(:, 2), true_sol(:, 3), 'c')
    hold off;
    xlabel('f1(x)');
    ylabel('f2(x)');
    zlabel('f3(x)');
    title('Coannealing');
    legend({problem, 'Frente de Pareto Ótima'}, 'location', 'best')
end
saveas(figure(4), strcat(filepath, '.png'));

end



%path_score = strcat(filepath, '_score.txt');
%writematrix(score, path_score, 'Delimiter', 'space');
%path_time = strcat(filepath, '_times.txt');
%writematrix(timetable, path_time, 'Delimiter', 'space');

%%%%%% save score



writematrix(score, strcat(filepath, 'score.txt'), 'Delimiter', 'space')
writematrix(aux, strcat(filepath, 'timetable.txt'), 'Delimiter', 'space')
