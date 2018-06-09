genlsDirectly(Subclass,Superclass) :-
 	genlsDirectlyList(H,Superclass),
 	member(Subclass,H).

genls(Subclass,Superclass) :-
	genlsDirectly(Midclass,Superclass),
	genls(Subclass,Midclass).
genls(Subclass,Superclass) :-
	genlsDirectly(Subclass,Superclass).

:- dynamic isa/2.

isaDirectly(Item,Class) :-
	isaDirectlyList(List,Class),
	member(Item,List).

setupIsa :-
	genls(Subclass,Superclass),
	isaDirectly(Item,Subclass),
	\+ isa(Item,Superclass),
	(debuggingEnabled(true) -> see([isa,isa(Item,Superclass)]) ; true),
	assert(isa(Item,Superclass)),
	fail.
setupIsa :-
	isaDirectly(Item,Class),
	\+ isa(Item,Class),
	(debuggingEnabled(true) -> see([isa,isa(Item,Class)]); true),
	assert(isa(Item,Class)),
	fail.
setupIsa.


%%  :- dynamic argIsa/3.
%% 
%%  argIsa(PredicateAndArity,1,Type) :-
%%  	arg1Isa(PredicateAndArity,Type).
%%  argIsa(PredicateAndArity,2,Type) :-
%%  	arg2Isa(PredicateAndArity,Type).
%%  argIsa(PredicateAndArity,3,Type) :-
%%  	arg3Isa(PredicateAndArity,Type).
%%  argIsa(PredicateAndArity,4,Type) :-
%%  	arg4Isa(PredicateAndArity,Type).

