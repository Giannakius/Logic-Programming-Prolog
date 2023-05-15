# Logic-Programming-Prolog ~ 
Solved Exercises from the Kapodistrian University of Athens (DIT - UOA )in the course Logic Programming 2023.

## NumPart.pl :
This problem accepts a number N, and returns 2 lists of N/2 elements each. These two lists must have the sum of all its elements equal to the sum of the other list, but the same should also apply to the sum of their squares.

To run the code use : ```numpart(N, L1, L2).``` , where N you can put whatever number you want the problem to be solved.


## MaxSat.pl :
The object of this exercise is not to solve the problem of the maximum satisfiability as an optimization problem through the logic technique of constrained programming and the branch-and-block method. As to the Prolog representation of a type in SCM, this will be done through one lists of lists, where each inner list encodes a sentence including as elements the indicators of the prepositions involved symbols, with a positive sign, if it is without negation in the sentence and with negative, if they have negation. That is, the above formula could represented as: [[1,-2,4],[-1,2],[-1,-2,3],[-2,-4],[2,-3],[1,3],[- 3,4]]

To run the code use : ```maxsat(NV, NC, D, F, S, M).``` example : ```seed(7777), maxsat(30, 100, 15, F, S, M).```, where : 

NV = Sum of Variables.
NC = Sum of Sentence.
D  = Sentence Density.
F  = The formula returned by create_formula
S  = Τhe solution, as a list of 1 and 0 (1 = true, 0 = false).
M  = Τhe (optimal) number of propositions of the type that are true.

