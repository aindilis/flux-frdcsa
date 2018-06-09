parent(p1,p2).
parent(p2,p3).
parent(p3,p4).
parent(p4,p5).

ancestor(A,D,[A]) :-
    parent(A,D).
ancestor(A,D,[X|Z]) :-
    parent(X,D),
    ancestor(A,X,Z).
    
