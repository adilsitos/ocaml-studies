module type Fact = sig 
  val fact : int -> int
end

module RecursiveFact : Fact = struct
  let rec fact n = 
    if n = 0 then 1 else 
      n * fact (n -1) 
end

(* 
module NoFact : Fact = struct
  let inc x = x + 1


end *)

module TailRecursiveFact : Fact = struct 
  let rec fact_aux n acc = 
    if n = 0 then acc else 
      fact_aux (n - 1) (n * acc)

  let fact n =
    fact_aux n 1

end
let x = TailRecursiveFact.fact 10

(*interfaces only provide the functions defined in them*)
(* let y = TailRecursiveFact.fact_aux 10 *)