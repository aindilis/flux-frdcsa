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
	squelch([Z]),
	zInitImperfect(Z,Z0).
	%% consistent(Z0).

consistent(Z) :- duplicate_free(Z).

%%%%%%%%%%%%%%%%%%%%
%%% Main
%%%%%%%%%%%%%%%%%%%%

main :- setup,
	nl,nl,	
	init(Z),
	%% write_term(Z,[]),
	assertz(queue([],Z)),
	request_plan(P, here(60616850)),
	squelch([P]).

%%%%%%%%%%%%%%%%%%%%
%%% Plan Algorithm
%%%%%%%%%%%%%%%%%%%%

request_plan(P, G) :-
	squelch([G]),
	request_plan_bfs(P, G),!.

request_plan_bfs(P, G) :-
	squelch([G]),
	queue(Branch,Z),
	nl,nl,
	writeln('Trying queued branch: '),
	translateAndPrint(branch,Branch),
	nl,
	retract(queue(Branch,Z)),
	findall(Action,poss(Action,Z),Actions),
	nl,nl,
	translateAndPrint(actions,Actions),
	member(X,Actions),
	nl,
	translateAndPrint(action,[X]),
	append(Branch,[X],Branch2),
	translateAndPrint(branch2,Branch2),
	res(do(X,[]), Z, Z2),
	(   
	    (	holds(have(Alpha),Z2), nonvar(Alpha), Alpha = 58297720) ->
	    %% (	holds(here(Alpha),Z2), nonvar(Alpha), Alpha = 60616850) ->
	    (	
		nl,nl,nl,
		writeln('--------------------------------------------'),
		nl,
		writeln('Plan found!'),
		nl,
		translateAndPrint('Final state:',Z2),
		nl,
		translateAndPrint(action,[X]),
		nl,
		append(Branch,[X],P),
		translateAndPrint('Found plan:',P)
	    ) ;   
	    (	
		assertz(queue(Branch2,Z2)),
		fail
	    )
	).
request_plan_bfs(P, G) :-
	squelch([G]),
	request_plan_bfs(P, G).

translateAndPrint(A,B) :-
	write('['),
	write(A),
	write(', ['),
	translateListFromCanonical(B,BP),
	member(X,BP),
	write_term(X,[quoted(true)]),
	write(', '),
	fail.
translateAndPrint(_,_) :-
	write(']]'),
	nl.


%% view(Item) :-
%% 	write_term(Item,[quoted(true)]),nl,!.
