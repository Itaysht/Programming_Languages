use "hw4_q1_def.sml";

local 
	structure IsAliveKernel = Kernel2D(struct
			type source = bool
			type target = bool
            fun kernel x y z = is_alive_bool x y z
            fun default _ = false
		end);
in 
	fun runCycle frame = stateToFrame (IsAliveKernel.runKernel (frameToState frame))
end;
    

fun gameOfLife frame = let
	val f = ref frame
in
	fn () => (printFrame((!f)) ; (f := (runCycle (!f))))
end;
