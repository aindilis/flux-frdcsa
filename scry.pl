scry(Item) :-
	findall(Item,Item,Result),
	write_header(Item,Result),nl,
	write_list(Result),
	write_footer(Item,Result),nl,nl.

tsScry(Item) :-
	findall(Item,Item,Result),
	write_header(Item,Result),nl,
	sec_write_list(Result),
	write_footer(Item,Result),nl,nl.

scryList(X,List) :-
	findall(X,X,List).

write_header(Item,Result) :-
	write_header_footer(Item,Result).

write_footer(Item,Result) :-
	write_header_footer(Item,Result).

write_header_footer(Item,Result) :-
	write_result_length(Result),write(' for Scrying for: '),
	write_term(Item,[quoted(true)]).

write_result_length(Result) :-
	length(Result,Length),
	write(Length),write(' results').

write_list(List) :-
	member(Term,List),
	isDeclassified(Term),
	write('    '),write_term(Term,[quoted(true)]),write('.'),nl,
	fail.
write_list(_).

sec_write_list(List) :-
	member(Term,List),
	write('    '),write_term(Term,[quoted(true)]),write('.'),nl,
	fail.
sec_write_list(_).

listCompletions(Completions) :-
	setof(X,M^P^current_predicate(X,M:P),Completions).

listCompletionsForModule(M,Completions) :-
	setof(X,M^P^current_predicate(X,M:P),Completions).


declassified(Goal) :-
	Goal,
	forall(occurs:sub_term(X,Goal),isDeclassified(X)).

isDeclassified(_) :-
	true.

see(X) :-
	write_term(X, [quoted(true)]),nl.
