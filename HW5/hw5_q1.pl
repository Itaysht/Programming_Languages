:- use_module(library(clpfd)).
pythagorean(A, B, C) :- A*A + B*B =:= C*C.
prime(1) :- !, fail.
prime(N) :- M is N-1, A in 2..M, indomain(A), N mod A =:= 0, !, fail.
prime(_).
goldbach(X, Y, N) :- N mod 2 =:= 0, X in 3..N, N #= X+Y, indomain(X), prime(X), prime(Y).
