function [res] = restriction(x, problem)
switch problem
    case "DTLZ1"
        res = 1;
    case "DTLZ2"
        res = 1;
    case "DTLZ3"
        res = 1;
    case "DTLZ4"
        res = 1;
    case "DTLZ5"
        res = 1;
    case "DTLZ6"
        res = 1;
    case "DTLZ7"
        res = 1;
    case "Viennet"
        res = 1;
    case "MO1"
        res = 1;
    case "MO2"
        res = 1;
    case "kursawe"
        res = 1;
    case "poloni"
        res = 1;
    case "ZDT1"
        res = 1;
    case "ZDT2"
        res = 1;
    case "ZDT3"
        res = 1;
    case "ZDT4"
        res = 1;
    case "ZDT6"
        res = 1;
    case "binh"
        res = bihn_res(x);
    case "chankong"
        res = Chankong_res(x);
    case "constr"
        res = constr_res(x);
    case "TNK"
        res = TNK_res(x);
end
end