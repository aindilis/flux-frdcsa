:- ['swipl_compatibility_layer_for_eclipse_prolog'].

%% squelch(_) :- true.

convertPrologToFFFOPC(Prolog,N,FFFOPC) :-
	term_string(Prolog,String),
	atom_string(Term,String),
	concat_atom(['/var/lib/myfrdcsa/codebases/minor/flp-pddl/convert-3.pl -n ',N,' -l -t ''',Term,''' 2> /dev/null'],Command),
	shell_command_to_string(Command,Output),
	read_atom_to_term(Output,FFFOPC).

:- dynamic counter/2.

nextCounter(Task,ID) :-
	\+ counter(Task,_),
	NewID is 1,
	concat_atom([Task,NewID],ID),
	assert(counter(Task,NewID)).
nextCounter(Task,ID) :-
	counter(Task,OrigID),
	retractall(counter(Task,OrigID)),
	NewID is OrigID + 1,
	concat_atom([Task,NewID],ID),
	assert(counter(Task,NewID)).

resetCounter(Task) :-
	retractall(counter(Task,_)).
