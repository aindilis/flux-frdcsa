member(H,[H|T]).
member(X,[H|T]) :-
    member(X,T).

append([],X,X).
append([H|T1],X,[H|T2]) :-
    append(T1,X,T2).

remove([],X,X).
remove(H,[H|T],T).
remove(X,[H|T1],[H|T2]) :-
    remove(X,T1,T2).

findafter(H1,[H1|[H2|T]],H2).
findafter(X,[H|T],Y) :-
    findafter(X,T,Y).

split_at_element([H|T],H,[],T).
split_at_element([H|T1],X,[H|T2],L2) :-
    split_at_element(T1,X,T2,L2).

last_element([H|[]],H).
last_element([H|T],X) :-
    last_element(T,X).

list_length([],0).
list_length([H|T],Y) :-
    list_length(T,Z),
    Y is Z + 1.

respond([]).
respond([H|[]]) :-
    write(H).
respond([H|T]) :-
    write(H),tab(1),
    respond(T).

