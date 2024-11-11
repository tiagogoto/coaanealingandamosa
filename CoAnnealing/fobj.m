function [sol] = fobj(x, problem)
switch problem
    case "DTLZ1"
        sol = DTLZ1(x);
    case "DTLZ2"
        sol = DTLZ2(x);
    case "DTLZ3"
        sol = DTLZ3(x);
    case "DTLZ4"
        sol = DTLZ4(x);
    case "DTLZ5"
        sol = DTLZ5(x);
    case "DTLZ6"
        sol = DTLZ6(x);
    case "DTLZ7"
        sol = DTLZ7(x);
    case "Viennet"
        sol = Viennet(x);
    case "MO1"
        sol = MO1(x);
    case "MO2"
        sol = MO2(x);
    case "kursawe"
        sol = kursawe(x);
    case "poloni"
        sol = poloni(x);
    case "ZDT1"
        sol = ZDT1(x);
    case "ZDT2"
        sol = ZDT2(x);
    case "ZDT3"
        sol = ZDT3(x);
    case "ZDT4"
        sol = ZDT4(x);
    case "ZDT6"
        sol = ZDT6(x);
    case "binh"
        sol = binh(x);
    case "chankong"
        sol = chankong(x);
    case "constr"
        sol = constr(x);
    case "TNK"
        sol = TNK(x);
end
end
