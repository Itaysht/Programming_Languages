:- [hw5_q2].

topo_aux(graph(X), S) :- append(A, B, S), append(_, [I], A), append(_, C, B), append([J], _, C), path(graph(X), J, I, _).

topological_sort(graph(X), S) :- dag(graph(X)), length(X, N), length(S, N), filter(S, N), all_distinct(S), label(S), \+ topo_aux(graph(X), S).

filler_aux(0, L, L) :- !.
filler_aux(N, S, L) :- M is N-1, N #> 0, filler_aux(M, [N|S], L).

filler(N, L) :- filler_aux(N, [], L).

get_to_aux(graph(_), [], _, []) :- !.
get_to_aux(graph(X), [S|L], I, [S|SS]) :- ((path(graph(X), I, S, _), path(graph(X), S, I,_));(S #= I)), get_to_aux(graph(X), L, I, SS), !.
get_to_aux(graph(X), [_|L], I, SS) :- get_to_aux(graph(X), L, I, SS).

get_to(graph(X), I, S) :- length(X, N), filler(N, L), get_to_aux(graph(X), L, I, S).

build_scc_aux(graph(_), [], []) :- !.
build_scc_aux(graph(X), [A|L], [S|SS]) :- get_to(graph(X), A, T), S = T, build_scc_aux(graph(X), L, SS).

build_scc(graph(X), S) :- length(X, N), filler(N, L), build_scc_aux(graph(X), L, S).

remove_dup([], []) :- !.
remove_dup([L|LL], [L|RR]) :- \+ member(L, LL), remove_dup(LL, RR), !.
remove_dup([_|LL], RR) :- remove_dup(LL, RR).

when_bounded(graph(X), S) :- length(S, N), I in 1..N, indomain(I), nth1(I, S, A), (scc_aux(graph(X), A); (\+ scc_aux(graph(X), A), scc_aux_max(graph(X), A))).

scc_aux(graph(_), [_]) :- fail, !.
scc_aux(graph(X), S) :- append(A, B, S), append(_, [I], A), append(_, C, B), append([J], _, C), (\+ path(graph(X), J, I, _); \+ path(graph(X), I, J, _)).

scc_aux_max(graph(X), S) :- length(X,N), Y in 1..N, indomain(Y), append(S, [Y], M),all_distinct(M), \+ scc_aux(graph(X), M).

scc(graph(X), S) :- (build_scc(graph(X), T), remove_dup(T, S), !);(\+ when_bounded(graph(X), S)).
