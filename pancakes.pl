pancakes_dfs(InitialState , Spatoula, States) :-			               % InitialState  = Αρχικη Κατασταση
   dfs(InitialState, [InitialState] , States,[],Spatoula).           	% Spatoula = Η θεση των πιτων που πρεπει να μπει η σπατουλα για να γυρισουν οι πιτες ωστε να φτασουμε σε Final_State.
                                                                        % States = Η Σειρα των πιτων μεχρι το Final_State.

%--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

dfs(State, States, States,Spatoula,Spatoula) :-				         % Ελεγχος στην dfs αν βρηκαμε Final_State
   check_final_state(State), !.

dfs(State1, Visited_States, States,Old_Spatoula ,Spatoula) :-
   
   length(State1, N),							                                 % Υπολογισμος Ν , δηλαδη των στοιχειων της λιστας State1
   between(2,N,Temp_Spatoula),						                           % Υπολογισμος ενος αριθμου "Temp_Spatoula" απο 2 εως Ν για μια τυχαια θεση που θα μπει η σπατουλα , ξεκιναμε απο τον αριθμο 2 γιατι δεν εχει ουσια να γυρισουμε την πρωτη πιτα θα εχουμε το ιδιο αποτελεσμα
   move(State1, State2, Temp_Spatoula),				            	         % Κανουμε την "κινηση" μας στο State1 στην θεση Temp_Spatoula , και επιστρεφουμε το αποτελεσμα στο State2.
   \+ member(State2, Visited_States),				               	         % Αμα το State2 δεν ειναι στην λιστα Visited_States.
   append(Visited_States, [State2], New_Visited_States),	      	         % Το προσθετουμε στην λιστα με τα States που εχουμε επισκεφτει
   find_nth_element_of_list( Temp_Spatoula , Pita_Se_Thesi_N , State1 ),   % Βρισκουμε ποια πιτα ειναι στην θεση "Temp_Spatoula" και 
   append(Old_Spatoula,[Pita_Se_Thesi_N],New_Spatoula),			            % Προσθετουμε την πιτα , στην λιστα με τις κινησης των πιτων που εχουν γινει για να φτασουμε στην λυση του προβληματος
   dfs(State2, New_Visited_States, States, New_Spatoula , Spatoula).	      % Καλουμε αναδρομικα με τα νεα ορισματα-λιστες

%--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

check_final_state(State) :-		% Ελεγχος αν το State , ειναι τελικη κατασταση δηλαδη Λυση του προβληματος
   length(State,N),
   create_final_state(N,Final_State), 
   State = Final_State.

%--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

create_final_state(1,[1]) :- !.		   % Δημιουργει το  Final_State

create_final_state(N,FL):- 		      % Final_State ειναι μια λιστα ταξινομημενη 
    N1 is N-1,				               % σε αυξουσα σειρα απο 1 εως Ν.
    N1 > 0,append(L1,[N],FL),
    create_final_state(N1,L1), !.	   % Οταν βρεις ενα Final_State σταματα την αναζητηση.

%--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

between(Start, End, X) :- 		% Δινει ολους τους αριθμους απο τον αριθμο
   Start =< End, 			      % Start εως τον End , ανεβαινοντας κατα +1 αριθμο .
   X = Start.
between(Start, End, X) :- 
   Start < End,
   New_start is Start+1, 
   between(New_start, End, X).


%--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

move(State1, State2,Spatoula) :-
   split_list(Spatoula, State1 , First_Half , Second_Half),	      % Χωρισμος των πινακων στην θεση "Spatoula"
   reverse(First_Half,Reverced_First_Half),			               % Αναποδογυρισε τον πρωτο πινακα.
   append(Reverced_First_Half,Second_Half , State2).  		      % Ενωσε τον αναποδογυρισμενο πινακα με το δευτερο μισο του προηγουμενου πινακα και βαλε το αποτελεσμα στο State2.

%--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

split_list(0,L,[],L). % (Thesi_Xwrismoy|Input_List|Output1|Output2)		% Χωρισμος Λιστας σε 2 κομματια

split_list(Index,[CompleteListHead|CompleteListTail],[CompleteListHead|FirstHalfTail],SecondHalfList) :-
    Index >= 0,
    NewIndex is Index-1,
    split_list(NewIndex,CompleteListTail,FirstHalfTail,SecondHalfList).

%--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


find_nth_element_of_list( 1 , X , [X|_]  ) :- !.		      % Η Συναρτηση μας βρισκει το Ν-οστο σημειο της λιστας Χ
								                                    % Και το επιστρεφει . Η αριθμιση της λιστας ξεκιναει απο 1.
find_nth_element_of_list( N , X , [_|Xs] ) :-
  N > 1 ,							                              % Χρησιμοποιειται για να βρουμε ποια πιτα ειναι στην θεση Ν.
  N1 is N-1 ,
  find_nth_element_of_list( N1 , X , Xs ) , !.


%--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
%------------------------------------------------------------------------     BONUS   ----------------------------------------------------------------------------------------------------------
%--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------




pancakes_ids(Initial_State, Operators, States) :-

   solve_jugs_iter(Initial_State, [Initial_State] , States , [] , Operators, 0 ).



%--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


solve_jugs_iter(State1, Visited_States , States , Old_Spatoula , Spatoula, Old_Depth ) :-


   idfs(State1, Visited_States, _ ,Old_Spatoula ,  _ , Old_Depth),!,
   idfs(State1, Visited_States, States ,Old_Spatoula ,  Spatoula, Old_Depth).

solve_jugs_iter(State1, Visited_States, States ,  Old_Spatoula , Spatoula , Old_Depth) :-

   New_Depth is Old_Depth+1,
   
   solve_jugs_iter(State1, Visited_States, States , Old_Spatoula , Spatoula , New_Depth ).



idfs(State,States, States,Spatoula ,Spatoula, Old_Depth ) :- 
   
   check_final_state(State),!.
   



idfs(State1, Visited_States , States , Old_Spatoula , Spatoula , Old_Depth ) :-
   

   Old_Depth > 0,
   New_Depth is Old_Depth-1,
   
   length(State1, N),															
   between(2,N,Temp_Spatoula),											
   move(State1, State2, Temp_Spatoula),										
   \+ member(State2, Visited_States),					 					
   append(Visited_States, [State2], New_Visited_States),					
   find_nth_element_of_list( Temp_Spatoula , Pita_Se_Thesi_N , State1 ),
   append(Old_Spatoula,[Pita_Se_Thesi_N],New_Spatoula),
	
   
   idfs(State2, New_Visited_States, States , New_Spatoula, Spatoula , New_Depth).
   


