%% <REDACTED>

mother(M,C) :-
    parent(M,C),
    female(M).

father(M,C) :-
    parent(M,C),
    male(M).

grandmother(M,C) :-
    mother(M,B),
    parent(B,C).

grandfather(M,C) :-
    parent(B,C),
    father(M,B).

grandparent(M,C) :- grandfather(M,C).
grandparent(M,C) :- grandmother(M,C).

paternal_grandfather(M,C) :-
    father(M,B),
    father(B,C).

paternal_grandmother(M,C) :-
    mother(M,B),
    father(B,C).

maternal_grandfather(M,C) :-
    father(M,B),
    mother(B,C).

maternal_grandfmother(M,C) :-
    mother(M,B),
    mother(B,C).


sibling(X,Y) :-
    parent(A,X),
    parent(A,Y),
    \=(X,Y).

brother(X,Y) :-
    sibling(X,Y),
    male(X).

sister(X,Y) :-
    sibling(X,Y),
    female(X).

uncle(X,Y) :-
    parent(Z,X),
    sibling(Y,Z),
    male(Y).

aunt(X,Y) :-
    parent(Z,X),
    sibling(Y,Z),
    female(Y).

cousins(X,Y) :-
    grandparent(A,X),
    grandparent(A,Y).
    
married(X,Y) :- spouse(X,Y).
married(X,Y) :- spouse(Y,X).

grandchild(X,Y) :-
    grandparent(Y,X).

ancestor(X,Y) :-
    parent(X,Y).
ancestor(X,Y) :-
    parent(Z,Y),
    ancestor(X,Z).

descendant(X,Y) :-
    parent(Y,X).
descendant(X,Y) :-
    parent(Y,Z),
    descendant(X,Z).

