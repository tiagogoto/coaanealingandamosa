function [score] =newspacing(sol)
Distance = pdist2(sol,sol,'cityblock');
Distance(logical(eye(size(Distance,1)))) = inf;
score = std(min(Distance,[],2));
end