%----------------------------------------------------------------------------------------------------------------------------------------------
% Ergasia 2 Logikos Programmatismos ~ Tournis Ioannis ~ sdi2000192
%----------------------------------------------------------------------------------------------------------------------------------------------

%activity(a01, act(0,3)).
%activity(a02, act(0,4)).
%activity(a03, act(1,5)).
%activity(a04, act(4,6)).
%activity(a05, act(6,8)).
%activity(a06, act(6,9)).			% Uncomment To Test , Η εκφωνηση ελεγε να μην υπαρχουν μεσα.
%activity(a07, act(9,10)).
%activity(a08, act(9,13)).
%activity(a09, act(11,14)).
%activity(a10, act(12,15)).
%activity(a11, act(14,17)).
%activity(a12, act(16,18)).
%activity(a13, act(17,19)).
%activity(a14, act(18,20)).
%activity(a15, act(19,20)).

%----------------------------------------------------------------------------------------------------------------------------------------------

take_first([A|_],A).					% Παιρνει το Πρωτο στοιχειο της λιστας Α

%----------------------------------------------------------------------------------------------------------------------------------------------
between(Start, End, X) :- 				% Δινει ολους τους αριθμους απο τον αριθμο
   Start =< End, 						% Start εως τον End , ανεβαινοντας κατα +1 αριθμο 
   X = Start.
between(Start, End, X) :- 
   Start < End,
   New_start is Start+1, 
   between(New_start, End, X).
%----------------------------------------------------------------------------------------------------------------------------------------------


find_sum( [] , Sum , Sum).				%Βρισκει το αθροισμα των χρονων Β-Α του πινακα με τους χρονους του καθε PId

find_sum([A-B|Array], Old_Sum , Sum) :-
	New_Sum is (Old_Sum + (B-A) ) ,
	find_sum(Array, New_Sum , Sum).

%----------------------------------------------------------------------------------------------------------------------------------------------


convert_ASP(0,ASA,ASP,ASP).							% Μετατρεπει τον πινακα που εχω βρει με τα αποτελεσματα ASA σε ASP μορφη

convert_ASP(Temp_person , ASA ,Old_ASP , ASP)  :-
	
	Temp_person >= 1 ,														% Οσο υπαρχουν ατομα
	findall(X,(member(X - Temp_person , ASA)) , Temp_person_activities), 	% Βρες μου απο τον πινακα ASA ολα τα activities που κανει το συγκεκριμενο ατομο Temp_person και βαλε μου τις στη λιστα Temp_person_activities


	findall(A-B, (member(X,Temp_person_activities) , activity(X, act(A, B)) ), Pid_Times),	% Βρες μου τους χρονους για ολα τα activities που εχει κανει ο Pid και βαλτους σε μια λιστα
	find_sum(Pid_Times, 0 , Sum_Times) , 			% Παρε αυτην την λιστα και υπολογισε το αθροισμα ολων των χρονων

	append(Old_ASP, [Temp_person-Temp_person_activities-Sum_Times] , New_ASP),	% Προσθεσε ολα τα ζητουμενα στοιχεια σε μια λιστα με την μορφη που ζηταει η εκφωνηση
	

	New_Temp_Person is (Temp_person-1),				% Πηγαινε στον επομενο ανθρωπο
	convert_ASP(New_Temp_Person , ASA ,New_ASP, ASP).


%----------------------------------------------------------------------------------------------------------------------------------------------



assignment(NP, MT, ASP, ASA) :-    				
	findall(X,activity(X,_),AIds), 		% Gather all activities in list AIds , pairnei ola ta X apo ta aktivities kai ta bazei se lista xwris ta act
	assign(AIds, NP, MT , ASA),
	
	convert_ASP(NP , ASA ,[], ASP) .

%----------------------------------------------------------------------------------------------------------------------------------------------


assign([], _, _ , []).


assign([AId|AIds], NPersons, MT , [AId-PId|ASA]) :-
	assign(AIds, NPersons, MT , ASA),
	
	findall( P , ( between(1,NPersons,P) , \+member(_-P,ASA) ) , R ),		%βρισκει ολα τα PID τα οποια δεν ειναι σε καποιο προηγουμενο Assignment (1-εως Ν(3))
    findall( P1 , ( between(1,NPersons,P1), \+member(P1,R)) , U ) , 					% ελεγχει το απο πανω , παιρνει οσα εχουν ανατεθει στο Assignment.

	(member(PId,U); take_first(R,PId) ),		% Select a person PId for activity AId

	activity(AId, act(Ab, Ae)),			% Παιρνει τα Ab , Ae απο το AId


	findall(X, member((X-PId) , ASA) ,APIds), % Gather in list APIds so far activities of PId

	Hours_New_Activity is (Ae-Ab),				% Ξεκιναει απο τον χρονο που θελουμε να ελεγξουμε αν χωραει σε καποιο ανθρωπο και επειτα του προσθετει οσα εχει κανει ηδη για να δει αν ειναι μικροτερος απο το ΜΤ
	valid(Ab, Ae, MT , Hours_New_Activity , APIds). 	% Is current assignment consistent with previous ones?
	
%----------------------------------------------------------------------------------------------------------------------------------------------


valid(_, _, _ , _ , []).

valid(Arxi, Telos, MT , Temp_Sum , [APId|APIds]) :-	%APId = Poia diergasia eimaste twra , APIds = Lista me tis diergasies pou apomenoyn na elegxthoyn

	activity(APId, act(TempArxi, TempTelos) ),
	
	New_Temp_Sum is (Temp_Sum + (TempTelos - TempArxi) ),
    Temp is (Telos+1),											% Elegxos gia ikanoipoihsh periorismwn ekfwnisis

	TempArxi >= Temp ,
	New_Temp_Sum =< MT ,
	
	valid(Arxi, Telos, MT ,New_Temp_Sum , APIds).
