:- lib(fd).
:- lib(chr).
:- chr('4_fluent').

holds(F, [F|_]).
holds(F, Z) :- nonvar(Z), Z=[F1|Z1], F\==F1, holds(F, Z1).

holds(F, [F|Z], Z).
holds(F, Z, [F1|Zp]) :- nonvar(Z), Z=[F1|Z1], F\==F1, holds(F, Z1, Zp).

minus_(Z, [], Z).
minus_(Z, [F|Fs], Zp) :-
   ( \+ not_holds(F, Z) -> holds(F, Z, Z1) ;
     \+ holds(F, Z)     -> Z1 = Z
                         ; cancel(F, Z, Z1), not_holds(F, Z1) ),
   minus_(Z1, Fs, Zp).

plus_(Z, [], Z).
plus_(Z, [F|Fs], Zp) :-
   ( \+ holds(F, Z)     -> Z1=[F|Z] ;
     \+ not_holds(F, Z) -> Z1=Z
                         ; cancel(F, Z, Z2), not_holds(F, Z2), Z1=[F|Z2] ),
   plus_(Z1, Fs, Zp).

cancel(F,Z1,Z2) :-
   var(Z1)    -> cancel(F,Z1), cancelled(F,Z1), Z2=Z1 ;
   Z1 = [G|Z] -> ( F\=G -> cancel(F,Z,Z3), Z2=[G|Z3]
                         ; cancel(F,Z,Z2) ) ;
   Z1 = []    -> Z2 = [].

update(Z1, ThetaP, ThetaN, Z2) :-
   minus_(Z1, ThetaN, Z), plus_(Z, ThetaP, Z2).

knows(F, Z) :- \+ not_holds(F, Z).

knows_not(F, Z) :- \+ holds(F, Z).

knows_val(X, F, Z) :- k_holds(F, Z), knows_val(X).

k_holds(F, Z) :- nonvar(Z), Z=[F1|Z1],
                 ( instance(F1, F), F=F1 ; k_holds(F, Z1) ).

:- dynamic known_val/1.

knows_val(X) :- dom(X), ground(X), ambiguous(X) -> false.
knows_val(X) :- retract(known_val(X)).

dom([]).
dom([X|Xs]) :- dom(Xs), ( is_domain(X) -> indomain(X)
                                        ; true ).

ambiguous(X) :- retract(known_val(_)) -> true
                ;
                assert(known_val(X)), false.

knows(F, S, Z0) :- \+ ( res(S, Z0, Z), not_holds(F, Z) ).

knows_not(F, S, Z0) :- \+ ( res(S, Z0, Z), holds(F, Z) ).

knows_val(X, F, S, Z0) :-
   res(S, Z0, Z) -> findall(X, knows_val(X,F,Z), T),
                    assert(known_val(T)),
                    false.
knows_val(X, F, S, Z0) :-
   known_val(T), retract(known_val(T)), member(X, T),
   \+ ( res(S, Z0, Z), not_holds_all(F, Z) ).

res([], Z0, Z0).
res(do(A,S), Z0, Z) :-
   A = if_true(F)  -> res(S, Z0, Z), holds(F, Z) ;
   A = if_false(F) -> res(S, Z0, Z), not_holds(F, Z) ;
   res(S, Z0, Z1), state_update(Z1, A, Z, _).

execute(A,Z1,Z2) :-
   perform(A,Y)    -> state_update(Z1,A,Z2,Y) ;
   A = [A1|A2]     -> execute(A1,Z1,Z), execute(A2,Z,Z2) ;
   A = if(F,A1,A2) -> (holds(F,Z1) -> execute(A1,Z1,Z2)
                                    ; execute(A2,Z1,Z2)) ;
   A = []          -> Z1=Z2 ;
   complex_action(A,Z1,Z2).

:- dynamic plan_search_best/2.

plan(Problem, Z, P) :-
   assert(plan_search_best(_,-1)),
   plan_search(Problem, Z),
   retract(plan_search_best(P,C)),
   C =\= -1.

plan_search(Problem, Z) :-
   is_predicate(Problem/2) ->
      ( PlanningProblem =.. [Problem,Z,P],
        call(PlanningProblem),
        plan_cost(Problem, P, C),
        plan_search_best(_,C1),
        ( C1 =< C, C1 =\= -1 -> fail
                              ; retract(plan_search_best(_,C1)),
                                assert(plan_search_best(P,C)), fail )
        ;
        true ) ;
   PlanningProblem =.. [Problem,Z,P,Zn],
   call(PlanningProblem),
   plan_cost(Problem, P, Zn, C),
   plan_search_best(_,C1),
   ( C1 =< C, C1 =\= -1 -> fail
                         ; retract(plan_search_best(_,C1)),
                           assert(plan_search_best(P,C)), fail )
   ;
   true.
