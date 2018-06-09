:- use_module('resource_manager_fluents.pl').
:- module(eclipse).
:- import fluents_for_resource_manager_fluents/1, pred_for_m/2 from resource_manager_fluents.

:- ['6_flux'].
:- ['serpro'].
:- ['to_from_canonical_argtype'].

time_diff(T1,T2,T) :-
	H1 is T1 // 100, M1 is T1 mod 100,
	H2 is T2 // 100, M2 is T2 mod 100,
	M is (H1-H2)*60 + M1-M2,
	T is (M//60)*100 + M mod 60.

time_add(T1,T2,T) :-
	H1 is T1 // 100, M1 is T1 mod 100,
	H2 is T2 // 100, M2 is T2 mod 100,
	H is H1+H2+(M1+M2)//60,
	T is H*100+(M1+M2) mod 60.

%% dist(1,2,15).
%% dist(1,3,20).
%% dist(2,3,5).

dist(466286768837,2506544301,15).
dist(466286768837,2578183597,20).
dist(2506544301,2578183597,5).


distance(X,Y,D) :- dist(X,Y,D) ; dist(Y,X,D).

poss(go(X,T),Z) :-
	knows_val([X1,T1],at(X1,T1),Z),
	X1 \= X, T1 =< T.

poss(meet(P,T),Z) :-
	knows_val([P,X,T],available(P,X,T),Z),
	knows_val([T1],at(X,T1),Z),
	T1 =< T.

poss(go_meet(P,X,T),Z) :-
	knows_val([P,X,T],available(P,X,T),Z),
	knows_val([X1,T1],at(X1,T1),Z),
	( X1 = X -> T1 =< T
	;
	  distance(X1,X,D), time_add(T1,D,T2), T2 =< T ).

state_update(Z1,go(X,T),Z2,[]) :-
	holds(at(X1,T1),Z1),
	distance(X1,X,D),
	time_add(T,D,T2),
	update(Z1,[at(X,T2)],[at(X1,T1)],Z2).

state_update(Z1,meet(P,T),Z2,[]) :-
	holds(request(P,D),Z1),
	holds(at(X,T1),Z1),
	time_add(T,D,T2),
	update(Z1,[at(X,T2)],[at(X,T1),request(P,D)],Z2).

state_update(Z1,go_meet(P,X,T),Z2,[]) :-
	holds(request(P,D),Z1),
	holds(at(X1,T1),Z1),
	time_add(T,D,T2),
	update(Z1,[at(X,T2)],[at(X1,T1),request(P,D)],Z2).

init(Z0) :-
	Zinit = [],
	fluents_for_resource_manager_fluents(PList),
	findall(CanonicalP,(member(P,PList),myToCanonical(P,CanonicalP)),CanonicalPList),
	append(CanonicalPList, Zinit, Z0).

main :- init(Z0), plan(schedule_plan, Z0, S),
	writeln(S).

schedule_plan(Z,[],Z) :- not_holds_all(request(_,_),Z).

schedule_plan(Z,[A|P],Zn) :-
	A = go_meet(_,_,_), poss(A,Z), state_update(Z,A,Z1,[]),
	schedule_plan(Z1,P,Zn).

plan_cost(schedule_plan, P, Z, C) :-
	knows_val([C1],at(_,C1),Z),
	toCanonical(office,Tmp),Tmp = leaf(_,CanonicalItem),
	travel_time(P,CanonicalItem,C2),
	C is C1+C2.

travel_time([],_,0).
travel_time([go_meet(_,X,_)|P],X1,C) :-
	( X1=X -> C1=0 ; distance(X1,X,C1) ),
	travel_time(P,X,C2),
	C is C1+C2.
