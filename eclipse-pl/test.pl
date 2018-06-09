:- ['serpro'].
 
testTo(X,Y) :-
	toCanonical(X,Y),
	write_term(Y, [quoted(true)]),nl.

testFrom(X,Y) :-
	fromCanonical(X,Y),
	write_term(Y, [quoted(true)]),nl.

test :-
	testTo(thisIsATest,X),
	testFrom(X,_).
	