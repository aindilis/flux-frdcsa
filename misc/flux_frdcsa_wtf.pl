:- dynamic queue/2.

%%%%%%%%%%%%%%%%%%%%
%%% Libraries
%%%%%%%%%%%%%%%%%%%%

debuggingEnabled(false).

:- ['6_flux_canonical.pl'].

%%%%%%%%%%%%%%%%%%%%
%%% Initialization
%%%%%%%%%%%%%%%%%%%%

init(Z0) :-
	zInitImperfect(Z,Z0).
	%% consistent(Z0).

consistent(Z) :- duplicate_free(Z).


%%%%%%%%%%%%%%%%%%%%
%%% Main
%%%%%%%%%%%%%%%%%%%%

main :- setup,
	nl,nl,	
	init(Z),
	write_term(Z,[]),
	nl,nl,	
	findall(X,holds(X,Z),XYs1),
	write_list(XYs1),
	nl,
	findall(X,poss(X,Z),XYs2),
	write_list(XYs2),
	nl,nl,
	request_plan(P, here(60616850)),
	nl,nl,
	view([p,P]),
	translatePlanFromCanonical(P,TP),
	nl,nl,
	writeln([p,P]),
	%% do(goto(48368685518133,551826475005),S),
	writeln([p,P]),
	nl,nl,
	writeln([plan,TP]).

%%%%%%%%%%%%%%%%%%%%
%%% Plan Algorithm
%%%%%%%%%%%%%%%%%%%%

request_plan(P, G) :-
	request_plan_bfs(P, G).
	
request_plan_bfs(P, G) :-
	assertz(queue([],Z)),
	request_plan_bfs_helper(P, G).

request_plan_bfs_helper(P, G) :-
	queue(Branch,Z),
	retract(queue(Branch,Z)),
	%% writeln([branch,Branch,z,Z]),
	findall(Action,poss(Action,Z),Actions),
	writeln([actions,Actions]),
	member(X,Actions),
	writeln([xp,XP,branch,Branch]),
	append(Branch,[X],Branch2),
	res(do(X,[]), Z, Z2),
	(   
	    (	holds(here(Alpha),Z2), nonvar(Alpha), writeln([alpha,Alpha]), Alpha = 4175286374579736) ->
	    (	
		writeln([z2,Z2]),
		writeln([wtf]),
		writeln([x,X]),
		append(Branch,[X],P),
		writeln([plan,P])
	    ) ;   
	    (	
		writeln([omg]),
		writeln([branch2,Branch2]),
		assertz(queue(Branch2,Z2)),
		fail
	    )
	).
request_plan_bfs_helper(P, G) :-
	request_plan_bfs_helper(P, G).

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
