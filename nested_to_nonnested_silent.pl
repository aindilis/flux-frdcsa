:- dynamic counter/1, holder/1.
%% :- discontiguous view/1.

%% :- module(treetologic, [tree_logic/2]).

%% :- use_module(library(varnumbers)).

% Written by anniepoo on [2018-02-11]

tree_logic(Tree, LogicForm) :-
    ground(Tree),
    gensym(v, Root),
    tree_logic(Root, Tree, LogicForm).
tree_logic(Tree, [Root | Rest]) :-
    Root =.. [_, Self | _],
    var_tree([Root | Rest], Self, Tree).


%!      tree_logic(+Self:atom, +Tree:acyclic, -LogicForm:list) is det
%
%  convert a tree of form a(b,c(d))
%  to a list like [a(v1,v2,v3),b(v2),c(v3,v4),d(v4)]
%
%  where the first argument is a 'self' argument
%  and the first self argument is passed in
%
tree_logic(Self, Leaf, [tree_logic_var_index(Self,Leaf)]) :-
    integer(Leaf).
tree_logic(Self, Leaf, [LeafTerm]) :-
    atomic(Leaf),
    LeafTerm =.. [Leaf, Self].
tree_logic(Self, Node, [SelfNode | LogicForm]) :-
    Node =.. [Functor | Args],
    maplist(argvar , Args, Vars),
    SelfNode =.. [Functor, Self | Vars],
    maplist(tree_logic, Vars, Args, UnflatLogicForms),
    flatten(UnflatLogicForms, LogicForm).

argvar(_, Var) :-
    gensym(v, Var).


%!  var_tree(+Children:list, +Var:atom, -Tree:acyclic)
%
%   Given a var and the original list, make a tree
var_tree(Children, Var, Tree) :-
    member(Term, Children),
    Term =.. [Functor, Var | Args],
    maplist(var_tree(Children), Args, SubForest),
    Tree =.. [Functor | SubForest].

convertNestedToFFFOPC(Nested,FFFOPC) :-
	reset_gensym(v),
	tree_logic(Nested,LFs),
	update_index_1(1,LFs,FFFOPC).

update_index_1(Index,LFs,NewLFs) :-
	findall(NewLF,
		(   
		    member(LF,LFs),
		    LF =.. [P|Args],
		    findall(NewArg,
			    (	
				member(Arg,Args),
				(   (	var(Arg) ; number(Arg)) ->
				    (	NewArg = Arg ) ;
				    (	concat_atom([v,Var],Arg),
					atomic_list_concat([v,Index,'_',Var],'',NewArg)))
			    ),
			    NewArgs),
		    NewLF =.. [P|NewArgs]
		),
		NewLFs).

convertFFFOPCToNested(FFFOPC,Nested) :-
	update_index_2(FFFOPC,Tmp),
	tree_logic(Nested,Tmp).

update_index_2(LFs,NewLFs) :-
	findall(NewLF,
		(   
		    member(LF,LFs),
		    LF =.. [P|Args],
		    findall(NewArg,
			    (	
				member(Arg,Args),
				atomic_list_concat([_,Var], '_', Arg),
				atomic_list_concat(['v',Var],'',NewArg)
			    ),
			    NewArgs),
		    NewLF =.. [P|NewArgs]
		),
		NewLFs).

capabilityEnablesCapability(treetologic,[prologAgent, fLUX, gDL, pDDL, dataIntegration,flowchartGeneration]).

