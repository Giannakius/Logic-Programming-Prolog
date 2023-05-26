%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Εργασια 6 Λογικου Προγραμματισμου %%
%% Τουρνης Ιωάννης ~ sdi2000192      %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- use_module(library(clpfd)).
:- use_module(library(ic)).


% Find Puzzles Here : https://cgi.di.uoa.gr/~takis/skyscr_data.pl
:- [skyscr_data].


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

skyscr(PuzzleId, Solution) :-
    puzzle(PuzzleId, Size, RowVisibleLeft, RowVisibleRight, ColVisibleUp, ColVisibleDown, GridTemplate),
    length(GridTemplate, Size),         % Το GridTemplate έχει μεγεθος ίσο με το Size
    validateGrid(GridTemplate, Size),   % Επικύρωση του GridTemplate
    solve(GridTemplate, RowVisibleLeft, RowVisibleRight, ColVisibleUp, ColVisibleDown, Solution). % Επίλυση του προβλήματος
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

validateGrid([], _).
validateGrid([Row|Rest], Size) :-
    length(Row, Size),                  % Κάθε γραμμή έχει μήκος ίσο με το μέγεθος
    validateRow(Row, Size),             % Επικύρωση της γραμμής
    validateGrid(Rest, Size).           % Επικύρωση των υπόλοιπων γραμμών


validateRow(Row, Size) :-
    fd_domain(Row, 1, Size),        % Οι αριθμοί στη γραμμή είναι ακεραίοι από 1 έως Size
    all_distinct(Row).             % Οι αριθμοί στη γραμμή είναι διαφορετικοί

fd_domain([], _, _).
fd_domain([Variable|Rest], Min, Max) :-
    Variable in Min..Max,
    fd_domain(Rest, Min, Max).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

solve(Grid, RowVisibleLeft, RowVisibleRight, ColVisibleUp, ColVisibleDown, Output) :-

    transpose(Grid, Transposed),    % Flip the list of lines into styles
    
    all_lists_different(Transposed),   % All elements must be different in the lines (1 time each)

    find_solutions(Grid,RowVisibleLeft,Out),    % From Left Find Solutions 
    
    reverse_lists(Grid,GridFromRight),  % Flip the list from left to right ([1,2,3] -> [3,2,1])
    
    find_solutions(GridFromRight,RowVisibleRight,Out),  % From Right Find Solutions    

    find_solutions(Transposed,ColVisibleUp,Out),    % From Up to Down Find Solutions 
    
    reverse_lists(Transposed,TransposedDownToUp),   % Flip the list from Down to Up
    
    find_solutions(TransposedDownToUp,ColVisibleDown,Out), % From Down to Up Find Solutions 

    search(Grid,0,input_order,indomain,complete,[]), % Find The Solution Compination

    Output = Grid.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



find_solutions([], [], Out).

find_solutions([First|Grid], [Start|RowVisibleLeft], Out) :-        % If in the list you receive, this line 
    Start \= 0,                                                     % does not have a restriction of 0 for 
    left_count_visible(First, 0, 0, Out_Sum),                       % the houses that are visible
    Out_Sum == Start, 
    find_solutions(Grid, RowVisibleLeft, Out).

find_solutions([First|Grid], [Start|RowVisibleLeft], Out) :-    
    Start == 0,                                                     % If its 0 Skip and go to the next line to check
    find_solutions(Grid, RowVisibleLeft, Out).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

left_count_visible([], _, Out, Out).                    % Count How many Houses are visible from 
                                                        
left_count_visible([X|Xs], MaxHeight, Sum, Out) :-      % the start to the list till the end
    X #> MaxHeight,
    NewSum is Sum + 1,
    left_count_visible(Xs, X, NewSum, Out).

left_count_visible([X|Xs], MaxHeight, Sum, Out) :-
    X #=< MaxHeight,
    left_count_visible(Xs, MaxHeight, Sum, Out).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

reverse_lists([], []).                                          % reverse_lists ([1,2,3] -> [3,2,1])
reverse_lists([List|Lists], [Reversed|ReversedLists]) :-
    reverse_list(List, Reversed),
    reverse_lists(Lists, ReversedLists).

reverse_list([], []).
reverse_list([Head|Tail], Reversed) :-
    reverse_list(Tail, ReversedTail),
    append(ReversedTail, [Head], Reversed).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

all_lists_different([]).                                   % Check if all the variables in the list is different
all_lists_different([First|Rest]) :-
    all_distinct(First),
    all_lists_different(Rest).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
