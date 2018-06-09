

ask(Attr, Val):-
    write(Attr),tab(1),write(Val),
    tab(1),write('(yes/no)'),write(?),
    read(X),
    X = yes.


