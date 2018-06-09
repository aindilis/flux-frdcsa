poss :-
	setup,init(Z),findall(X,poss(goto(48368685518133,X),Z),Xs),see(Xs).

poss2 :-
	setup,init(Z),findall(X,poss(goto(48368685518133,X),Z),Xs),translateListFromCanonical(Xs,Ys),see(Ys).

poss3 :-
	setup,init(Z),findall(X,poss(X,Z),Xs),translateListFromCanonical(Xs,Ys),see(Xs),see(Ys).

poss4 :-
	setup,init(Z),holds(here(R1),Z),findall(goto(R1,X),poss(goto(R1,X),Z),Xs),translateListFromCanonical(Xs,Ys),see(Xs),see(Ys).
