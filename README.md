# CoAnealing and Amosa
The CoAnnealing algorithm optimization algorithm and AMOSA optimization algorithm  writen for MATLAB. 

## CoAnnealing Algorithm

The algorithm is 


``` MATLAB

[archive, CostFunctionValues, timetable] = coannealing2(problem, Tmin,Tmax, N, alpha, HL, SL, filename)

```

Where:

* archive: variable to storage
* CostFunctionValues: Objective function values of solutions in the Archive
* timetable: variable with elapsed CPU time 
* problem:  the benchmark function name
* Tmin: the minimum temperature 
* Tmax: the maximum temperatura 
* N: sencondary temperature loop
* alpha: temperature decrease factor
* HL: archive hard limites (lower limits)
* SL: archive soft limits (upper limits)
* filename: name of file to save datas

## AMOSA algorithm

The AMOSA algorithm was implement for each benchmark function, run algorithm 




## Benchmark functions

Unconstrained Benchmark function with two objective function

* ZDT1
* ZDT2 
* ZDT3
* ZDT6
* Kursawe function (name = 'kursawe')

Unconstrained Benchmark function with three objective function

* DTLZ1
* DTLZ2
* DTLZ5
* DTLZ7
* Viennet function (name = 'viennet')

Benchmark function with constraints:

* Binh and Korn function, (name='binhkorn')
* Chankong and Haimes function, (name='chankong')
* Constr-Ex problem (name= 'constrex')

## References

Goto, T. G. (2022). Propostas de heurísticas e estratégias de feedback aplicadas ao recozimento simulado (Doctoral dissertation, Universidade de São Paulo).

Martins, T. C., & Tsuzuki, M. S. G. (2015). EIT image regularization by a new Multi-Objective Simulated Annealing algorithm. Proceedings of the Annual International Conference of the IEEE Engineering in Medicine and Biology Society, EMBS, 2015-Novem, 4069–4072. https://doi.org/10.1109/EMBC.2015.7319288