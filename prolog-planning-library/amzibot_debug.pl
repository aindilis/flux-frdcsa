poss :-
	init(Z),findall(X,poss(X,Z),Xs),translateListFromCanonical(Xs,Ys),see(Ys).
