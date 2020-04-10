fibonacci(0,1).
fibonacci(1,1).
fibonacci(N,Fibo) :-
    N > 0,
    I is N-1, J is N-2,
    fibonacci(I,A), fibonacci(J,B),
    Fibo is A+B.

% pi/6 rad = 30°
rad(Deg,Rad) :- Rad is (Deg*pi)/180.
redondear(Num,Exp,Num2) :- X is Num * 10^Exp, round(X,Y), Num2 is Y / 10^Exp.

altura(Hipot,Y) :- Y is sin(pi/6)*Hipot.
dist(Hipot,X) :- X is cos(pi/6)*Hipot.
perim(Diam,Perim) :- Perim is pi*Diam.
posang(Dist,Perim,Ang) :- Ang is (Dist/Perim)*360.
coterminal(Ang,Cot) :- X is Ang/360, N is truncate(X), Cot is Ang - (360*N).

calcular(Ang, _, _, _, _) :- Ang < 0, write("No introducir ángulos negativos."), !.
calcular(_, Alt, _, _, _) :- Alt < 0, write("No existe medidas negativa."), !.
calcular(_, _, N, _, _) :- N < 1, write("La serie de Fibonacci debe comenzar en la posición 1."), !.
calcular(_, _, _, Ramas, _) :- Ramas < 0, write("Debe calcular al menos una rama."), !.
calcular(_, _, _, _, Diam) :- Diam =< 0, write("El diámetro de un árbol no puede medir 0 o menos."), !.

calcular(AngI,AltI,N,Ramas,Diam) :-
    Ramas > 0, nl,
    fibonacci(N,Fibo),
    dist(Fibo,Dist),
    perim(Diam,P),
    posang(Dist,P,A),
    Cot is A + AngI,
    coterminal(Cot,Ang),
    write("Posición angular: "), write(Ang), write("°"), nl,
    altura(Fibo,X),
    redondear(X,4,H),
    Alt is H + AltI,
    write("Altura: "), write(Alt), nl,
    I is Ramas-1,
    M is N+1,
    calcular(AngI,AltI,M,I,Diam).
