% Εργασια 3 Λογικου Προγραμματισμου %
% Τουρνης Ιωάννης ~ sdi2000192      %
%                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%% "INPUT HERE" %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            %% "Words To Put in Puzzle" %% 
%words([do,ore,ma,lis,ur,as,po, so,pirus, oker,al,adam, ik]) .

%% "Size Input" %%

%dimension(5).                               % "Uncomment Here To Run"

%% "Black Cells Input" %%
   %black(1,3).
   %black(2,3).
   %black(3,2).
   %black(4,3).
   %black(5,1).
   %black(5,5).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

crossword(Solved_Puzzle) :-
   
   words(WordList),                             % A list with all the Words
   word_to_chars(WordList,CharsList),           % A list with all the Words in Ascii 
   
   dimension(Size),                             % Gets the dimension of the puzzle.
   create_lines(Size,Puzzle),                   % Creates N x N Array in Lists.
   findall(black(I,J),black(I,J),Blacks) ,      % Get all black() inside Blacks List.
   fill_blacks(Blacks,Puzzle),                  % Fill The Puzzle Lists with the Blacks
   split_the_empty_words(Puzzle,Empty_Words),   % Split the words into those with only spaces without containing "blacks"

   fill_with_words(CharsList,Empty_Words),      % Fill The empty word lists with the Words , in AScii Code
   word_to_chars(Solved_Puzzle,Empty_Words),    % Convert The Ascii Chars to Alphabet!
   
   print_Solution(Puzzle).                      % Print The Puzzle Solved , Puzzle Contains List In Lists with all the Lines Of the NxN Board "[[X01,X02,###,X03,X04],[X05,X06,###,X07,X08],[X09,###,X10,X11,X12],[X13,X14,###,X15,X16],[###,X17,X18,X19,###]])"


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


word_to_chars([],[]).                       % This Functions Converts The Words List in Ascii-Word List.

word_to_chars([Word|RestWords] ,[Chars|RestChars] ) :-
   name(Word,Chars),
   word_to_chars(RestWords,RestChars).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


fill_with_words([],[]).                               % This Function Fills The Empty Lists With Words

fill_with_words([Word|Rest_Words],Puzzle) :-
   select_and_delete(Word,Puzzle,Rest_Puzzle),        % Selects an element and removes from the Puzzle.
   fill_with_words(Rest_Words,Rest_Puzzle).


select_and_delete(X, [X|Xs], Xs).                     % This Functions Deletes a element from the List

select_and_delete(X, [Y|Ys], [Y|Zs]) :-
   select_and_delete(X, Ys, Zs).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%make_empty_words(Empty_Words) :-
%   dimension(Size),                             % Gets the dimension of the puzzle.
%   create_lines(Size,Puzzle),                   % Creates N x N Array in Lists.
%   findall(black(I,J),black(I,J),Blacks) ,      % Get all black() inside Blacks List.
%   fill_blacks(Blacks,Puzzle),                  % Fill The Puzzle Lists with the Blacks
%   split_the_empty_words(Puzzle,Empty_Words).   % Get the Empty_Words without blacks πχ [_,_,black,_,_] == [_,_] , [_,_].


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


create_lines(Size,Puzzle) :-
   length(Puzzle,Size),                      % Creates an EMPTY list with dimension Size().
   create_columns(Puzzle,Size).              % δηλαδη : [_,_,_,_,_] dimension(5)


create_columns([],_).
create_columns([First_Element|Rest_List],Size) :-
   length(First_Element,Size),                           % Creates N Lists , With N Size , So i have created NxN Array in Lists.
   create_columns(Rest_List,Size).                       % δηλαδη : [_,_,_,_,_] , [_,_,_,_,_] , [_,_,_,_,_] , [_,_,_,_,_] , [_,_,_,_,_]



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fill_blacks([],_).             % This Functions Fills The Puzzle Lists Thats black() with the word "black"  

fill_blacks([black(I,J)|Blacks],Puzzle) :-        
   find_the_nth_element(I,Puzzle,LineI),
   find_the_nth_element(J,LineI,black),
   fill_blacks(Blacks,Puzzle).



find_the_nth_element(1, [X|_], X).              % This Function finds the N-th Element on a List and Retruns It

