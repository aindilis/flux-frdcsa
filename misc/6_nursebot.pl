:- ['6_flux'].

:- chr('6_nursebot_constraints').

state_update(Z1, bring(R1,R2), Z2, []) :-
   holds(in_room(P,R1), Z1),
   holds(request(R1,X), Z1),
   update(Z1, [in_room(P,R2), occupied(R2)],
	      [in_room(P,R1), occupied(R1), request(R1,X)], Z2).

state_update(Z, check_light(R), Z, [Light]) :-
   Light = true,  holds(occupied(R), Z) ;
   Light = false, not_holds(occupied(R), Z).

examination_room(1,1).
examination_room(1,2).
examination_room(2,3).
examination_room(2,4).
examination_room(3,5).
examination_room(3,6).

init(Z0) :- Z0 = [in_room(1,2),in_room(2,R),in_room(3,6),
                  request(2,3), request(6,2) | Z],
            R :: 3..5,
	    not_holds_all(in_room(_,_), Z),
	    not_holds_all(request(_,_), Z),
	    consistent(Z0).

consistent(Z) :- room_occupied(Z), duplicate_free(Z).

main :- init(Z), request_plan(Z, S), writeln(S).

request_plan(Z, P) :- request_plan([], Z, P).

request_plan(S, Z, []) :- knows_not(request(_,_), S, Z).
request_plan(S, Z, P) :-
   knows_val([R1,X], request(R1,X), S, Z),
   examination_room(X, R2), knows_not(occupied(R2), S, Z),
   request_plan(do(bring(R1,R2),S), Z, P1),
   P=[bring(R1,R2)|P1].
request_plan(S, Z, P) :-
   knows_val([X], request(_,X), S, Z),
   examination_room(X, R),
   \+ knows(occupied(R), S, Z), \+ knows_not(occupied(R), S, Z),
   request_plan(do(if_true(occupied(R)),
                   do(check_light(R),S)), Z, P1),
   request_plan(do(if_false(occupied(R)),
                   do(check_light(R),S)), Z, P2),
   P=[check_light(R),if(occupied(R),P1,P2)].
