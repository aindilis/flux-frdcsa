%% evaluate a sample of this:

:- consult('/var/lib/myfrdcsa/codebases/cats/engines/prolog-game-engine/attempts/3/flux/prolog-planning-library/parseDomain.pl').
:- consult('/var/lib/myfrdcsa/codebases/cats/engines/prolog-game-engine/attempts/3/flux/prolog-planning-library/parseProblem.pl').

view(Item) :-
	write_term(Item,[quoted(true)]),nl,!.

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

test :-
	view([1]),
	parseDomain('/var/lib/myfrdcsa/codebases/cats/engines/prolog-game-engine/attempts/3/flux/prolog-planning-library/test/blocks/domain-blocks.pddl', D),
	get_actions(D, A),
	view([2,A]),
	parseProblem('/var/lib/myfrdcsa/codebases/cats/engines/prolog-game-engine/attempts/3/flux/prolog-planning-library/test/blocks/blocks-03-0.pddl',P),
	view([3]),
	view([d,D,p,P]).

%% take all
% Colenction shortcuts functions.
% get(+Structure, -Parameter)

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

%% /var/lib/myfrdcsa/codebases/cats/engines/prolog-game-engine/attempts/3/flux/6_nursebot_domain.pl