find_the_nth_element(N, [_|Xs], Y) :-           % Backtracking until go to the first element and then return.
   N > 1,
   Temp is N - 1,
   find_the_nth_element(Temp, Xs, Y).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


split_the_empty_words(Puzzle,Empty_Words) :-       % Get the Empty_Words without blacks πχ [_,_,black,_,_] == [_,_] , [_,_].

   split_helper(Puzzle,Empty_Words,TailEmpty_Words),
   dimension(Size),
   antistrophe_array(Size,Puzzle,[],AntistrophePuzzle),       % Antistrefei ton Puzzle kai epistrefei ton AntistrophePuzzle
   split_helper(AntistrophePuzzle,TailEmpty_Words,[] ).



split_helper([],Empty_Elements_List,Empty_Elements_List).

split_helper([Line|Rest_Lines],Empty_Elements_List,EsTail) :-

   empty_words_on_one_line(Line,Empty_Elements_List,Es1) ,
   split_helper(Rest_Lines,Es1,EsTail).




empty_words_on_one_line([], Tail, Tail).                % If list is empty

empty_words_on_one_line([Element1,Element2|Rest_Line],[[Element1,Element2|Empty_Elements_List]|R],Tail) :-

   var(Element1), var(Element2), !,                      % If this two Elements is empty continue , else stop here. (Empty = not black)
   find_empty_till_black(Rest_Line,Output,Empty_Elements_List),       % Find the empty spaces till black.
   empty_words_on_one_line(Output,R,Tail) .

empty_words_on_one_line([_| Output],R, Tail) :-
   empty_words_on_one_line(Output,R,Tail) .


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

find_empty_till_black([],[],[]).


find_empty_till_black([First_Element|Rest_List],Output,Empty_Var_List) :-     
   var(First_Element) ,                            % If First_Element = empty
   Empty_Var_List = [First_Element|RestElements],  % Put the First_Element to the Empty List
   find_empty_till_black(Rest_List , Output , RestElements).   % Continue the Search with the rest List.


find_empty_till_black([First_Element|Rest_List],Output,Empty_Var_List) :-     
   Output = Rest_List,              % Else If First_Element = not empty , diladi First_Element = black.
   Empty_Var_List = [].             % Then Return the List with the Empty Elements Without the last one (First_Element) , the Rest_List.               


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

antistrophe_array(0,Puzzle,Temp_Out_Array,Temp_Out_Array) .                    % If Puzzle Array is empty Return Empty


antistrophe_array(N,Puzzle ,Temp_Out_Array ,AntistrophePuzzle) :-              % if not empty

   return_nth_elements_from_puzzle(N,Puzzle,Out),          % Returns the Nth Element from ALL the Lists in Puzzle.

   Temp is N - 1,                      % Go to next position [1,2,3],[4,5,6],[7,8,9] , OUT == [1,4,7],[2,5,8],[3,6,9]
   
   antistrophe_array(Temp,Puzzle,[Out|Temp_Out_Array] , AntistrophePuzzle).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

return_nth_elements_from_puzzle(_,[],[]).       % Returns the Nth Element from ALL the Lists in Puzzle.


return_nth_elements_from_puzzle(N, [First_List | Rest_Lists] , [Out | Rest_Out] ) :-

   find_the_nth_element(N , First_List , Out ),          % Find the Nth element in First_List

   return_nth_elements_from_puzzle(N , Rest_Lists , Rest_Out ).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



print_Solution([]).           % Empty list

print_Solution([H|T]) :-       % Recursive case: non-empty list
   print_chars(H),             % Print the characters in the first list
   put(10),                    % Change Line
   print_Solution(T).          % Recursively print the remaining lists

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

print_chars([]).              % Empty list

print_chars([H|T]) :-         
   H == black, print("###"),  % Blacks , print "###"
   put(32),                   % Print Space
   print_chars(T).            % Recursively print the remaining lists


print_chars([H|T]) :-         
   name(Temp,[H]),            % Convert Ascii To Alphabet
   print(Temp),               % Print the character
   put(32),                   % Print Space
   print_chars(T).            % Recursively print the remaining characters

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%"You Have Solved The Puzzle GG xD"%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%