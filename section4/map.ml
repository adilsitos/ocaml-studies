let rec map f = function 
  | [] -> [] 
  | h :: t -> f h :: map f t

let add1 = map (fun x -> x + 1) 

let concat_bang = map (fun x -> x ^ "!")


(*this implementation of map is slightly different than 
the one in List.map. The current one evaluates from right to left, so the values 
are returnerd in a reverse order. In some problems, there is no problem with this (like the 
add1 and concat_bang examples presented before), but if you want to print the elements 
  using this map, you need to change the evaluation order. *)

let p x = print_int x; print_newline(); x + 1

let lst = map p [1;2]

(*
  Explanation:
    Expression map p [1; 2] evaluates to p 1 :: map p [2].

    The right-hand side of that expression is then evaluated to p 1 :: (p 2 :: map p []). The application of p to 1 has not yet occurred.

    The right-hand side of :: is again evaluated next, yielding p 1 :: (p 2 :: []).

    Then p is applied to 2, and finally to 1.
*)

let rec map f = function
  | [] -> []
  | h :: t -> let h' = f h in h' :: map f t

(*the h' is evaluated first, causing 1 to be printed and h' to be bound to 2*)

(*tail recursion approach*)

let rec map_tr_aux f acc = function 
  | [] -> acc
  | h :: t -> map_tr_aux f (acc @ [f h]) t 

(*
  the results are append at the end of the execution, but this is linear time, and since 
  the traversal is also linear time, this approach takes n² complexity. A way to do this in 
  linear time we can  cons (::) at the acc, but this will result in a reversed list. 
*)

let rec map_tr_aux f acc = function 
  | [] -> acc
  | h :: t -> map_tr_aux f (f h :: acc) t

let map_tr f = map_tr_aux f []

(*If you want to have the result in the correct order you just need to invert the list,
which is a O(n) time complexity. It is ok to use the O n² approach if we don't have more than 10000 elements*)

