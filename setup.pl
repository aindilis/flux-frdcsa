setup :-
	setupIsa,
	setupArgTypes,
	setupInit.

setupArgTypes :-
	specification(P),
	(debuggingEnabled(true) -> see([p,P]) ; true),
	P =.. [Pred|List],
	length(List,Arity),
	assert(counter(0)),
	findall(Item,
		(
		 member(Item,List),
		 retract(counter(X)),
		 Y is X + 1,
		 assert(counter(Y)),
		 (debuggingEnabled(true) -> (
					     write('    '),
					     see([item,Item])
					     ) ; true),
		 (genls(Item,canonical) ->
		  ((debuggingEnabled(true) -> (
					       write('        '),
					       see(argType(Pred/Arity,Y,canonical))
					      ) ; true),
		   assert(argType(Pred/Arity,Y,canonical))
		  ) ;
		  (genls(Item,integer) ->
		   (
		    (debuggingEnabled(true) -> (
						write('        '),
						see(argType(Pred/Arity,Y,integer))
					       ) ; true),
		    assert(argType(Pred/Arity,Y,integer))
		   ) ;
		   true
		  )
		 )
		),
		_),
	retract(counter(_)),
	fail.
setupArgTypes.

setupInit :-
	problemInit(Init),
	member(Fluent,Init),
	myToCanonical(Fluent,FluentCanonical),
	assert(FluentCanonical),
	fail.
setupInit.
