use "hw3_q2_def.sml";

  functor Kernel1D (kernel_module: KERNEL1D_SIG) = struct
    local
      fun inner_runKernel (x::y::z::zs) = [kernel_module.kernel x y z] @ (inner_runKernel ([y]@[z]@zs))
      | inner_runKernel (y::z::zs) = [kernel_module.kernel y z (kernel_module.default z)]
    in
      fun runKernel (x::xs)= inner_runKernel ([kernel_module.default x] @ [x]@xs)
    end;
 end;

exception SizeNotEqual;

fun zip nil nil nil = []
  | zip nil _ _ = (raise SizeNotEqual)
  | zip _ _ nil = (raise SizeNotEqual)
  | zip _ nil _ = (raise SizeNotEqual)
  | zip (x::xs) (y::ys) (z::zs) = [(x, y, z)] @ zip xs ys zs;

exception NegativeLength;

fun fill v 0 = []
  | fill v i = if (i < 0) then (raise NegativeLength) else [v] @ (fill v (i-1));

functor Kernel2D (kernel_module: KERNEL2D_SIG) = struct
  local
    structure zip_maker = Kernel1D(struct 
      type source = kernel_module.source list
      type target = (kernel_module.source * kernel_module.source * kernel_module.source) list
      val kernel = zip
      fun default (x::xs) = fill (kernel_module.default x) (List.length (x::xs))
     end)
    structure stage_2 = Kernel1D(struct
     type source = (kernel_module.source * kernel_module.source * kernel_module.source)
     type target = kernel_module.target
     val kernel = kernel_module.kernel
     fun default (a,b,c) = ((kernel_module.default (a)) , (kernel_module.default (a)) , (kernel_module.default (a)))
     end)
  in
    fun runKernel l = map stage_2.runKernel (zip_maker.runKernel l)
  end;
end;