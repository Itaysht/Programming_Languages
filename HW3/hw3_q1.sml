use "hw3_q1_def.sml";
fun mapState f state = map (fn l => map f l) state;
fun toString l = foldr op^ "" (map str l);
fun frameToState frame = map (fn s => map (fn #"*" => true | #" " => false) (explode s)) frame;
fun stateToFrame state = map toString (mapState (fn true => #"*" | false => #" ") state);
fun printFrame frame = print (foldr op^ "" (map (fn s => s^"\n") frame));