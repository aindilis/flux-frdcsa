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
	knows_val([R1],here(R1),Z),
	knows_val([R1],opened(R1,R2),Z),
	isConnected(R1,R2).

poss(take(Thing),Z) :-
	knows_val([Place],here(Place),Z),
	is_contained_in(Thing,Place,Z),
	nonvar(Thing).
	

%% is_contained_in(Thing,Place,Z).

state_update(Z1, goto(R1,R2), Z2, []) :-
	update(Z1, [here(R2)],
	       [here(R1)], Z2).

state_update(Z1, take(Thing), Z2, []) :-
	update(Z1, [have(Thing)],
	       [location(Thing,_)], Z2).
