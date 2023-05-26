# Logic-Programming-Prolog ~ 
Solved Exercises from the Kapodistrian University of Athens (DIT - UOA )in the course Logic Programming 2023.

## NumPart.pl :
This problem accepts a number N, and returns 2 lists of N/2 elements each. These two lists must have the sum of all its elements equal to the sum of the other list, but the same should also apply to the sum of their squares.

To run the code use : ```numpart(N, L1, L2).``` , where N you can put whatever number you want the problem to be solved.


## MaxSat.pl :
The object of this exercise is not to solve the problem of the maximum satisfiability as an optimization problem through the logic technique of constrained programming and the branch-and-block method. As to the Prolog representation of a type in SCM, this will be done through one lists of lists, where each inner list encodes a sentence including as elements the indicators of the prepositions involved symbols, with a positive sign, if it is without negation in the sentence and with negative, if they have negation. That is, the above formula could represented as: [[1,-2,4],[-1,2],[-1,-2,3],[-2,-4],[2,-3],[1,3],[- 3,4]]

To run the code use : ```maxsat(NV, NC, D, F, S, M).``` example : ```seed(7777), maxsat(30, 100, 15, F, S, M).```, where : 

NV = Sum of Variables. <br>
NC = Sum of Sentence. <br>
D  = Sentence Density. <br>
F  = The formula returned by create_formula <br>
S  = Τhe solution, as a list of 1 and 0 (1 = true, 0 = false). <br>
M  = Τhe (optimal) number of propositions of the type that are true. <br>



## Skyscr.pl :
In this exercise you are asked to solve through constrained programming various instances, of varying difficulty, of the skyscraper puzzle (https://www.puzzle-skyscrapers.com/). In this puzzle, we have a square grid of dimension N, in each cell of which a skyscraper of integer height from 1 to N must be placed, so that in each row and column of the grid no two skyscrapers have the same height. Also, at the ends of the rows and columns of the grid (in all or only some of them) some integers are given that limit the number of skyscrapers that are visible from this point along the entire length of the row or column to the end her. It is believed that a skyscraper hides all those who they are behind him and are shorter in height. Finally, it is possible that some of the grid cells are already populated from the beginning.

To run the code use : ```skyscr(PuzzleId, Solution).``` example : ```skyscr(demo, Solution).```, where : 

PuzzleId = Puzzle Id to solve , there is ready puzzles in skyscr_data.pl file. <br>
Solution = Solution of the Puzzle. <br>

