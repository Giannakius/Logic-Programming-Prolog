%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Εργασια 5 Λογικου Προγραμματισμου %%
%% Τουρνης Ιωάννης ~ sdi2000192      %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- lib(ic).
:- lib(branch_and_bound).


% Ready Code From http://www.di.uoa.gr/~takis/randms.pl

create_formula(NVars, NClauses, Density, Formula) :-
   formula(NVars, 1, NClauses, Density, Formula).

formula(_, C, NClauses, _, []) :-
   C > NClauses.
formula(NVars, C, NClauses, Density, [Clause|Formula]) :-
   C =< NClauses,
   one_clause(1, NVars, Density, Clause),
   C1 is C + 1,
   formula(NVars, C1, NClauses, Density, Formula).

one_clause(V, NVars, _, []) :-
   V > NVars.
one_clause(V, NVars, Density, Clause) :-
   V =< NVars,
   rand(1, 100, Rand1),
   (Rand1 < Density ->
      (rand(1, 100, Rand2),
       (Rand2 < 50 ->
        Literal is V ;
        Literal is -V),
       Clause = [Literal|NewClause]) ;
      Clause = NewClause),
   V1 is V + 1,
   one_clause(V1, NVars, Density, NewClause).

rand(N1, N2, R) :-
   random(R1),
   R is R1 mod (N2 - N1 + 1) + N1.


% End of Ready Code


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

create_array(S, NV) :-
  length(S, NV),                          % Ορίζει το μήκος του πίνακα S ίσο με το NV.
  S #:: 0..1.                             % Ορίζει τα στοιχεία του πίνακα S ως δυαδικές μεταβλητές (0 ή 1).


find_max([], X) :- 
   X #= 0, !.                             % Αν η λίστα είναι κενή, τότε ο X ορίζεται ως 0.
find_max(L, X) :- 
   maxlist(L, X).                         % Επιστρέφει το μέγιστο στοιχείο από μια λίστα L και το αποθηκεύει στη μεταβλητή X.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sentence_analysis([],_,[]).               % Αν φτάσουμε στο τέλος του κλάσματος, επιστρέφουμε μια κενή λίστα αξιολογήσεων.

sentence_analysis([Start|End], S, [First|Rest]) :-
  Start > 0, abs(Start, Abs_Value),       % Ελέγχουμε εάν το πρώτο κλάσμα είναι ΘΕΤΙΚΟ.
  get_nth_element(Abs_Value, S, Value),   % Βρίσκουμε την τιμή της μεταβλητής στη θέση Abs_Value του πίνακα S και την αποθηκεύουμε στη μεταβλητή Value.
  First #:: 0..1, First #\= Value,        % Δημιουργούμε μια δυαδική μεταβλητή First και ορίζουμε ότι πρέπει να έχει διαφορετική τιμή από την τιμή της μεταβλητής Value.
  sentence_analysis(End, S, Rest).        % Επαναλαμβάνουμε αναδρομικά την ανάλυση για τα υπόλοιπα κλάσματα.



sentence_analysis([Start|End], S, [First|Rest]) :-
  Start < 0, abs(Start, Abs_Value),       % Ελέγχουμε εάν το πρώτο κλάσμα είναι ΑΡΝΗΤΙΚΟ.
  get_nth_element(Abs_Value, S, Value),   % Βρίσκουμε την τιμή της μεταβλητής στη θέση Abs_Value του πίνακα S και την αποθηκεύουμε στη μεταβλητή Value.
  First #:: 0..1, First #= Value,         % Δημιουργούμε μια δυαδική μεταβλητή First και ορίζουμε ότι πρέπει να έχει διαφορετική τιμή από την τιμή της μεταβλητής Value.
  sentence_analysis(End, S, Rest).        % Επαναλαμβάνουμε αναδρομικά την ανάλυση για τα υπόλοιπα κλάσματα.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Η Συναρτηση αυτη επιστρεφει το Ν-οστο ορο της λιστας.

get_nth_element(1, [X|_], X) :- !.                % Αν ο δείκτης είναι 1, τότε το X είναι το πρώτο στοιχείο της λίστας.

get_nth_element(Pointer, [_|List], X) :-          % Αν ο δείκτης είναι μεγαλύτερος από 1, αφαιρεί το πρώτο στοιχείο της λίστας και 
   Pointer > 1,                                   % επαναλαμβάνει αναδρομικά την αναζήτηση για τον νέο δείκτη ωσπου να φτασει 1.
   Pointer1 is Pointer-1, 
   get_nth_element(Pointer1, List, X).   

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

analysis_all_fractions([], _, []).                            % Αν φτάσουμε στο τέλος των κλασμάτων, επιστρέφουμε μια κενή λίστα κόστων.

analysis_all_fractions([Head|Tail], S, [Start|Cost_List]) :-
   sentence_analysis(Head, S, Temp),                          % Αξιολογούμε το κάθε κλάσμα HeadF με βάση τον πίνακα S και αποθηκεύουμε τη λίστα των αξιολογήσεων στο Temp.
   find_max(Temp, Start),                                     % Βρίσκουμε το μέγιστο στοιχείο στη λίστα των αξιολογήσεων και το αποθηκεύουμε στη μεταβλητή Start.
   analysis_all_fractions(Tail, S, Cost_List).                % Επαναλαμβάνουμε αναδρομικά την αξιολόγηση για τα υπόλοιπα κλάσματα.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



% Main :                                     % NV = των μεταβλητών του τύπου, NC = το πλήθος των προτάσεών

maxsat(NV, NC, D, F, S, M) :-                % D = η πυκνότητά λεξεων που περιέχονται σε μία πρόταση.
  create_formula(NV, NC, D, F),              % Eπιστρέφεται η ζητουμενη μορφη στην μεταβληγητη F
  create_array(S, NV),                       % Δημιουργεί έναν πίνακα S με μέγεθος NV, γεμίζοντάς τον με κενές μεταβλητές.
  analysis_all_fractions(F, S, Cost_List),   % Εκτελεί την αξιολόγηση όλων των κλασμάτων του F με βάση τον πίνακα S και αποθηκεύει τη λίστα των κόστων στο Cost_List.

  Sum_Cost #= -sum(Cost_List),               % Υπολογίζει το συνολικό κόστος Sum_Cost, το οποίο είναι η αρνητική άθροιση των κόστων στο Cost_List.
  M #= -Sum_Cost,                            % Ορίζει το M ως τον αρνητικό τιμή του Sum_Cost.
  bb_min(search(S, 0, input_order, indomain, complete, []), Sum_Cost, _).   % Εκτελεί την αναζήτηση με σκοπό την ελαχιστοποίηση του Sum_Cost χρησιμοποιώντας τον πίνακα S.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%