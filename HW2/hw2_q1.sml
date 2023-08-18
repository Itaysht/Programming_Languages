fun sig1 a b g = if true then g(a,b) else b;
fun sig2 (a,b) f = if a=1 then f(b+2.0)="" else false;
fun sig3 f a b c = f a b;
fun sig4 a b c d = c + d + 1;
fun sig5 f a g = g (f a,f a);
fun sig6 a b = if a = () then if b = () then 0 else 1 else 0;
fun sig7 a (b,c) = if true then if true then a else b else c;
fun sig8 (a,b,c) = if true then (1, "hello", "world") else (a,b,c);