genlsDirectlyList([gRoomType,uRoomType,xRoomType],roomType).
genlsDirectlyList([patient,roomType,room],canonical).

isaDirectlyList([andrewDougherty,meredithMcGhan,eleanorDougherty],patient).
isaDirectlyList([room1,room2,room3,room4,room5,room6],room).
isaDirectlyList([room1,room2],gRoomType).
isaDirectlyList([room3,room4],uRoomType).
isaDirectlyList([room5,room6],xRoomType).
isaDirectlyList([room1,room2,room3,room4,room5,room6],localRoom).

formalDomainSpecification([
			   in_room(patient,room),
			   occupied(room),
			   request(room,roomType)
			  ]).
formalActionSpecification([
			   bring(room,room),
			   check_light(room)
			  ]).
extraFormalSpecification([
			  examination_room(roomType,room)
			 ]).

state_update(Z1, bring(R1,R2), Z2, []) :-
	holds(in_room(P,R1), Z1),
	holds(request(R1,X), Z1),
	update(Z1, [in_room(P,R2), occupied(R2)],
	       [in_room(P,R1), occupied(R1), request(R1,X)], Z2).

state_update(Z, check_light(R), Z, [Light]) :-
	Light = true,  holds(occupied(R), Z) ;
	Light = false, not_holds(occupied(R), Z).

specification(X) :-
	(formalDomainSpecification(List) ;
	 formalActionSpecification(List) ;
	 extraFormalSpecification(List)), member(X,List).


%% %%%% NESTED

%% formalDomainSpecification_nested([
%% 				  contains(pictureFn(xiao),person),
%% 				  believes(andrewDougherty,in_room(patient,room1)),
%% 				  in_room(patient,room2),
%% 				  occupied(room),
%% 				  request(room,roomType)
%% 				 ]).

%% specification_nested(Translations) :-
%% 	assert(counter('',-1)),
%% 	formalDomainSpecification_nested(List),
%% 	%% formalDomainSpecification(List),
%% 	findall(Translation,(member(Statement,List),nextCounter('',N),convertPrologToFFFOPC(Statement,N,Translation)),TmpTranslations),
%% 	findall(Translation,(member(Translations,TmpTranslations),member(Translation,Translations)),Translations).
%% 	%% write_term([translations,Translations],[quoted(true)]).

%% state_update_nested(Z1, bring(R1,R2), Z2, []) :-
%% 	holds_nested(in_room(P,R1),Z1),
%% 	holds_nested(request(R1,X), Z1),
%% 	update_nested(Z1,
%% 		      [in_room(P,R2), occupied(R2)],
%% 		      [in_room(P,R1), occupied(R1), request(R1,X)], Z2).

%% holds_nested(Term,Z) :-
%% 	convertPrologToFFFOPC(Term,1,Fluents),
%% 	%% forall(member(Fluent,Fluents),holds(Fluent,Z)).
%% 	true.

%% update_nested(Z,Before,After) :-
%% 	convertPrologToFFFOPC(Before,1,BeforeFluents),
%% 	convertPrologToFFFOPC(After,1,AfterFluents),
%% 	view([beforeFluents,BeforeFluents]),
%% 	view([afterFluents,AfterFluents]).
