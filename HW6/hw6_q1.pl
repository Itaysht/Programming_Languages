add(R,bot,R) :- !.
add(R,s(A), s(B)) :- add(R, A, B).

multiply(R, bot, bot) :- R = bot, !.
multiply(bot, R, bot) :- R = bot, !.
multiply(_, bot, R) :- R = bot, !.
multiply(bot, _, R) :- R = bot, !.
multiply(s(A), s(B), C) :- ((multiply(A, s(B), D), add(s(B), D, C)); (multiply(s(A), B, E), add(s(A), E, C)) ; (add(s(B), D, C), multiply(A, s(B), D)); add(s(A), E, C), (multiply(s(A), B, E))), !.

power(_, bot, R) :- R = s(bot), !.
power(A, s(B), C) :- power(A, B, D), multiply(D, A, C), !.