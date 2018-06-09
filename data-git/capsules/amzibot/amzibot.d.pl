%% TYPES

%% ['flux_frdcsa'],['data-git/capsules/6_nursebot/6_nursebot.d.pl'],['data-git/capsules/6_nursebot/6_nursebot.p.pl'].

%% main,init(Z),findall(X,poss(X,Z),Xs),translatePlanFromCanonical(Xs,Xss).

genlsDirectlyList([object,key,room,player],canonical).


%% PREDICATES

formalDomainSpecification([
			   location(object,room),
			   opened(room,room),
			   here(room),
			   have(object)
			  ]).
formalActionSpecification([
			   goto(room,room),
			   take(object)
			  ]).
extraFormalSpecification([
			  room(room),
			  door(room,room),
			  keyForDoor(key,room,room),
			  edible(object),
			  tastesYucky(object)
			 ]).

specification(X) :-
	(   problemInit(List) ;
	    formalDomainSpecification(List) ;
	    formalActionSpecification(List) ;
	    extraFormalSpecification(List)), member(X,List).


%% DERIVED PREDICATES

isConnected(X,Y) :- door(X,Y).
isConnected(X,Y) :- door(Y,X).

%% isOpened(Location,OtherSide,Z) :-
%% 	holds(opened(Location, OtherSide),Z),
%% 	nonvar(OtherSide),
%% 	nonvar(Location),!.
%% isOpened(Location,OtherSide,Z) :-
%%  	nonvar(OtherSide),
%% 	nonvar(Location),
%% 	holds(opened(Location,OtherSide),Z),!.

is_contained_in(T1,T2,Z) :-
	holds(location(T1,T2),Z).
is_contained_in(T1,T2,Z) :-
	holds(location(X,T2),Z),
	nonvar(X),
	is_contained_in(T1,X,Z).


%% ACTIONS

poss(goto(R1,R2),Z) :-
	holds(here(R1),Z),
	nonvar(R1),
	holds(opened(R1,R2),Z),
	nonvar(R2),
	isConnected(R1,R2),
	nonvar(R2).
	%% translateAndPrint(r1,[item(R1)]),
	%% translateAndPrint(r2,[item(R2)]),
	%% findall(opened(X,Y),(holds(opened(X,Y),Z),nonvar(X),nonvar(Y)),All),
	%% translateAndPrint(all,All),

	%% translateAndPrint(z,Z),
	%% writeln([ha]).

poss(take(Thing),Z) :-
	holds(here(Place),Z),
	nonvar(Place),
	%% holds(location(Thing,Place),Z),
	is_contained_in(Thing,Place,Z),
	nonvar(Thing).
	

%% is_contained_in(Thing,Place,Z).

state_update(Z1, goto(R1,R2), Z2, []) :-
	update(Z1, [here(R2)],
	       [here(R1)], Z2).

state_update(Z1, take(Thing), Z2, []) :-
	update(Z1, [have(Thing)],
	       [location(Thing,_)], Z2).
