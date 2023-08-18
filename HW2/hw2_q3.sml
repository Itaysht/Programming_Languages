datatype cell = empty | alive;

fun is_alive (row1:cell*cell*cell) (row2:cell*cell*cell) (row3:cell*cell*cell) = let
    val neighbors = [#1row1, #2row1, #3row1,  #1row2, #3row2, #1row3, #2row3, #3row3];
    val alive_cells = List.filter (fn x => x=alive) neighbors;
    val neighbors_alive_count = length alive_cells
in 
     if #2row2 = alive then 
        if neighbors_alive_count = 2 then 
          alive 
        else 
          if neighbors_alive_count = 3 then 
            alive 
          else 
            empty 
    else 
      if neighbors_alive_count = 3 then 
        alive 
      else 
        empty
end;