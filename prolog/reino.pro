reino(animalia).
filo(chordata).
filo(cnidaria).
clase(mammalia).
clase(sauropsida).
clase(anthozoa).
clase(cubozoa).
orden(sirenia).
orden(lagomorpha).
orden(crocodilia).
orden(squamata).

animalia(chordata).
animalia(cnidaria).
 chordata(mammalia).
 chordata(sauropsida).
  mammalia(sirenia).
  mammalia(lagomorpha).
  sauropsida(crocodilia).
  sauropsida(squamata).
 cnidaria(anthozoa).
 cnidaria(cubozoa).

chordata(X) :- mammalia(X).
chordata(X) :- sauropsida(X).
animalia(X) :- chordata(X).

animalia(X) :- cnidaria(X).

comun(A,B) :- animalia(A),animalia(B).









