use "hw4_q3_def.sml";

type 'a our_memoizer = {memory: (int * 'a) list ref};

datatype 'a biseq = Nili | Const of (('a seq) our_memoizer)*(int)*(int)*('a seq);
exception SeqErr;

fun new Nil = Nili
  | new (Cons(x, xf)) = Const({memory = ref [(0, (Cons(x, xf)))]}, 0, 0, (Cons(x, xf)));

fun curr Nili = (raise SeqErr)
  | curr (Const((memo: (('a seq) our_memoizer)), i, j, (Cons(x, xf)))) = (case (List.find (fn t => i = (#1 (t))) (!(#memory memo))) of
    SOME (_, Nil) => (raise SeqErr)
  | SOME (_, Cons(y, yf)) => y
  | NONE => (raise SeqErr))

fun empty Nili = true
  | empty (Const(ls, i, j, sq)) = if (i <= j) then false else true;

fun memoizer_put (memo: (('a seq) our_memoizer)) x y =
    let
      val state = #memory(memo)
    in
      state :=
                (!state) @ [(x, y)]
 end;

fun next Nili = raise SeqErr
  | next (Const((memo: (('a seq) our_memoizer)), i, j, Cons(x, xf)))=
    case (List.find (fn t => (i+1) = #1 t) (!(#memory memo))) of
            SOME (_, y) => (Const((memo: (('a seq) our_memoizer)), (i+1), j, Cons(x, xf)))
          | NONE => (
    let 
      val ans = case (List.find (fn t => i = #1 t) (!(#memory memo))) of
            SOME (_, Cons(z, zf)) => zf()
          | NONE => xf()
    in
    memoizer_put memo (i+1) ans; (case ans of 
      Nil => (Const((memo: (('a seq) our_memoizer)), (i+1), j, Cons(x, xf))) 
      | _ => (Const((memo: (('a seq) our_memoizer)), (i+1), (j+1), Cons(x, xf))))
 end);

fun prev Nili = raise SeqErr
  | prev (Const(ls, 0, j, t)) = raise SeqErr
  | prev (Const(ls, i, j, t)) = (Const(ls, (i-1), j, t));