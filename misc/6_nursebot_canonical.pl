%%%%%%%%%%%%%%%%%%%%
%%% Libraries
%%%%%%%%%%%%%%%%%%%%

debuggingEnabled(false).

:- ['6_flux_canonical'].

%%%%%%%%%%%%%%%%%%%%
%%% Initialization
%%%%%%%%%%%%%%%%%%%%

init(Z0) :-
	zInitImperfect(Z,Z0),

	getCanonical(room3,X3),
	getCanonical(room4,X4),
	getCanonical(room5,X5),
	R #= X3 #\/ X4 #\/ X5,
	squelch(R),

	not_holds_all(in_room(_,_), Z),
	not_holds_all(request(_,_), Z),

	consistent(Z0).

consistent(Z) :- room_occupied(Z), duplicate_free(Z).


%%%%%%%%%%%%%%%%%%%%
%%% Main
%%%%%%%%%%%%%%%%%%%%

main :- setup, init(Z), request_plan(Z, S), translatePlanFromCanonical(S,TS), nl, writeln([plan,TS]).


%%%%%%%%%%%%%%%%%%%%
%%% Plan Algorithm
%%%%%%%%%%%%%%%%%%%%

request_plan(Z, P) :- request_plan([], Z, P).

request_plan(S, Z, []) :- knows_not(request(_,_), S, Z).
request_plan(S, Z, P) :-
	knows_val([R1,X], request(R1,X), S, Z),
	examination_room(X, R2), knows_not(occupied(R2), S, Z),
	request_plan(do(bring(R1,R2),S), Z, P1),
	P=[bring(R1,R2)|P1].
request_plan(S, Z, P) :-
	knows_val([X], request(_,X), S, Z),
	examination_room(X, R),
	\+ knows(occupied(R), S, Z), \+ knows_not(occupied(R), S, Z),
	request_plan(do(if_true(occupied(R)),
			do(check_light(R),S)), Z, P1),
	request_plan(do(if_false(occupied(R)),
			do(check_light(R),S)), Z, P2),
	P=[check_light(R),if(occupied(R),P1,P2)].
