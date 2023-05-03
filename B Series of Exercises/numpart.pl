%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Εργασια 4 Λογικου Προγραμματισμου %%
%% Τουρνης Ιωάννης ~ sdi2000192      %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

numpart(N, L1, L2) :-
    N mod 2 =:= 0,          % N must be even, otherwise the table cannot be divided into 2 equal parts
    sum_to_N(N,Sum),        % Calculation of sum from 1 to N
    HalfSum is (Sum // 2),  % Computation of half of sum_to_N

    numpart_helper(1,N,HalfSum, 0, 0,[],[], L1, L2).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

numpart_helper(_,N,HalfSum, Sum1, Sum2, L1 , L2 , L1, L2) :-    % Successful  solution
    
    Sum1 is HalfSum , Sum2 is HalfSum ,             % If the sums of the 2 lists are equal to HalfSum
    square_list(L1, 0 ,Sum_List1),                  % Calculation of Sum of Square of list L1
    square_list(L2, 0 ,Sum_List2),                  % Calculation of Sum of Square of list L2   
    Sum_List1 is Sum_List2,                         % If the sum of the squares of the 2 lists is equal
    
    check_one(L1).            % Additional restriction: There must be 1 in List L1, to avoid duplicates

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Case 1: I belongs to L1

numpart_helper(I,N,HalfSum, Sum1, Sum2, Temp_L1, Temp_L2 , L1, L2) :-
    I =< (N+1), 
    
    Sum11 is (Sum1 + I),
    Sum11 =< HalfSum,           % The sum of all elements of L1 should not exceed HalfSum

    length(Temp_L1,Megethos1),
    N_div_2 is (N // 2),        % The size of each list can be at most N/2
    Megethos1 =< (N_div_2 - 1), 

    append(Temp_L1, [I], New_Temp_L1),
    
    New_i is (I + 1),
    numpart_helper(New_i,N,HalfSum, Sum11, Sum2, New_Temp_L1, Temp_L2 , L1, L2).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Case 1: I belongs to L2

numpart_helper(I,N,HalfSum, Sum1, Sum2, Temp_L1, Temp_L2 , L1, L2) :-
    I =< (N+1),
    
    Sum22 is (Sum2 + I),
    Sum22 =< HalfSum,

    length(Temp_L2,Megethos2),                %Likewise for the L2 list  
    N_div_2 is (N // 2),
    Megethos2 =< (N_div_2 - 1),    

    append(Temp_L2, [I], New_Temp_L2),
    
    New_i is (I + 1),
    numpart_helper(New_i,N,HalfSum, Sum1, Sum22, Temp_L1, New_Temp_L2 , L1, L2).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sum_to_N(1,1).
sum_to_N(N,Result) :-               % Calculate sum of elements from 1 to N
    N > 1, Prev is N-1, 
    sum_to_N(Prev, PrevSum), 
    Result is PrevSum + N.



square_list([], Sum , Sum).
square_list([X|Xs], Temp_Sum ,Sum) :-       % Calculates the sum of squares of all elements in the list. 
   Y is X*X,
   New_Temp_Sum is (Temp_Sum + Y),
   square_list(Xs, New_Temp_Sum , Sum).



check_one([]) :- false.                     % If number 1 is in the list, return true, otherwise false.
check_one([1|_]) :- true.
check_one([_|Xs]) :- check_one(Xs).
