sumatresyduplica(X,Y) :- Y is (X+3)*2.
sumatresyduplica(X,Z) :- sumatresyduplica(X,Y), sumatresyduplica(Y,Z).
