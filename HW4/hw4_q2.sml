use "hw4_q2_def.sml";

local
  fun recur_flatten (Br(a , Nil, Nil)) ans [] = a::ans
    | recur_flatten (Br(a, Nil, Nil)) ans (x::xs) = recur_flatten (x) (a::ans) xs
    | recur_flatten (Br(a, b, Nil)) ans queue = recur_flatten (b) (a::ans) (queue)
    | recur_flatten (Br(a, Nil, c)) ans queue = recur_flatten (c) (a::ans) (queue)
    | recur_flatten (Br(a, b, c)) ans queue = recur_flatten (b) (a::ans) (c :: queue)
in
  fun flatten (Br(a, Nil, Nil)) = [a]
    | flatten (Br(a, b, Nil)) = List.rev (recur_flatten (b) ([a]) ([]))
    | flatten (Br(a, Nil, c)) = List.rev (recur_flatten (c) ([a]) ([]))
    | flatten (Br(a,b,c)) = List.rev (recur_flatten (b) ([a]) ([c]))
end;


local
  datatype sons_complete = zero | one | two;
  datatype direction = left | right;
  fun build f (Br(a, Nil, Nil)) ((Br(l, m, n))::xans) (x::xs) (ss::ss2::sons) right = build f x ((Br(l, m, (Br((f a), Nil, Nil))))::xans) xs (two::sons) right
    | build f (Br(a, Nil, Nil)) ans (q::queue) (y::zero::ys) left = build f q ((Br((f a), Nil, Nil))::ans) queue (one::ys) right
    | build f (Br(a, Nil, Nil)) ans (q::queue) (y::one::ys) left = build f q ((Br((f a), Nil, Nil))::ans) queue (two::ys) right
      | build f (Br(a, Nil, Nil)) ans queue [zero] left = (Br((f a), Nil, Nil))

    | build f (Br(a, b, Nil)) ans queue (zero::sons) _ = build f b ans ((Br(a, b, Nil))::queue) (zero::one::sons) left
    | build f (Br(a, b, Nil)) (ans::xans) (q::queue) (two::zero::sons) _ = build f q ((Br((f a), ans, Nil))::xans) queue (one::sons) left
    | build f (Br(a, b, Nil)) (ans::(Br(l, m, n))::xans) (q::queue) (two::one::sons) _ = build f q ((Br(l, m, (Br((f a), ans, Nil))))::xans) queue (two::sons) left
    | build f (Br(a, b, Nil)) (t::ans) queue [two] _ = (Br((f a), t, Nil))
  
    | build f (Br(a, Nil, c)) ans queue (zero::sons) _ = build f c ((Br((f a), Nil, Nil))::ans) ((Br(a, Nil, c))::queue) (zero::one::sons) right
    | build f (Br(a, Nil, c)) ans (q::queue) (two::zero::sons) _ = build f q ans queue (one::sons) right
    | build f (Br(a, Nil, c)) (ans::(Br(l, m, n))::xans) (q::queue) (two::one::sons) _ = build f q ((Br(l, m, ans))::xans) queue (two::sons) right
    | build f (Br(a, Nil, c)) (ans::xans) queue [two] _ = ans
  
    | build f (Br(a, b, c)) ans queue (zero::ys) _ = build f b ans ((Br(a, b, c))::queue) (zero::zero::ys) left
    | build f (Br(a, b, c)) (ans::xans) queue (one::ys) _ = build f c ((Br((f a), ans, Nil))::xans) ((Br(a, b, c))::queue) (zero::one::ys) right
    | build f (Br(a, b, c)) ans (q::queue) (two::zero::ys) _ = build f q ans queue (one::ys) right
    | build f (Br(a, b, c)) (ans::(Br(l, m, n))::xans) (q::queue) (two::one::ys) _ = build f q ((Br(l, m, ans))::xans) queue (two::ys) right
    | build f (Br(a, b, c)) (t::xans) queue [two] _ = t
in 
  fun map f t = build f t ([]) ([]) ([zero]) left
end; 