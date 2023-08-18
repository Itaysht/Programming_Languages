fun curry f = fn a => fn b => f(a,b);
fun uncurry f = fn (a, b) => f a b;