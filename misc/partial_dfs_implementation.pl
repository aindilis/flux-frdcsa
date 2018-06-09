%% request_plan(Z, P, G) :- request_plan([], Z, P, G).
%% request_plan(S, Z, [], G) :- not(poss(X,Z)).
%% request_plan(S, Z, P, G) :-
%% 	findall(Action,poss(Action,Z),Actions),
%% 	member(X,Actions),
%% 	writeln([x,X,s,S]),
%% 	res(do(X,[]), Z, Z2),
%% 	findall(here(Tmp),holds(here(Tmp),Z),Tmps),
%% 	view([tmps,Tmps]),
%% 	(   
%% 	    (	holds(here(Alpha),Z2), nonvar(Alpha), writeln([alpha,Alpha]), Alpha = 59897774) ->
%% 	    (	
%% 		writeln([z2,Z2]),
%% 		writeln([wtf]),
%% 		writeln([x,X]),
%% 		append(S,[X],P),
%% 		writeln([plan,P])
%% 	    ) ;   
%% 	    (	
%% 		writeln([omg]),
%% 		append(S,[X],S2),
%% 		view([s2,S2]),
%% 		request_plan(S2,Z2,P,G))
%% 	),
%% 	writeln([finit]).

%% request_plan(S, Z, P, G) :-
%% 	findall(Plan,
%% 		(   
%% 		    poss(X,Z),
%% 		    nl,
%% 		    writeln([x,X,s,S]),
%% 		    res(do(X,[]), Z, Z2),
%% 		    findall(here(Tmp),holds(here(Tmp),Z),Tmps),
%% 		    view([tmps,Tmps]),
%% 		    (	
%% 			(   holds(here(Alpha),Z2), nonvar(Alpha), writeln([alpha,Alpha]), Alpha = 60616850) ->
%% 			(   
%% 			    writeln([z2,Z2]),
%% 			    writeln([wtf]),
%% 			    writeln([x,X]),
%% 			    append(S,[X],Plan),
%% 			    writeln([plan,Plan])
%% 			) ;   
%% 			(   
%% 			    writeln([omg]),
%% 			    append(S,[X],S2),
%% 			    view([s2,S2]),
%% 			    request_plan(S2,Z2,Plan,G))
%% 		    )
%% 		),
%% 		[P|_]),
%% 	writeln([p,P]).

%% request_plan(S, Z, P) :-
%% 	findall(X,poss(X,Z),Xs),
%% 	writeln([xs,Xs]),
%% 	findall(Y,(poss(X,Z),res(do(X,S), Z, Z2), holds(here(Y),Z2), nonvar(Y)),Ys),
%% 	writeln([ys,Ys]).
