# Logic-Programming-Prolog ~ 
Solved Exercises from the Kapodistrian University of Athens (DIT - UOA )in the course Logic Programming 2023.

The first 3 exercises (pancakes, assignment, crossword) are in the 1st pdf.

To Run pancakes.pl use : ``` pancakes_dfs([3, 2, 4, 1], Operators, States).```


To Run assignment.pl use :``` assignment(3, 14, ASP, ASA).```

The program you write must return all its different solutions
problem, considering that the people involved in the assignment are
equivalent to each other. This means that for a given assignment to N individuals, it is
correct and all N! assignments that result if we transpose the individuals with all
possible ways, but, in essence, they are all the same. The
your program should return only one of them.


To Run crossword.pl use : ``` crossword(S) ```and here is the input of an example Crossword puzzle

Given also an event with predicate words/1 through which the are given
words to be placed in the crossword, define a predicate
crossword/1 which returns the list of available words in the order that
these can be placed in the crossword, first the horizontal ones and then the
vertical.For example, if the
```
dimension(5).
black(1,3).
black(2,3).
black(3,2).
black(4,3).
black(5,1).
black(5,5).
words([adam,al,as,do,ik,lis,ma,oker,ore,pirus,po,so,ur]).
```

The correct answer to the previous crossword, namely the one that should
return crossword/1, is the ```S = [as,po,do,ik,ore,ma,ur,lis,adam,so,al,pirus,oker].```
