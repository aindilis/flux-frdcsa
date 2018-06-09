myToCanonical(P,CanonicalP) :-
	P =.. [Pred|List],
	findall(CanonicalItem,
		(
		 member(Item,List),
		 (nonvar(Item) -> (toCanonical(Item,Tmp),Tmp = leaf(X,CanonicalItem)) ; CanonicalItem = Item)
		), CanonicalList),
	CanonicalP =.. [Pred|CanonicalList].

myFromCanonical(P,CanonicalP) :-
	P =.. [Pred|List],
	findall(TranslatedItem,
		(
		 member(Item,List),
		 (nonvar(Item) -> (fromCanonical(leaf(1,Item),TranslatedItem)) ; CanonicalItem = Item)
		),TranslatedList),
	CanonicalP =.. [Pred|TranslatedList].

translateListFromCanonical(Plan,TranslatedPlan) :-
	translatePlanFromCanonical(Plan,TranslatedPlan).

translatePlanFromCanonical(Plan,TranslatedPlan) :-
	Plan = [Step|Rest],
	(functor(Step,if,3) ->
	 (
	  Step =.. [Pred|[Condition,PlanA,PlanB]],
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


setFact(P) :-
	myToCanonical(P,CanonicalP),
	assertz(CanonicalP),
	see([P,CanonicalP]).
