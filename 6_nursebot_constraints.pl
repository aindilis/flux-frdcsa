
%%% The following code has been produced by the CHR compiler


:- ( current_module(chr) -> true ; use_module(library(chr)) ).

:- get_flag(variable_names, Val), setval(variable_names_flag, Val), set_flag(variable_names, off).
room_occupied(A) :-
	'CHRgen_num'(B),
	coca(add_one_constraint(B, room_occupied(A))),
	'CHRroom_occupied_1'(room_occupied(A), C, D, B).



%%% Rules handling for room_occupied / 1

'CHRroom_occupied_1'(room_occupied(A), B, C, D) :-
	(
	    'CHRnonvar'(B)
	;
	    'CHRalready_in'('CHRroom_occupied_1'(room_occupied(A), B, C, D)),
	    coca(already_in)
	),
	!.
'CHRroom_occupied_1'(room_occupied([A|B]), C, D, E) ?-
	coca(try_rule(E, room_occupied([A|B]), anonymous("0"), room_occupied([F|G]), replacement, true, F = in_room(H, I) -> (holds(occupied(I), G, J), room_occupied(J)) ; F = occupied(I) -> (holds(in_room(K, I), G, J), room_occupied(J)) ; room_occupied(G))),
	!,
	'CHRkill'(C),
	coca(fired_rule(anonymous("0"))),
	(
	    A = in_room(L, M)
	->
	    holds(occupied(M), B, N),
	    room_occupied(N)
	;
	    (
		A = occupied(M)
	    ->
		holds(in_room(O, M), B, N),
		room_occupied(N)
	    ;
		room_occupied(B)
	    )
	).
'CHRroom_occupied_1'(room_occupied(A), B, C, D) :-
	'CHRroom_occupied_1__1'(room_occupied(A), B, C, D).
:- set_flag('CHRroom_occupied_1' / 4, leash, notrace).
:- current_macro('CHRroom_occupied_1' / 4, _326103, _326104, _326105) -> true ; define_macro('CHRroom_occupied_1' / 4, tr_chr / 2, [write]).
'CHRroom_occupied_1__1'(A, B, C, D) :-
	'CHRroom_occupied_1__2'(A, B, C, D).
:- set_flag('CHRroom_occupied_1__1' / 4, leash, notrace).
'CHRroom_occupied_1__2'(room_occupied(A), B, C, D) :-
	(
	    'CHRvar'(B)
	->
	    'CHRdelay'([B, room_occupied(A)], 'CHRroom_occupied_1'(room_occupied(A), B, C, D))
	;
	    true
	).
:- set_flag('CHRroom_occupied_1__2' / 4, leash, notrace).

:- getval(variable_names_flag, Val), set_flag(variable_names, Val).
