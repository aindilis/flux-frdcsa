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

	nl,write_term(Z,[]),nl,

	problemGoals(ProblemGoals),

	assertz(queue([],Z)),
	request_plan(P2,ProblemGoals),
	squelch([Plan]).

check_goals(Goals,Z) :-
	findall(Goal,
		(
		 member(Goal,Goals),
		 myToCanonical(Goal,GoalCanonical),
		 knows(GoalCanonical,Z)
		),
		SatisfiedGoals),
	length(SatisfiedGoals,Length),
	length(Goals,Length).

%%%%%%%%%%%%%%%%%%%%
%%% Plan Algorithm
%%%%%%%%%%%%%%%%%%%%

request_plan(Plan, Goals) :-
	squelch([Goals]),
	request_plan_bfs(Plan, Goals),!.

request_plan_bfs(Plan, Goals) :-
	squelch([Goals]),
	queue(Branch,Z),
	retract(queue(Branch,Z)),

	nlIf,nlIf,
	writelnIf('Trying queued branch: '),
	translateAndPrintIf(branch,Branch),nlIf,

	findall(Action,poss(Action,Z),Actions),

	nlIf,nlIf,translateAndPrintIf(actions,Actions),

	member(X,Actions),

	nlIf,translateAndPrintIf(action,[X]),

	append(Branch,[X],Branch2),
	%% add_tail(Branch,X,Branch2),

	translateAndPrintIf(branch2,Branch2),
	res(do(X,[]), Z, Z2),
	(   
	    check_goals(Goals,Z2) ->
	    (	
		nl,nl,nl,
		writeln('--------------------------------------------'),
		nl,writeln('Plan found!'),nl,
		translateAndPrint('Final state:',Z2),
		nl,translateAndPrint(action,[X]),nl,
		
		append(Branch,[X],Plan),
		%% add_tail(Branch,X,Plan),

		translateAndPrint('Found plan:',Plan)
	    ) ;   
	    (	
		assertz(queue(Branch2,Z2)),
		fail
	    )
	).
request_plan_bfs(Plan, Goals) :-
	squelch([Goals]),
	request_plan_bfs(Plan, Goals).

translateAndPrintIf(_,_) :- true.
nlIf :- true.
writelnIf(_) :- true.

%% translateAndPrintIf(A,B) :- translateAndPrint(A,B).
%% nlIf :- nl.
%% writelnIf(A) :- writeln(A).


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


%% %% add_tail(+List,+Element,-List)
%% %% Add the given element to the end of the list, without using the "append" predicate.
%% add_tail([],X,[X]).

%% add_tail([H|T],X,[H|L]) :-
%% 	add_tail(T,X,L).

