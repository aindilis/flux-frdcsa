%% %% hasNeedOf(Person,Item) :-
%% %% 	true.

%% %% createNewResource(Person,NewResource,Resources,Tools) :-%% 	true.

%% %% accessory functions




% poss(go_meet(P,X,T),Z) :-
% 	knows_val([P,X,T],available(P,X,T),Z),
% 	knows_val([X1,T1],at(X1,CanonicalT1),Z),
% 	myFromCanonical(T,CanonicalT1),
% 	( (X1 = X) -> (T1 =< T)
% 	;
% 	  (
% 	   availableTransport(P,X1,Mode),
% 	   travelTime(X1,X,by(Mode),minutes(D)), time_add(T1,D,T2), T2 =< T
% 	  )).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% poss(workProductively(Person,Time,Duration),Z) :-
% 	knows_val([X1,T1],at(X1,T1),Z),
% 	X1 \= X, T1 =< T.

% poss(work(Person),Z) :-
% 	knows_val([X1,T1],at(X1,T1),Z),
% 	X1 \= X, T1 =< T.

% 				% actions to take into consideration
% state_update(Z1, work(Person), Z2, []) :-
% 	knows_val([EnergyDrink,Qty],hasInventory(EnergyDrink,Qty),Z),
% 	isa(EnergyDrink,energyDrink),
% 	Qty => 1.

% poss(createMeal(Person,Meal,IngredientList), Z) :-
% 	member([Item,Qty1],IngredientList),
% 	%% FIXME doesn't address that they all have to exist and work
% 	knows_val([Person,Location],at(Person,Location),Z),
% 	knows_val([Location,Item,Qty2],hasInventory(Location,Item,Qty2),Z),
% 	Qty2 => Qty1.


% state_update(Z1, createMeal(Person,Meal,IngredientList), Z2, []) :-
% 	update(Z1, [], [], Z2).

% poss(eat(Person,Meal), Z) :-
% 	knows_val([Meal,Location],at(Meal,Location),Z),


% state_update(Z1, pullAllnighter(Person), Z2, []) :-
% 	update(Z1, [], [tired(Person)], Z2).

%% state_update(Z1, bring(R1,R2), Z2, []) :-
%%    holds(in_room(P,R1), Z1),
%%    holds(request(R1,X), Z1),
%%    update(Z1, [in_room(P,R2), occupied(R2)],
%% 	      [in_room(P,R1), occupied(R1), request(R1,X)], Z2).

%% state_update(Z, check_light(R), Z, [Light]) :-
%%    Light = true,  holds(occupied(R), Z) ;
%%    Light = false, not_holds(occupied(R), Z).

%% examination_room(1,1).
%% examination_room(1,2).
%% examination_room(2,3).
%% examination_room(2,4).
%% examination_room(3,5).
%% examination_room(3,6).

%% init(Z0) :- Z0 = [in_room(1,2),in_room(2,R),in_room(3,6),
%%                   request(2,3), request(6,2) | Z],
%%             R :: 3..5,
%% 	    not_holds_all(in_room(_,_), Z),
%% 	    not_holds_all(request(_,_), Z),
%% 	    consistent(Z0).

%% consistent(Z) :- room_occupied(Z), duplicate_free(Z).
				
%% main :- init(Z), request_plan(Z, S), writeln(S).

%% request_plan(Z, P) :- request_plan([], Z, P).

%% request_plan(S, Z, []) :- knows_not(request(_,_), S, Z).
%% request_plan(S, Z, P) :-
%%    knows_val([R1,X], request(R1,X), S, Z),
%%    examination_room(X, R2), knows_not(occupied(R2), S, Z),
%%    request_plan(do(bring(R1,R2),S), Z, P1),
%%    P=[bring(R1,R2)|P1].
%% request_plan(S, Z, P) :-
%%    knows_val([X], request(_,X), S, Z),
%%    examination_room(X, R),
%%    \+ knows(occupied(R), S, Z), \+ knows_not(occupied(R), S, Z),
%%    request_plan(do(if_true(occupied(R)),
%%                    do(check_light(R),S)), Z, P1),
%%    request_plan(do(if_false(occupied(R)),
%%                    do(check_light(R),S)), Z, P2),
%%    P=[check_light(R),if(occupied(R),P1,P2)].


	
% poss(go(X,T),Z) :-
% 	knows_val([X1,T1],at(X1,T1),Z),
% 	X1 \= X, T1 =< T.

% poss(meet(P,T),Z) :-
% 	knows_val([P,X,T],available(P,X,T),Z),
% 	knows_val([T1],at(X,T1),Z),
% 	T1 =< T.

% poss(go_meet(P,X,T),Z) :-
% 	knows_val([P,X,T],available(P,X,T),Z),
% 	knows_val([X1,T1],at(X1,T1),Z),
% 	( X1 = X -> T1 =< T
% 	;
% 	  distance(X1,X,D), time_add(T1,D,T2), T2 =< T ).

% poss(verifyInventoryLevel(Location,Item),Z) :-
% 	knows_val([Location,Item],usuallyStocks(Location,Item),Z),
% 	(
% 	 isa(Location,retailStore),
% 	 (
% 	  poss(verifyInventoryLevel(by(phone),Location,Item),Z) ;
% 	  poss(verifyInventoryLevel(by(internet),Location,Item),Z)
% 	 )
% 	;
% 	 isa(Location,regularLocation),
% 	 poss(verifyInventoryLevel(by(inspection),Location,Item),Z)
% 	)
% 	;
% 	poss(verifyLocationUsuallyStocks(Location,Item),Z),
% 	poss(verifyInventoryLevel(Location,Item),Z).

% %% Add ability to pick up item from in store pickup, as needed

% %% have it say that we are at the store, or we have internet access

% % purchase(Person,ShoppingList,Store,PaymentMethod) :-
% % 	hasAgent(Person,Agent),
% % 	knows(Agent,[Store,Item,Cost],carries(Store,Item,Cost),Z),
% % 	knows(Agent,[Person,PaymentMethod],authorizedToUse(Person,PaymentMethod),Z),
% % 	knows(Agent,[Store,PaymentMethod],acceptsPaymentMethod(Store,PaymentMethod),Z),
% % 	knows(Agent,[PaymentMethod,Funds],hasFundsAvailable(PaymentMethod,Funds),Z),
% % 	Funds > Cost,
% % 	knows(Agent,[Person,Agent],hasPurchaseAuthorization(Agent,Person,Item,Store,Cost),Z).

% %% state update axioms

% state_update(Z1,go(X,T),Z2,[]) :-
% 	holds(at(X1,T1),Z1),
% 	distance(X1,X,D),
% 	time_add(T,D,T2),
% 	update(Z1,[at(X,T2)],[at(X1,T1)],Z2).

% state_update(Z1,meet(P,T),Z2,[]) :-
% 	holds(request(P,D),Z1),
% 	holds(at(X,T1),Z1),
% 	time_add(T,D,T2),
% 	update(Z1,[at(X,T2)],[at(X,T1),request(P,D)],Z2).

% state_update(Z1,go_meet(P,X,T),Z2,[]) :-
% 	holds(request(P,D),Z1),
% 	holds(at(X1,T1),Z1),
% 	time_add(T,D,T2),
% 	update(Z1,[at(X,T2)],[at(X1,T1),request(P,D)],Z2).

