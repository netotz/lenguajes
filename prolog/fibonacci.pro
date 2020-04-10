fibonacci(0,1).
fibonacci(1,1).
fibonacci(N,Fibo) :-
    N > 0,
    I is N-1, J is N-2,
    fibonacci(I,A), fibonacci(J,B),
    Fibo is A+B.
