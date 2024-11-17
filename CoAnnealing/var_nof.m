function [nof, nov, maxv, minv] = var_nof(problem)
switch problem
      case "DTLZ1"
        nof = 3;
        nov = 12;
        maxv = ones(1,nov);
        minv = zeros(1,nov);
    case "DTLZ2"
        nof = 3;
        nov = 12;
        maxv = ones(1,nov);
        minv = zeros(1,nov);
    case "DTLZ3"
        nof = 3;
        nov = 12;
        maxv = ones(1,nov);
        minv = zeros(1,nov);
    case "DTLZ4"
        nof = 3;
        nov = 12;
        maxv = ones(1,nov);
        minv = zeros(1,nov);
    case "DTLZ5"
        nof = 3;
        nov = 12;
        maxv = ones(1,nov);
        minv = zeros(1,nov);
    case "DTLZ6"
        nof = 3;
        nov = 12;
        maxv = ones(1,nov);
        minv = zeros(1,nov);
    case "DTLZ7"
        nof = 3;
        nov = 12;
        maxv = ones(1,nov);
        minv = zeros(1,nov);
    case "Viennet"
        nof = 3;
        nov = 2;
        maxv = [3, 3];
        minv = [-3, -3];
    case "MO1"
        nof = 2;
        nov = 1;
        maxv = ones(1,nov)*10;
        minv = ones(1,nov)*(-10);
    case "MO2"
        nof = 2;
        nov = 1;
        maxv = ones(1,nov)*10;
        minv = ones(1,nov)*-5;
    case "kursawe"
        nof = 2;
        nov = 3;
        maxv = [5, 5, 5];
        minv = [-5,-5,-5];
    case "poloni"
        nof = 2;
        nov = 2;
        maxv = [pi, pi];
        minv = [-pi, -pi];
    case "ZDT1"
        nof = 2;
        nov = 30;
        maxv = ones(1,30);
        minv = zeros(1,30);
    case "ZDT2"
        nof = 2;
        nov = 30;
        maxv = ones(1,30);
        minv = zeros(1,30);
    case "ZDT3"
        nof = 2;
        nov = 30;
        maxv = ones(1,nov);
        minv = zeros(1,nov);
    case "ZDT4"
        nof = 2;
        nov = 10;
        maxv = [1, 5, 5, 5, 5, 5, 5, 5,5 ,5 ];
        minv = [0 , -5, -5,-5,-5,-5,-5,-5,-5,-5];
    case "ZDT6"
        nof = 2;
        nov = 10;
        maxv = ones(1,nov);
        minv = zeros(1,nov);
    case "binh"
        nof = 2;
        nov = 2;
        maxv = [5,3];
        minv = [0,0];
    case "chankong"
        nof = 2;
        nov = 2;
        maxv = [20,20];
        minv = [-20,-20];
    case "constr"
        nof = 2;
        nov = 2;
        maxv = [1, 5];
        minv = [0.1, 0];
    case "TNK"
        nof = 2;
        nov = 2;
        maxv = [pi, pi];
        minv = [0, 0];
end
end