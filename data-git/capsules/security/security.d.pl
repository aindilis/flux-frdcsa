%% TYPES

%% ['flux_frdcsa'],['data-git/capsules/6_nursebot/6_nursebot.d.pl'],['data-git/capsules/6_nursebot/6_nursebot.p.pl'].

%% main,init(Z),findall(X,poss(X,Z),Xs),translatePlanFromCanonical(Xs,Xss).

genlsDirectlyList([object,key,room,player],canonical).


%% PREDICATES

formalDomainSpecification([
			   location(object,room),
			   opened(room,room),
			   locked(room,room),
			   here(room),
			   have(object)
			  ]).
formalActionSpecification([
			   goto(room,room),
			   take(object),
			   open_door(door)
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

isOpened(Location,OtherSide,Z) :-
	knows_val([Location,OtherSide],opened(Location, OtherSide),Z).
isOpened(Location,OtherSide,Z) :-
	knows_val([OtherSide,Location],opened(OtherSide, Location),Z).

isClosed(Location,OtherSide,Z) :-
	not(isOpened(Location,OtherSide,Z)).

isLocked(Location,OtherSide,Z) :-
	knows_val([Location,OtherSide],locked(Location, OtherSide),Z).

isUnlocked(Location,OtherSide,Z) :-
	not(isLocked(Location,OtherSide,Z)).


is_contained_in(T1,T2,Z) :-
	holds(location(T1,T2),Z).
is_contained_in(T1,T2,Z) :-
	knows_val([X,T2],location(X,T2),Z),
	is_contained_in(T1,X,Z).



%% ACTIONS


%%  Precondition Axioms

poss(goto(R1,R2),Z) :-
	knows_val([R1],here(R1),Z),
	isOpened(R1,R2,Z),
	isConnected(R1,R2).

poss(take(Thing),Z) :-
	knows_val([Place],here(Place),Z),
	is_contained_in(Thing,Place,Z),
	nonvar(Thing).
	
poss(open_door(Location,OtherSide),Z) :-
	knows_val([Location],here(Location),Z),
	isConnected(Location,OtherSide),
	isClosed(Location,OtherSide,Z),
	isUnlocked(Location,OtherSide,Z).

poss(unlock_door(Location,OtherSide),Z) :-
	knows_val([Location],here(Location),Z),
	isConnected(Location,OtherSide),
	isClosed(Location,OtherSide,Z),
	isLocked(Location,OtherSide,Z),
	keyForDoor(Key,Location,OtherSide),
	knows_val([Key],have(Key),Z).

poss(lock_door(Location,OtherSide),Z) :-
	knows_val([Location],here(Location),Z),
	isConnected(Location,OtherSide),
	isClosed(Location,OtherSide,Z),
	isUnlocked(Location,OtherSide,Z),
	keyForDoor(Key,Location,OtherSide),
	knows_val([Key],have(Key),Z).


%%  State Update Axioms

state_update(Z1, goto(R1,R2), Z2, []) :-
	update(Z1, [here(R2)],
	       [here(R1)], Z2).

state_update(Z1, take(Thing), Z2, []) :-
	update(Z1, [have(Thing)],
	       [location(Thing,_)], Z2).

state_update(Z1, open_door(Location,OtherSide), Z2, []) :-
	update(Z1, [opened(Location,OtherSide)],
	       [], Z2).

state_update(Z1, unlock_door(Location,OtherSide), Z2, []) :-
	update(Z1, [],
	       [locked(Location,OtherSide)], Z2).

state_update(Z1, lock_door(Location,OtherSide), Z2, []) :-
	update(Z1, [locked(Location,OtherSide)],
	       [], Z2).
