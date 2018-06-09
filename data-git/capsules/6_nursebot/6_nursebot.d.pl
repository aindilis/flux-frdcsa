%% TYPES

%% ['flux_frdcsa'],['data-git/capsules/6_nursebot/6_nursebot.d.pl'],['data-git/capsules/6_nursebot/6_nursebot.p.pl'].

%% main,init(Z),findall(X,poss(X,Z),Xs),translatePlanFromCanonical(Xs,Xss).

genlsDirectlyList([object,key,room,player],canonical).


%% PREDICATES

formalDomainSpecification([
			   location(object,room),
			   opened(room,room),
			   here(room)
			  ]).
formalActionSpecification([
			   goto(room,room)
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

isOpened(Location,OtherSide) :-
    opened(Location, OtherSide).
isOpened(Location,OtherSide) :-
    holds(opened(OtherSide,Location),Z).


%% ACTIONS

poss(goto(R1,R2),Z) :-
	holds(here(R1),Z),
	nonvar(R1),
	isConnected(R1,R2),
	or_holds(opened(R1,R2),opened(R2,R1),Z).

state_update(Z1, goto(R1,R2), Z2, []) :-
	update(Z1, [here(R2)],
	       [here(R1)], Z2).
