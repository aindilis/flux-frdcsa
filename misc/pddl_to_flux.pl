%% evaluate a sample of this:

%% :- dynamic ':-'/2.

:- consult('/var/lib/myfrdcsa/codebases/cats/engines/prolog-game-engine/attempts/3/flux/prolog-planning-library/parseDomain.pl').
:- consult('/var/lib/myfrdcsa/codebases/cats/engines/prolog-game-engine/attempts/3/flux/prolog-planning-library/parseProblem.pl').

get_actions(     	domain(_, _, _, _, _, _, _, A), A).		
get_problem_name(	problem(N, _, _, _, _, _, _, _, _), N).
get_init(		problem(_, _, _, _, I, _, _, _, _), I).
get_goal(		problem(_, _, _, _, _, G, _, _, _), G).
get_metric(		problem(_, _, _, _, _, _, _, M, _), M).
get_objects(		problem(_, _, _, O, _, _, _, _, _), O).
get_precondition(	action(_, _, P, _, _, _), P).
get_positiv_effect(	action(_, _, _, PE, _, _), PE).
get_negativ_effect(	action(_, _, _, _, NE, _), NE).
get_assign_effect(	action(_, _, _, _, _, AE), AE).
get_parameters(		action(_, P, _, _, _, _), P).
get_action_def(		action(Name, Params, _, _, _, _), F):-
		untype(Params, UP),
		F =.. [Name|UP].

view(Item) :-
	write_term(Item,[quoted(true)]),nl,!.

test :-
	parseDomain('/var/lib/myfrdcsa/codebases/cats/engines/prolog-game-engine/attempts/3/flux/prolog-planning-library/test/blocks/domain-blocks.pddl', Domain),
	parseProblem('/var/lib/myfrdcsa/codebases/cats/engines/prolog-game-engine/attempts/3/flux/prolog-planning-library/test/blocks/blocks-03-0.pddl',Problem),
	get_actions(Domain,Actions),
	findall(FLUXAction,(member(Action,Actions),pddlToFLUXAction(Action,FLUXAction)),FLUXActions),
	nl,nl,nl,
	view([fluxActions,FLUXActions]).

pddlToFLUXAction(Action,FLUXAction) :-
	convertPDDLVariableToPrologVariable(?z1,Z1),
	convertPDDLVariableToPrologVariable(?z2,Z2),
	Action = action(Name,Parameters,TmpPreconditions,TmpPositiveEffects,TmpNegativeEffects,_),
	findall([Type,Var],(member(ArgType,Parameters),ArgType =.. [Type|Args],member(Arg,Args),member(A,Arg),convertPDDLVariableToPrologVariable(A,Var)),TypeSpecs),
	findall(Var,member([_,Var],TypeSpecs),Vars),
	ActionName =.. [Name|Vars],
	Head = state_update(Z1, ActionName, Z2, []),
	convertFluentPDDLVariableToPrologVariables(TmpPreconditions,Preconditions),
	convertFluentPDDLVariableToPrologVariables(TmpPositiveEffects,PositiveEffects),
	convertFluentPDDLVariableToPrologVariables(TmpNegativeEffects,NegativeEffects),
	findall(holds(Precondition,Z1),member(Precondition,Preconditions),Holds),
	append([[Head],Holds,[update(Z1,NegativeEffects,PositiveEffects,Z2)]],FLUXArgs),
	FLUXAction =.. [':-'|FLUXArgs],
	view([fluxAction,FLUXAction]).

shell_quote_term(Term,Atom) :-
	with_output_to(atom(Atom),write_term(Term,[quoted(true)])).

capitalize(WordLC, WordUC) :-
	atom_chars(WordLC, [FirstChLow|LWordLC]),
	atom_chars(FirstLow, [FirstChLow]),
	upcase_atom(FirstLow, FirstUpp),
	atom_chars(FirstUpp, [FirstChUpp]),
	atom_chars(WordUC, [FirstChUpp|LWordLC]),!.

convertFluentPDDLVariableToPrologVariables(Fluents,ConvertedFluents) :-
	findall(ConvertedFluent,
		(   
		    member(Fluent,Fluents),
		    Fluent =.. [P|Args],
		    findall(ConvertedArg,
			    (
			     member(Arg,Args),
			     convertPDDLVariableToPrologVariable(Arg,ConvertedArg)
			    ),
			    ConvertedArgs),
		    ConvertedFluent =.. [P|ConvertedArgs]
		),
		ConvertedFluents).

convertPDDLVariableToPrologVariable(X,Y) :-
	shell_quote_term(X,Z),
	atom_concat('?',V,Z),
	capitalize(V,Y).

:- test.

%% state_update(z1,stack([?x],[?y]),z2,[]) :-
%% 	holds(holding(?x),z1),
%% 	holds(clear(?y),z1),
%% 	update(z1,[holding(?x),clear(?y)],[clear(?x),handempty,on(?x,?y)],z2).



%% (:action pick-up
%% 	     :parameters (?x - block)
%% 	     :precondition (and (clear ?x) (ontable ?x) (handempty))
%% 	     :effect
%% 	     (and (not (ontable ?x))
%% 		   (not (clear ?x))
%% 		   (not (handempty))
%% 		   (holding ?x)))

%% action('pick-up',
%%        [block([?x])],
%%        [clear(?x),ontable(?x),handempty],
%%        [holding(?x)],
%%        [ontable(?x),clear(?x),handempty],
%%        [])

%% state_update(Z1, bring(R1,R2), Z2, []) :-
%% 	holds(in_room(P,R1), Z1),
%% 	holds(request(R1,X), Z1),
%% 	update(Z1, [in_room(P,R2), occupied(R2)],
%% 	       [in_room(P,R1), occupied(R1), request(R1,X)], Z2).

%% action('bring',
%%	[patient([?p]),room([?r1]),roomType([?x])],
%%	[in_room(?p,?r1),request(?r1,?x)],
%%      [in_room(?p,?r1), occupied(?r1), request(?r1,?x)],
%% 	[in_room(?p,?r2), occupied(?r2)],
%%      [])

%% take all
% Colenction shortcuts functions.
% get(+Structure, -Parameter)


%% /var/lib/myfrdcsa/codebases/cats/engines/prolog-game-engine/attempts/3/flux/6_nursebot_domain.pl,