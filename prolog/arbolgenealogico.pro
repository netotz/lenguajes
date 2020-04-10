hijo(anne,bridget).
hijo(bridget,caroline).
hijo(caroline,donna).
hijo(donna,emily).

descendiente(X,Y) :- hijo(X,Y).
descendiente(X,Y) :- hijo(X,Z),descendiente(Z,Y).

explica :- descendiente(X,Y), write(X),
    write(' es descendiente directo de '),
    write(Y),nl.
