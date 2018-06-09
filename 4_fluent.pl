
%%% The following code has been produced by the CHR compiler


:- ( current_module(chr) -> true ; use_module(library(chr)) ).

:- get_flag(variable_names, Val), setval(variable_names_flag, Val), set_flag(variable_names, off).
:- lib(fd).
neq(_231020, _231023) :- or_neq(exists, _231020, _231023).
neq_all(_231052, _231055) :- or_neq(forall, _231052, _231055).
or_neq(_231084, _231087, _231090) :- functor(_231087, _231102, _231105), functor(_231090, _231117, _231120), (_231102 = _231117, _231105 = _231120 -> _231087 =.. [_231143|_231145], _231090 =.. [_231152|_231154], or_neq(_231084, _231145, _231154, _231166), call(_231166) ; true).
or_neq(_231598, [], [], 0 #\= 0).
or_neq(_231681, [_231686|_231687], [_231692|_231693], _231696) :- or_neq(_231681, _231687, _231693, _231713), (_231681 = forall, var(_231686), \+ is_domain(_231686) -> (binding(_231686, _231687, _231693, _231752) -> _231696 = #\/(_231692 #\= _231752, _231713) ; _231696 = _231713) ; _231696 = #\/(_231686 #\= _231692, _231713)).
binding(_232259, [_232264|_232265], [_232270|_232271], _232274) :- _232259 == _232264 -> _232274 = _232270 ; binding(_232259, _232265, _232271, _232274).
and_eq([], [], 0 #= 0).
and_eq([_232405|_232406], [_232411|_232412], _232415) :- and_eq(_232406, _232412, _232429), _232415 = #/\(_232405 #= _232411, _232429).
or_and_eq([], 0 #\= 0).
or_and_eq([eq(_232711, _232714)|_232718], #\/(_232721, _232725)) :- and_eq(_232711, _232714, _232721), or_and_eq(_232718, _232725).
inst(_232919, _232922) :- \+ (term_variables(_232919, _232935), term_variables(_232922, _232946), bound_free(_232946, _232935, _232959, _232962), copy_term_vars(_232962, _232922, _232977), \+ no_global_bindings(_232919 = _232977, _232959)).
bound_free([], _233275, _233275, []).
bound_free([_233299|_233300], _233303, _233306, _233309) :- bound_free(_233300, _233303, _233324, _233327), (is_domain(_233299) -> _233306 = [_233299|_233324], _233309 = _233327 ; _233306 = _233324, _233309 = [_233299|_233327]).
member(_233691, [_233691|_233696], _233696).
member(_233715, [_233720|_233721], [_233720|_233726]) :- member(_233715, _233721, _233726).
not_holds(A, B) :-
	'CHRgen_num'(C),
	coca(add_one_constraint(C, not_holds(A, B))),
	'CHRnot_holds_2'(not_holds(A, B), D, E, C).



%%% Rules handling for not_holds / 2

'CHRnot_holds_2'(not_holds(A, B), C, D, E) :-
	(
	    'CHRnonvar'(C)
	;
	    'CHRalready_in'('CHRnot_holds_2'(not_holds(A, B), C, D, E)),
	    coca(already_in)
	),
	!.
'CHRnot_holds_2'(not_holds(A, [B|C]), D, E, F) ?-
	coca(try_rule(F, not_holds(A, [B|C]), anonymous("0"), not_holds(G, [H|I]), replacement, true, (neq(G, H), not_holds(G, I)))),
	!,
	'CHRkill'(D),
	coca(fired_rule(anonymous("0"))),
	neq(A, B),
	not_holds(A, C).
'CHRnot_holds_2'(not_holds(A, []), B, C, D) ?-
	coca(try_rule(D, not_holds(A, []), anonymous("1"), not_holds(E, []), replacement, true, true)),
	!,
	'CHRkill'(B),
	coca(fired_rule(anonymous("1"))).
'CHRnot_holds_2'(not_holds(A, B), C, D, E) ?-
	'CHRget_delayed_goals'(B, F),
	'CHRnot_holds_2__23'(F, [B], [G], H),
	coca(try_double(E, not_holds(A, B), H, not_holds_all(G, B), not_holds(I, J), not_holds_all(K, J), keep_second, inst(I, K), true, anonymous("4"))),
	no_delayed_goals(inst(A, G)),
	!,
	'CHRkill'(C),
	coca(fired_rule(anonymous("4"))).
'CHRnot_holds_2'(not_holds(A, B), C, D, E) ?-
	'CHRget_delayed_goals'(B, F),
	'CHRnot_holds_2__24'(F, [B], [G], H),
	coca(try_double(E, not_holds(A, B), H, cancel(G, B), not_holds(I, J), cancel(K, J), keep_second, \+ K \= I, true, anonymous("18"))),
	no_delayed_goals(\+ G \= A),
	!,
	'CHRkill'(C),
	coca(fired_rule(anonymous("18"))).
'CHRnot_holds_2'(not_holds(A, B), C, D, E) :-
	'CHRnot_holds_2__22'(not_holds(A, B), C, D, E).
'CHRnot_holds_2__23'(['CHRnot_holds_all_2'(not_holds_all(A, B), C, D, E)|F], [B], [G], H) ?-
	'CHRvar'(C),
	'CHR='([A], [G]),
	'CHR='(E, H).
'CHRnot_holds_2__23'([A|B], C, D, E) :-
	'CHRnot_holds_2__23'(B, C, D, E).
:- set_flag('CHRnot_holds_2__23' / 4, leash, notrace).
'CHRnot_holds_2__24'(['CHRcancel_2'(cancel(A, B), C, D, E)|F], [B], [G], H) ?-
	'CHRvar'(C),
	'CHR='([A], [G]),
	'CHR='(E, H).
'CHRnot_holds_2__24'([A|B], C, D, E) :-
	'CHRnot_holds_2__24'(B, C, D, E).
:- set_flag('CHRnot_holds_2__24' / 4, leash, notrace).
:- set_flag('CHRnot_holds_2' / 4, leash, notrace).
:- current_macro('CHRnot_holds_2' / 4, _247918, _247919, _247920) -> true ; define_macro('CHRnot_holds_2' / 4, tr_chr / 2, [write]).
'CHRnot_holds_2__22'(A, B, C, D) :-
	'CHRnot_holds_2__25'(A, B, C, D).
:- set_flag('CHRnot_holds_2__22' / 4, leash, notrace).
'CHRnot_holds_2__25'(not_holds(A, B), C, D, E) ?-
	'CHRvar'(C),
	!,
	'CHRget_delayed_goals'(B, F),
	'CHRnot_holds_2__25__26'(F, C, not_holds(A, B), D, E).
'CHRnot_holds_2__25'(not_holds(A, B), C, D, E) :-
	'CHRnot_holds_2__25__27'(not_holds(A, B), C, D, E).
:- set_flag('CHRnot_holds_2__25' / 4, leash, notrace).
'CHRnot_holds_2__25__26'(['CHRor_holds_2'(or_holds(A, B), C, D, E)|F], G, not_holds(H, B), I, J) ?-
	'CHRvar'(C),
	coca(try_double(J, not_holds(H, B), E, or_holds(A, B), not_holds(K, L), or_holds(M, L), keep_first, (member(N, M, O), K == N), or_holds(O, L), anonymous("13"))),
	no_delayed_goals((member(P, A, Q), H == P)),
	!,
	'CHRkill'(C),
	coca(fired_rule(anonymous("13"))),
	'CHRnot_holds_2__25__26'(F, G, not_holds(H, B), I, J),
	or_holds(Q, B).
'CHRnot_holds_2__25__26'([A|B], C, D, E, F) :-
	'CHRnot_holds_2__25__26'(B, C, D, E, F).
'CHRnot_holds_2__25__26'([], A, B, C, D) :-
	'CHRnot_holds_2__25__27'(B, A, C, D).
:- set_flag('CHRnot_holds_2__25__26' / 5, leash, notrace).
'CHRnot_holds_2__25__27'(not_holds(A, B), C, D, E) :-
	(
	    'CHRvar'(C)
	->
	    'CHRdelay'([C, not_holds(A, B)], 'CHRnot_holds_2'(not_holds(A, B), C, D, E))
	;
	    true
	).
:- set_flag('CHRnot_holds_2__25__27' / 4, leash, notrace).
not_holds_all(A, B) :-
	'CHRgen_num'(C),
	coca(add_one_constraint(C, not_holds_all(A, B))),
	'CHRnot_holds_all_2'(not_holds_all(A, B), D, E, C).



%%% Rules handling for not_holds_all / 2

'CHRnot_holds_all_2'(not_holds_all(A, B), C, D, E) :-
	(
	    'CHRnonvar'(C)
	;
	    'CHRalready_in'('CHRnot_holds_all_2'(not_holds_all(A, B), C, D, E)),
	    coca(already_in)
	),
	!.
'CHRnot_holds_all_2'(not_holds_all(A, [B|C]), D, E, F) ?-
	coca(try_rule(F, not_holds_all(A, [B|C]), anonymous("2"), not_holds_all(G, [H|I]), replacement, true, (neq_all(G, H), not_holds_all(G, I)))),
	!,
	'CHRkill'(D),
	coca(fired_rule(anonymous("2"))),
	neq_all(A, B),
	not_holds_all(A, C).
'CHRnot_holds_all_2'(not_holds_all(A, []), B, C, D) ?-
	coca(try_rule(D, not_holds_all(A, []), anonymous("3"), not_holds_all(E, []), replacement, true, true)),
	!,
	'CHRkill'(B),
	coca(fired_rule(anonymous("3"))).
'CHRnot_holds_all_2'(not_holds_all(A, B), C, D, E) ?-
	'CHRget_delayed_goals'(B, F),
	'CHRnot_holds_all_2__29'(F, [B], [G], H),
	coca(try_double(E, not_holds_all(A, B), H, not_holds_all(G, B), not_holds_all(I, J), not_holds_all(K, J), keep_second, inst(I, K), true, anonymous("5"))),
	no_delayed_goals(inst(A, G)),
	!,
	'CHRkill'(C),
	coca(fired_rule(anonymous("5"))).
'CHRnot_holds_all_2'(not_holds_all(A, B), C, D, E) ?-
	'CHRget_delayed_goals'(B, F),
	'CHRnot_holds_all_2__30'(F, [B], [G], H),
	coca(try_double(E, not_holds_all(A, B), H, cancel(G, B), not_holds_all(I, J), cancel(K, J), keep_second, \+ K \= I, true, anonymous("19"))),
	no_delayed_goals(\+ G \= A),
	!,
	'CHRkill'(C),
	coca(fired_rule(anonymous("19"))).
'CHRnot_holds_all_2'(not_holds_all(A, B), C, D, E) :-
	'CHRnot_holds_all_2__28'(not_holds_all(A, B), C, D, E).
'CHRnot_holds_all_2__29'(['CHRnot_holds_all_2'(not_holds_all(A, B), C, D, E)|F], [B], [G], H) ?-
	'CHRvar'(C),
	'CHR='([A], [G]),
	'CHR='(E, H).
'CHRnot_holds_all_2__29'([A|B], C, D, E) :-
	'CHRnot_holds_all_2__29'(B, C, D, E).
:- set_flag('CHRnot_holds_all_2__29' / 4, leash, notrace).
'CHRnot_holds_all_2__30'(['CHRcancel_2'(cancel(A, B), C, D, E)|F], [B], [G], H) ?-
	'CHRvar'(C),
	'CHR='([A], [G]),
	'CHR='(E, H).
'CHRnot_holds_all_2__30'([A|B], C, D, E) :-
	'CHRnot_holds_all_2__30'(B, C, D, E).
:- set_flag('CHRnot_holds_all_2__30' / 4, leash, notrace).
:- set_flag('CHRnot_holds_all_2' / 4, leash, notrace).
:- current_macro('CHRnot_holds_all_2' / 4, _250142, _250143, _250144) -> true ; define_macro('CHRnot_holds_all_2' / 4, tr_chr / 2, [write]).
'CHRnot_holds_all_2__28'(A, B, C, D) :-
	'CHRnot_holds_all_2__31'(A, B, C, D).
:- set_flag('CHRnot_holds_all_2__28' / 4, leash, notrace).
'CHRnot_holds_all_2__31'(not_holds_all(A, B), C, D, E) ?-
	'CHRvar'(C),
	!,
	'CHRget_delayed_goals'(B, F),
	'CHRnot_holds_all_2__31__32'(F, C, not_holds_all(A, B), D, E).
'CHRnot_holds_all_2__31'(not_holds_all(A, B), C, D, E) :-
	'CHRnot_holds_all_2__31__33'(not_holds_all(A, B), C, D, E).
:- set_flag('CHRnot_holds_all_2__31' / 4, leash, notrace).
'CHRnot_holds_all_2__31__32'(['CHRnot_holds_2'(not_holds(A, B), C, D, E)|F], G, not_holds_all(H, B), I, J) ?-
	'CHRvar'(C),
	coca(try_double(J, not_holds_all(H, B), E, not_holds(A, B), not_holds_all(K, L), not_holds(M, L), keep_first, inst(M, K), true, anonymous("4"))),
	no_delayed_goals(inst(A, H)),
	!,
	'CHRkill'(C),
	coca(fired_rule(anonymous("4"))),
	'CHRnot_holds_all_2__31__32'(F, G, not_holds_all(H, B), I, J).
'CHRnot_holds_all_2__31__32'([A|B], C, D, E, F) :-
	'CHRnot_holds_all_2__31__32'(B, C, D, E, F).
'CHRnot_holds_all_2__31__32'([], A, B, C, D) :-
	'CHRnot_holds_all_2__31__33'(B, A, C, D).
:- set_flag('CHRnot_holds_all_2__31__32' / 5, leash, notrace).
'CHRnot_holds_all_2__31__33'(not_holds_all(A, B), C, D, E) ?-
	'CHRvar'(C),
	!,
	'CHRget_delayed_goals'(B, F),
	'CHRnot_holds_all_2__31__33__34'(F, C, not_holds_all(A, B), D, E).
'CHRnot_holds_all_2__31__33'(not_holds_all(A, B), C, D, E) :-
	'CHRnot_holds_all_2__31__33__35'(not_holds_all(A, B), C, D, E).
:- set_flag('CHRnot_holds_all_2__31__33' / 4, leash, notrace).
'CHRnot_holds_all_2__31__33__34'(['CHRnot_holds_all_2'(not_holds_all(A, B), C, D, E)|F], G, not_holds_all(H, B), I, J) ?-
	'CHRvar'(C),
	coca(try_double(J, not_holds_all(H, B), E, not_holds_all(A, B), not_holds_all(K, L), not_holds_all(M, L), keep_first, inst(M, K), true, anonymous("5"))),
	no_delayed_goals(inst(A, H)),
	!,
	'CHRkill'(C),
	coca(fired_rule(anonymous("5"))),
	'CHRnot_holds_all_2__31__33__34'(F, G, not_holds_all(H, B), I, J).
'CHRnot_holds_all_2__31__33__34'([A|B], C, D, E, F) :-
	'CHRnot_holds_all_2__31__33__34'(B, C, D, E, F).
'CHRnot_holds_all_2__31__33__34'([], A, B, C, D) :-
	'CHRnot_holds_all_2__31__33__35'(B, A, C, D).
:- set_flag('CHRnot_holds_all_2__31__33__34' / 5, leash, notrace).
'CHRnot_holds_all_2__31__33__35'(not_holds_all(A, B), C, D, E) ?-
	'CHRvar'(C),
	!,
	'CHRget_delayed_goals'(B, F),
	'CHRnot_holds_all_2__31__33__35__36'(F, C, not_holds_all(A, B), D, E).
'CHRnot_holds_all_2__31__33__35'(not_holds_all(A, B), C, D, E) :-
	'CHRnot_holds_all_2__31__33__35__37'(not_holds_all(A, B), C, D, E).
:- set_flag('CHRnot_holds_all_2__31__33__35' / 4, leash, notrace).
'CHRnot_holds_all_2__31__33__35__36'(['CHRor_holds_2'(or_holds(A, B), C, D, E)|F], G, not_holds_all(H, B), I, J) ?-
	'CHRvar'(C),
	coca(try_double(J, not_holds_all(H, B), E, or_holds(A, B), not_holds_all(K, L), or_holds(M, L), keep_first, (member(N, M, O), inst(N, K)), or_holds(O, L), anonymous("14"))),
	no_delayed_goals((member(P, A, Q), inst(P, H))),
	!,
	'CHRkill'(C),
	coca(fired_rule(anonymous("14"))),
	'CHRnot_holds_all_2__31__33__35__36'(F, G, not_holds_all(H, B), I, J),
	or_holds(Q, B).
'CHRnot_holds_all_2__31__33__35__36'([A|B], C, D, E, F) :-
	'CHRnot_holds_all_2__31__33__35__36'(B, C, D, E, F).
'CHRnot_holds_all_2__31__33__35__36'([], A, B, C, D) :-
	'CHRnot_holds_all_2__31__33__35__37'(B, A, C, D).
:- set_flag('CHRnot_holds_all_2__31__33__35__36' / 5, leash, notrace).
'CHRnot_holds_all_2__31__33__35__37'(not_holds_all(A, B), C, D, E) :-
	(
	    'CHRvar'(C)
	->
	    'CHRdelay'([C, not_holds_all(A, B)], 'CHRnot_holds_all_2'(not_holds_all(A, B), C, D, E))
	;
	    true
	).
:- set_flag('CHRnot_holds_all_2__31__33__35__37' / 4, leash, notrace).
duplicate_free(A) :-
	'CHRgen_num'(B),
	coca(add_one_constraint(B, duplicate_free(A))),
	'CHRduplicate_free_1'(duplicate_free(A), C, D, B).



%%% Rules handling for duplicate_free / 1

'CHRduplicate_free_1'(duplicate_free(A), B, C, D) :-
	(
	    'CHRnonvar'(B)
	;
	    'CHRalready_in'('CHRduplicate_free_1'(duplicate_free(A), B, C, D)),
	    coca(already_in)
	),
	!.
'CHRduplicate_free_1'(duplicate_free([A|B]), C, D, E) ?-
	coca(try_rule(E, duplicate_free([A|B]), anonymous("6"), duplicate_free([F|G]), replacement, true, (not_holds(F, G), duplicate_free(G)))),
	!,
	'CHRkill'(C),
	coca(fired_rule(anonymous("6"))),
	not_holds(A, B),
	duplicate_free(B).
'CHRduplicate_free_1'(duplicate_free([]), A, B, C) ?-
	coca(try_rule(C, duplicate_free([]), anonymous("7"), duplicate_free([]), replacement, true, true)),
	!,
	'CHRkill'(A),
	coca(fired_rule(anonymous("7"))).
'CHRduplicate_free_1'(duplicate_free(A), B, C, D) :-
	'CHRduplicate_free_1__38'(duplicate_free(A), B, C, D).
:- set_flag('CHRduplicate_free_1' / 4, leash, notrace).
:- current_macro('CHRduplicate_free_1' / 4, _252566, _252567, _252568) -> true ; define_macro('CHRduplicate_free_1' / 4, tr_chr / 2, [write]).
'CHRduplicate_free_1__38'(A, B, C, D) :-
	'CHRduplicate_free_1__39'(A, B, C, D).
:- set_flag('CHRduplicate_free_1__38' / 4, leash, notrace).
'CHRduplicate_free_1__39'(duplicate_free(A), B, C, D) :-
	(
	    'CHRvar'(B)
	->
	    'CHRdelay'([B, duplicate_free(A)], 'CHRduplicate_free_1'(duplicate_free(A), B, C, D))
	;
	    true
	).
:- set_flag('CHRduplicate_free_1__39' / 4, leash, notrace).
or_holds(A, B) :-
	'CHRgen_num'(C),
	coca(add_one_constraint(C, or_holds(A, B))),
	'CHRor_holds_2'(or_holds(A, B), D, E, C).



%%% Rules handling for or_holds / 2

'CHRor_holds_2'(or_holds(A, B), C, D, E) :-
	(
	    'CHRnonvar'(C)
	;
	    'CHRalready_in'('CHRor_holds_2'(or_holds(A, B), C, D, E)),
	    coca(already_in)
	),
	!.
'CHRor_holds_2'(or_holds([A], B), C, D, E) ?-
	coca(try_rule(E, or_holds([A], B), anonymous("8"), or_holds([F], G), replacement, F \= eq(H, I), holds(F, G))),
	no_delayed_goals(A \= eq(J, K)),
	!,
	'CHRkill'(C),
	coca(fired_rule(anonymous("8"))),
	holds(A, B).
'CHRor_holds_2'(or_holds(A, B), C, D, E) ?-
	coca(try_rule(E, or_holds(A, B), anonymous("9"), or_holds(F, G), replacement, \+ (member(H, F), H \= eq(I, J)), (or_and_eq(F, K), call(K)))),
	no_delayed_goals(\+ (member(L, A), L \= eq(M, N))),
	!,
	'CHRkill'(C),
	coca(fired_rule(anonymous("9"))),
	or_and_eq(A, O),
	call(O).
'CHRor_holds_2'(or_holds(A, []), B, C, D) ?-
	coca(try_rule(D, or_holds(A, []), anonymous("10"), or_holds(E, []), replacement, (member(F, E, G), F \= eq(H, I)), or_holds(G, []))),
	no_delayed_goals((member(J, A, K), J \= eq(L, M))),
	!,
	'CHRkill'(B),
	coca(fired_rule(anonymous("10"))),
	or_holds(K, []).
'CHRor_holds_2'(or_holds(A, B), C, D, E) ?-
	coca(try_rule(E, or_holds(A, B), anonymous("11"), or_holds(F, G), replacement, (member(eq(H, I), F), or_neq(exists, H, I, J), \+ call(J)), true)),
	no_delayed_goals((member(eq(K, L), A), or_neq(exists, K, L, M), \+ call(M))),
	!,
	'CHRkill'(C),
	coca(fired_rule(anonymous("11"))).
'CHRor_holds_2'(or_holds(A, B), C, D, E) ?-
	coca(try_rule(E, or_holds(A, B), anonymous("12"), or_holds(F, G), replacement, (member(eq(H, I), F, J), \+ (and_eq(H, I, K), call(K))), or_holds(J, G))),
	no_delayed_goals((member(eq(L, M), A, N), \+ (and_eq(L, M, O), call(O)))),
	!,
	'CHRkill'(C),
	coca(fired_rule(anonymous("12"))),
	or_holds(N, B).
'CHRor_holds_2'(or_holds(A, [B|C]), D, E, F) ?-
	coca(try_rule(F, or_holds(A, [B|C]), anonymous("15"), or_holds(G, [H|I]), replacement, true, or_holds(G, [], [H|I]))),
	!,
	'CHRkill'(D),
	coca(fired_rule(anonymous("15"))),
	or_holds(A, [], [B|C]).
'CHRor_holds_2'(or_holds(A, B), C, D, E) ?-
	'CHRget_delayed_goals'(B, F),
	'CHRor_holds_2__41'(F, [B], [G], H),
	coca(try_double(E, or_holds(A, B), H, not_holds(G, B), or_holds(I, J), not_holds(K, J), keep_second, (member(L, I, M), K == L), or_holds(M, J), anonymous("13"))),
	no_delayed_goals((member(N, A, O), G == N)),
	!,
	'CHRkill'(C),
	coca(fired_rule(anonymous("13"))),
	or_holds(O, B).
'CHRor_holds_2'(or_holds(A, B), C, D, E) ?-
	'CHRget_delayed_goals'(B, F),
	'CHRor_holds_2__42'(F, [B], [G], H),
	coca(try_double(E, or_holds(A, B), H, not_holds_all(G, B), or_holds(I, J), not_holds_all(K, J), keep_second, (member(L, I, M), inst(L, K)), or_holds(M, J), anonymous("14"))),
	no_delayed_goals((member(N, A, O), inst(N, G))),
	!,
	'CHRkill'(C),
	coca(fired_rule(anonymous("14"))),
	or_holds(O, B).
'CHRor_holds_2'(or_holds(A, B), C, D, E) ?-
	'CHRget_delayed_goals'(B, F),
	'CHRor_holds_2__43'(F, [B], [G], H),
	coca(try_double(E, or_holds(A, B), H, cancel(G, B), or_holds(I, J), cancel(K, J), keep_second, (member(L, I), \+ K \= L), true, anonymous("20"))),
	no_delayed_goals((member(M, A), \+ G \= M)),
	!,
	'CHRkill'(C),
	coca(fired_rule(anonymous("20"))).
'CHRor_holds_2'(or_holds(A, B), C, D, E) :-
	'CHRor_holds_2__40'(or_holds(A, B), C, D, E).
'CHRor_holds_2__41'(['CHRnot_holds_2'(not_holds(A, B), C, D, E)|F], [B], [G], H) ?-
	'CHRvar'(C),
	'CHR='([A], [G]),
	'CHR='(E, H).
'CHRor_holds_2__41'([A|B], C, D, E) :-
	'CHRor_holds_2__41'(B, C, D, E).
:- set_flag('CHRor_holds_2__41' / 4, leash, notrace).
'CHRor_holds_2__42'(['CHRnot_holds_all_2'(not_holds_all(A, B), C, D, E)|F], [B], [G], H) ?-
	'CHRvar'(C),
	'CHR='([A], [G]),
	'CHR='(E, H).
'CHRor_holds_2__42'([A|B], C, D, E) :-
	'CHRor_holds_2__42'(B, C, D, E).
:- set_flag('CHRor_holds_2__42' / 4, leash, notrace).
'CHRor_holds_2__43'(['CHRcancel_2'(cancel(A, B), C, D, E)|F], [B], [G], H) ?-
	'CHRvar'(C),
	'CHR='([A], [G]),
	'CHR='(E, H).
'CHRor_holds_2__43'([A|B], C, D, E) :-
	'CHRor_holds_2__43'(B, C, D, E).
:- set_flag('CHRor_holds_2__43' / 4, leash, notrace).
:- set_flag('CHRor_holds_2' / 4, leash, notrace).
:- current_macro('CHRor_holds_2' / 4, _255498, _255499, _255500) -> true ; define_macro('CHRor_holds_2' / 4, tr_chr / 2, [write]).
'CHRor_holds_2__40'(A, B, C, D) :-
	'CHRor_holds_2__44'(A, B, C, D).
:- set_flag('CHRor_holds_2__40' / 4, leash, notrace).
'CHRor_holds_2__44'(or_holds(A, B), C, D, E) :-
	(
	    'CHRvar'(C)
	->
	    'CHRdelay'([C, or_holds(A, B)], 'CHRor_holds_2'(or_holds(A, B), C, D, E))
	;
	    true
	).
:- set_flag('CHRor_holds_2__44' / 4, leash, notrace).
or_holds(A, B, C) :-
	'CHRgen_num'(D),
	coca(add_one_constraint(D, or_holds(A, B, C))),
	'CHRor_holds_3'(or_holds(A, B, C), E, F, D).



%%% Rules handling for or_holds / 3

'CHRor_holds_3'(or_holds(A, B, C), D, E, F) :-
	(
	    'CHRnonvar'(D)
	;
	    'CHRalready_in'('CHRor_holds_3'(or_holds(A, B, C), D, E, F)),
	    coca(already_in)
	),
	!.
'CHRor_holds_3'(or_holds([A|B], C, [D|E]), F, G, H) ?-
	coca(try_rule(H, or_holds([A|B], C, [D|E]), anonymous("16"), or_holds([I|J], K, [L|M]), replacement, true, I == L -> true ; I \= L -> or_holds(J, [I|K], [L|M]) ; (I =.. [N|O], L =.. [P|Q], or_holds(J, [eq(O, Q), I|K], [L|M])))),
	!,
	'CHRkill'(F),
	coca(fired_rule(anonymous("16"))),
	(
	    A == D
	->
	    true
	;
	    (
		A \= D
	    ->
		or_holds(B, [A|C], [D|E])
	    ;
		A =.. [R|S],
		D =.. [T|U],
		or_holds(B, [eq(S, U), A|C], [D|E])
	    )
	).
'CHRor_holds_3'(or_holds([], A, [B|C]), D, E, F) ?-
	coca(try_rule(F, or_holds([], A, [B|C]), anonymous("17"), or_holds([], G, [H|I]), replacement, true, or_holds(G, I))),
	!,
	'CHRkill'(D),
	coca(fired_rule(anonymous("17"))),
	or_holds(A, C).
'CHRor_holds_3'(or_holds(A, B, C), D, E, F) :-
	'CHRor_holds_3__45'(or_holds(A, B, C), D, E, F).
:- set_flag('CHRor_holds_3' / 4, leash, notrace).
:- current_macro('CHRor_holds_3' / 4, _256439, _256440, _256441) -> true ; define_macro('CHRor_holds_3' / 4, tr_chr / 2, [write]).
'CHRor_holds_3__45'(A, B, C, D) :-
	'CHRor_holds_3__46'(A, B, C, D).
:- set_flag('CHRor_holds_3__45' / 4, leash, notrace).
'CHRor_holds_3__46'(or_holds(A, B, C), D, E, F) :-
	(
	    'CHRvar'(D)
	->
	    'CHRdelay'([D, or_holds(A, B, C)], 'CHRor_holds_3'(or_holds(A, B, C), D, E, F))
	;
	    true
	).
:- set_flag('CHRor_holds_3__46' / 4, leash, notrace).
cancel(A, B) :-
	'CHRgen_num'(C),
	coca(add_one_constraint(C, cancel(A, B))),
	'CHRcancel_2'(cancel(A, B), D, E, C).



%%% Rules handling for cancel / 2

'CHRcancel_2'(cancel(A, B), C, D, E) :-
	(
	    'CHRnonvar'(C)
	;
	    'CHRalready_in'('CHRcancel_2'(cancel(A, B), C, D, E)),
	    coca(already_in)
	),
	!.
'CHRcancel_2'(cancel(A, B), C, D, E) ?-
	'CHRget_delayed_goals'(B, F),
	'CHRcancel_2__48'(F, [B, A], [], G),
	coca(try_double(E, cancel(A, B), G, cancelled(A, B), cancel(H, I), cancelled(H, I), replacement, true, true, anonymous("21"))),
	!,
	'CHRkill'(C),
	coca(fired_rule(anonymous("21"))).
'CHRcancel_2'(cancel(A, B), C, D, E) :-
	'CHRcancel_2__47'(cancel(A, B), C, D, E).
'CHRcancel_2__48'(['CHRcancelled_2'(cancelled(A, B), C, D, E)|F], [B, A], [], G) ?-
	'CHRvar'(C),
	'CHRkill'(C),
	'CHR='([], []),
	'CHR='(E, G).
'CHRcancel_2__48'([A|B], C, D, E) :-
	'CHRcancel_2__48'(B, C, D, E).
:- set_flag('CHRcancel_2__48' / 4, leash, notrace).
:- set_flag('CHRcancel_2' / 4, leash, notrace).
:- current_macro('CHRcancel_2' / 4, _257369, _257370, _257371) -> true ; define_macro('CHRcancel_2' / 4, tr_chr / 2, [write]).
'CHRcancel_2__47'(A, B, C, D) :-
	'CHRcancel_2__49'(A, B, C, D).
:- set_flag('CHRcancel_2__47' / 4, leash, notrace).
'CHRcancel_2__49'(cancel(A, B), C, D, E) ?-
	'CHRvar'(C),
	!,
	'CHRget_delayed_goals'(B, F),
	'CHRcancel_2__49__50'(F, C, cancel(A, B), D, E).
'CHRcancel_2__49'(cancel(A, B), C, D, E) :-
	'CHRcancel_2__49__51'(cancel(A, B), C, D, E).
:- set_flag('CHRcancel_2__49' / 4, leash, notrace).
'CHRcancel_2__49__50'(['CHRnot_holds_2'(not_holds(A, B), C, D, E)|F], G, cancel(H, B), I, J) ?-
	'CHRvar'(C),
	coca(try_double(J, cancel(H, B), E, not_holds(A, B), cancel(K, L), not_holds(M, L), keep_first, \+ K \= M, true, anonymous("18"))),
	no_delayed_goals(\+ H \= A),
	!,
	'CHRkill'(C),
	coca(fired_rule(anonymous("18"))),
	'CHRcancel_2__49__50'(F, G, cancel(H, B), I, J).
'CHRcancel_2__49__50'([A|B], C, D, E, F) :-
	'CHRcancel_2__49__50'(B, C, D, E, F).
'CHRcancel_2__49__50'([], A, B, C, D) :-
	'CHRcancel_2__49__51'(B, A, C, D).
:- set_flag('CHRcancel_2__49__50' / 5, leash, notrace).
'CHRcancel_2__49__51'(cancel(A, B), C, D, E) ?-
	'CHRvar'(C),
	!,
	'CHRget_delayed_goals'(B, F),
	'CHRcancel_2__49__51__52'(F, C, cancel(A, B), D, E).
'CHRcancel_2__49__51'(cancel(A, B), C, D, E) :-
	'CHRcancel_2__49__51__53'(cancel(A, B), C, D, E).
:- set_flag('CHRcancel_2__49__51' / 4, leash, notrace).
'CHRcancel_2__49__51__52'(['CHRnot_holds_all_2'(not_holds_all(A, B), C, D, E)|F], G, cancel(H, B), I, J) ?-
	'CHRvar'(C),
	coca(try_double(J, cancel(H, B), E, not_holds_all(A, B), cancel(K, L), not_holds_all(M, L), keep_first, \+ K \= M, true, anonymous("19"))),
	no_delayed_goals(\+ H \= A),
	!,
	'CHRkill'(C),
	coca(fired_rule(anonymous("19"))),
	'CHRcancel_2__49__51__52'(F, G, cancel(H, B), I, J).
'CHRcancel_2__49__51__52'([A|B], C, D, E, F) :-
	'CHRcancel_2__49__51__52'(B, C, D, E, F).
'CHRcancel_2__49__51__52'([], A, B, C, D) :-
	'CHRcancel_2__49__51__53'(B, A, C, D).
:- set_flag('CHRcancel_2__49__51__52' / 5, leash, notrace).
'CHRcancel_2__49__51__53'(cancel(A, B), C, D, E) ?-
	'CHRvar'(C),
	!,
	'CHRget_delayed_goals'(B, F),
	'CHRcancel_2__49__51__53__54'(F, C, cancel(A, B), D, E).
'CHRcancel_2__49__51__53'(cancel(A, B), C, D, E) :-
	'CHRcancel_2__49__51__53__55'(cancel(A, B), C, D, E).
:- set_flag('CHRcancel_2__49__51__53' / 4, leash, notrace).
'CHRcancel_2__49__51__53__54'(['CHRor_holds_2'(or_holds(A, B), C, D, E)|F], G, cancel(H, B), I, J) ?-
	'CHRvar'(C),
	coca(try_double(J, cancel(H, B), E, or_holds(A, B), cancel(K, L), or_holds(M, L), keep_first, (member(N, M), \+ K \= N), true, anonymous("20"))),
	no_delayed_goals((member(O, A), \+ H \= O)),
	!,
	'CHRkill'(C),
	coca(fired_rule(anonymous("20"))),
	'CHRcancel_2__49__51__53__54'(F, G, cancel(H, B), I, J).
'CHRcancel_2__49__51__53__54'([A|B], C, D, E, F) :-
	'CHRcancel_2__49__51__53__54'(B, C, D, E, F).
'CHRcancel_2__49__51__53__54'([], A, B, C, D) :-
	'CHRcancel_2__49__51__53__55'(B, A, C, D).
:- set_flag('CHRcancel_2__49__51__53__54' / 5, leash, notrace).
'CHRcancel_2__49__51__53__55'(cancel(A, B), C, D, E) :-
	(
	    'CHRvar'(C)
	->
	    'CHRdelay'([C, cancel(A, B)], 'CHRcancel_2'(cancel(A, B), C, D, E))
	;
	    true
	).
:- set_flag('CHRcancel_2__49__51__53__55' / 4, leash, notrace).
cancelled(A, B) :-
	'CHRgen_num'(C),
	coca(add_one_constraint(C, cancelled(A, B))),
	'CHRcancelled_2'(cancelled(A, B), D, E, C).



%%% Rules handling for cancelled / 2

'CHRcancelled_2'(cancelled(A, B), C, D, E) :-
	(
	    'CHRnonvar'(C)
	;
	    'CHRalready_in'('CHRcancelled_2'(cancelled(A, B), C, D, E)),
	    coca(already_in)
	),
	!.
'CHRcancelled_2'(cancelled(A, B), C, D, E) ?-
	'CHRget_delayed_goals'(B, F),
	'CHRcancelled_2__57'(F, [B, A], [], G),
	coca(try_double(E, cancelled(A, B), G, cancel(A, B), cancelled(H, I), cancel(H, I), replacement, true, true, anonymous("21"))),
	!,
	'CHRkill'(C),
	coca(fired_rule(anonymous("21"))).
'CHRcancelled_2'(cancelled(A, B), C, D, E) :-
	'CHRcancelled_2__56'(cancelled(A, B), C, D, E).
'CHRcancelled_2__57'(['CHRcancel_2'(cancel(A, B), C, D, E)|F], [B, A], [], G) ?-
	'CHRvar'(C),
	'CHRkill'(C),
	'CHR='([], []),
	'CHR='(E, G).
'CHRcancelled_2__57'([A|B], C, D, E) :-
	'CHRcancelled_2__57'(B, C, D, E).
:- set_flag('CHRcancelled_2__57' / 4, leash, notrace).
:- set_flag('CHRcancelled_2' / 4, leash, notrace).
:- current_macro('CHRcancelled_2' / 4, _259923, _259924, _259925) -> true ; define_macro('CHRcancelled_2' / 4, tr_chr / 2, [write]).
'CHRcancelled_2__56'(A, B, C, D) :-
	'CHRcancelled_2__58'(A, B, C, D).
:- set_flag('CHRcancelled_2__56' / 4, leash, notrace).
'CHRcancelled_2__58'(cancelled(A, B), C, D, E) :-
	(
	    'CHRvar'(C)
	->
	    'CHRdelay'([C, cancelled(A, B)], 'CHRcancelled_2'(cancelled(A, B), C, D, E))
	;
	    true
	).
:- set_flag('CHRcancelled_2__58' / 4, leash, notrace).

:- getval(variable_names_flag, Val), set_flag(variable_names, Val).
