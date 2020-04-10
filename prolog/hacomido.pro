digiere(X,Y) :- hacomido(X,Y).
digiere(X,Y) :- hacomido(X,Z), digiere(Z,Y).
hacomido(mosquito,sangre(cacerolo)).
hacomido(rana,mosquito).
hacomido(caiman,rana).
