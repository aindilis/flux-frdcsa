zInitImperfect(Z,Z0) :-
	zInit(ZInit,_),
	write_list([zInit,ZInit]),
	findall(CanonicalP,(member(P,ZInit),myToCanonical(P,CanonicalP)),ZCanonical),
	%% write_list([zCanonical,ZCanonical]),
	append(ZCanonical, Z, Z0).
