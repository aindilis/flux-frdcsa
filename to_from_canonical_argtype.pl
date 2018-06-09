:- dynamic counter/1.
:- dynamic argType/1.

% argType(in_room/2, 1, canonical).
% argType(in_room/2, 2, canonical).
% argType(occupied/1, 1, canonical).
% argType(request/2, 1, canonical).
% argType(request/2, 2, canonical).
% argType(bring/2, 1, canonical).
% argType(bring/2, 2, canonical).
% argType(check_light/1, 1, canonical).
% argType(examination_room/2, 1, canonical).
% argType(examination_room/2, 2, canonical).

% argType(at/2,1,canonical).
% argType(at/2,2,integer).
% argType(request/2,1,canonical).
% argType(request/2,2,integer).
% argType(available/3,1,canonical).
% argType(available/3,2,canonical).
% argType(available/3,3,integer).

getCanonical(Item,CanonicalItem) :-
	toCanonical(Item,Tmp),Tmp = leaf(_,CanonicalItem).

myToCanonical(P,CanonicalP) :-
	var(P),
	CanonicalP = P.
myToCanonical(P,CanonicalP) :-
	nonvar(P),
	atom(P),
	getCanonical(P,CanonicalP).
myToCanonical(P,CanonicalP) :-
	nonvar(P),
	not(atom(P)),
	P =.. [Pred|List],
	length(List,Arity),
	assert(counter(0)),
	findall(CanonicalItem,
		(
		 member(Item,List),
		 retract(counter(X)),
		 Y is X + 1,
		 assert(counter(Y)),
		 argType(Pred/Arity,Y,Type),
		 (
		  (Type == canonical) ->
		  (nonvar(Item) -> getCanonical(Item,CanonicalItem) ; (CanonicalItem = Item)) ;
		  (Item = CanonicalItem)
		 )
		),
		CanonicalList),
	retract(counter(_)),
	CanonicalP =.. [Pred|CanonicalList].

myFromCanonical(P,CanonicalP) :-
	P =.. [Pred|List],
	findall(TranslatedItem,
		(
		 member(Item,List),
		 (nonvar(Item) -> (fromCanonical(leaf(1,Item),TranslatedItem)) ; TranslatedItem = Item)
		),TranslatedList),
	CanonicalP =.. [Pred|TranslatedList].

translateListFromCanonical(Plan,TranslatedPlan) :-
	translatePlanFromCanonical(Plan,TranslatedPlan).

translatePlanFromCanonical(Plan,TranslatedPlan) :-
	Plan = [Step|Rest],
	(functor(Step,if,3) ->
	 (
	  Step =.. [_|[Condition,PlanA,PlanB]],
	  myFromCanonical(Condition,TranslatedCondition),
	  translatePlanFromCanonical(PlanA,TranslatedPlanA),
	  translatePlanFromCanonical(PlanB,TranslatedPlanB),
	  TranslatedPlan =.. [if|[TranslatedCondition,TranslatedPlanA,TranslatedPlanB]]
	 ) ;
	 (
	  (Step \= [] -> (myFromCanonical(Step,TranslatedStep)) ; TranslatedStep = []),
	  (Rest \= [] -> (
			  translatePlanFromCanonical(Rest,TranslatedRest),
			  TranslatedPlan = [TranslatedStep|TranslatedRest]
			 ) ; TranslatedPlan = [TranslatedStep])
	 )).

translatePlanFromCanonical([],[]).


setFact(P) :-
	myToCanonical(P,CanonicalP),
	assertz(CanonicalP),
	see([P,CanonicalP]).
