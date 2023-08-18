:- use_module(library(clpfd)).

interleave([], []).
interleave([[]|X], R) :- interleave(X, R).
interleave([[X|Xs]|Ys], [X|R]) :-
 append(Ys, [Xs], Z),
 interleave(Z, R).

filter([], _).
filter([X|XS], N) :- X in 1..N, filter(XS, N).

legal_graph(graph([])) :- !, fail.
legal_graph(graph(X)) :- interleave(X, R), length(X, N), filter(R, N).

edge(graph(X), _, _) :- \+ legal_graph(graph(X)), !, fail.
edge(graph(X), A, B) :- A #> 0, append(Y, [Z|_], X), C #= A-1, length(Y, C), member(B, Z).

path_aux(graph(_), A, A, _, _) :- !, fail.
path_aux(graph(_), _, _, _, 1) :- !, fail.
path_aux(graph(X), A, B, [A, B], _) :- edge(graph(X), A, B), !.
path_aux(graph(X), A, B, [P1|PS], N) :- A #= P1, edge(graph(X), P1, P2), M #= N -1, path_aux(graph(X), P2, B, PS, M).

path(graph(X), A, B, P) :- length(X, N), A in 1..N, B in 1..N, indomain(A), indomain(B), path_aux(graph(X), A, B, P, N), all_distinct(P).

circle(graph(X), [P1|PS]) :- length(X, N), P1 in 1..N, indomain(P1), edge(graph(X), P1, P2), path(graph(X), P2, P1, PS).

dag(graph(X)) :- \+ circle(graph(X), _).