convert(Term,Copy) :-
	copy_term(Term,CopyTerm),
	term_variables(Term,VarNames),
	term_variables(CopyTerm,CopyVarNames),
	squelch(CopyVarNames),
	numbervars(CopyTerm,0,End),
	squelch(End),
	tree_logic(CopyTerm, LogicTmp),
	update_index_1(1,LogicTmp,Logic),
	findall(X,(member(A,Logic),A =.. [P|T],
		   (   (   not(P = '$VAR'), not(P = 'tree_logic_var_index')) ->
		       (   X = A ) ;
		       (   (   P = '$VAR') ->
			   (   T = [V1,V2],
			       retractall(holder(_)),
			       assert(holder(V1)),
			       false
			       ) ;
			   (   T = [V2,N],
			       holder(V1),
			       nth0(N,VarNames,_),
			       Y =.. ['$VAR',N],
			       X =.. [var,V1,Y]
			   )
		       ))),Results),

	varnumbers(Results,Copy),
	term_variables(Copy,VarNames),
	true.

squelch(_) :-
	true.

convertBack(Term,Copy,Index) :-
	copy_term(Term,CopyTerm),
	term_variables(Term,VarNames),
	term_variables(CopyTerm,CopyVarNames),
	squelch(CopyVarNames),
	numbervars(CopyTerm,0,_),
	convertThingy(CopyTerm,Output,VarNames),
	de_update_index_1(Index,Output,NewOutput),
	reduce(NewOutput,NewOutputReduced),
	tree_logic(TmpCopy,NewOutputReduced),
	deVar(TmpCopy,Results),
	varnumbers(Results,Copy),
	term_variables(Copy,VarNames),
	true.


convertThingy(Input,Output,VarNames) :-
	assertz(counter(1000)),
	varnumbers(Input,Copy),
	term_variables(Copy,VarNames),
	findall(X,(member(A,Input),A =.. [P|T],
		   (   (   not(P = 'var')) ->
		       (   X = A ) ;
		       (   T = [V1,'$VAR'(N)],
			   counter(Counter),
			   NewCounter is Counter + 1,
			   retractall(counter(_)),
			   assertz(counter(NewCounter)),
			   atomic_list_concat(['v5',Counter],'_',V3),
			   %% V3 = v5_5,
			   (   X =.. ['$VAR',V1,V3] ;
			       (   X =.. ['tree_logic_var_index',V3,N])))
		   )),Output).

de_update_index_1(Index,LFs,NewLFs) :-
	findall(NewLF,
		(   
		    member(LF,LFs),
		    LF =.. [P|Args],
		    findall(NewArg,
			    (	
				member(Arg,Args),
				(   number(Arg) -> NewArg = Arg ;
				    (	atom_string(Arg,String),
					split_string(String,'_','',[A,B]),
					split_string(A,'v','',[_|Index]),
					atom_string(BAtom,B),
					atomic_list_concat(['v',BAtom],'',NewArg)))
			    ),
			    NewArgs),
		    NewLF =.. [P|NewArgs]
		),
		NewLFs).

reduce(Logic,Reduced) :-
	findall(X,(member(A,Logic),A =.. [P|T],
		   (   (   not(P = '$VAR'), not(P = 'tree_logic_var_index')) ->
		       (   X = A ) ;
		       (   (   P = '$VAR') ->
			   (   T = [V1,V2],
			       retractall(holder(_)),
			       assert(holder(V1)),
			       false
			   ) ;
			   (   T = [V2,N],
			       holder(V1),
			       atomic_list_concat(['var',N],'_',Y),
			       X =.. [Y,V1]
			   )
		       ))),Reduced).

deVar(Original,New) :-
	(   (	Original =.. [P|Args], not(length(Args,0))) ->
	    (	findall(NewArg,
			(   member(Arg,Args),
			    deVar(Arg,NewArg)),
			NewArgs),
		New =.. [P|NewArgs]
	    ) ;
	    (	number(Original) -> New = Original ;
		(   (	
			atom_string(Original,OriginalString),
			split_string(OriginalString,'_','',[_,VarNumString]),
			atom_string(VarNumAtom,VarNumString),
			atom_number(VarNumAtom,VarNum),
			New =.. ['$VAR',VarNum],
			!
		    ) ; New = Original))).

viewIf(Item) :-
	write_term(Item,[quoted(true)]),nl,!.
