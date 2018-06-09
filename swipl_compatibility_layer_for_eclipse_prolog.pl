:- use_module(library(swi)).
:- use_module(library(fromonto)).

shell(X) :-
	%% view([x,X]),
	nonvar(X),
	system(X).

shell_quote_term(Term,Atom) :-
	with_output_to(atom(Atom),write_term(Term,[quoted(true)])).

view(Item) :-
	write_term(Item,[quoted(true)]),nl,!.

read_data_from_file(File,Data) :-
	open(File, read, Stream),
	findall(String,read_string(Stream, end_of_file, _, String),[String]),
	atom_string(Data,String).

shell_command_to_string(Command,String) :-
	File = '/tmp/shell_command_to_string.txt',
	concat_atom(['rm -f ',File],Command1),
	shell(Command1),
	concat_atom([Command,' > ',File],Command2),
	shell(Command2),
	read_data_from_file(File,String),
	%% view([string,String]),
	shell(Command1).

read_atom_to_term(Atom,Term) :-
	atom_string(Atom,String),
	open(string(String),read,Stream),
	read_term(Stream,Term,[]).

%% forall(X,Y) :-
%% 	true.

%% atomic_list_concat(X,Y,Z) :-
%% 	true.

%% atom_concat(X,Y,Z) :-
%% 	concat_atom([X,Y],Z).