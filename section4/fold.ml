(*combines several elements from a list*)

let rec sum = function
  | [] -> 0
  | h :: t -> h + sum t

let rec concat = function 
  | [] -> ""
  | h :: t -> h ^ concat t


(*abstracting function, factoring out two arguments*)

let rec combine op init = function 
  | [] -> init 
  | h :: t -> op h (combine op init t)

let sum = combine ( + ) 0
let concat = combine ( ^ ) ""

let rec combine' f acc lst = match lst with 
  | [] -> acc 
  | h :: t -> f h (combine' f acc t)

let sum lst = combine' ( + ) 0 lst
let concat lst = combine' ( ^ ) "" lst

let rec fold_right f acc lst = match lst with 
  | [] -> acc 
  | h :: t -> f h (fold_right f acc t)

(* 
  Why fold right? because it folds in elements from right to left, combining
  each new element using the operator.
*)


(*tail recursion*)

let rec combine_tr f acc = function 
  | [] -> acc
  | h :: t -> combine_tr f (f acc h) t

(*if we compare combine with combine_tr (tail recursive approach) we can notice 
  that the elements on the tr are processed in reverse.*)

(*
  With combine we compute 3 - (2 - (1 - 0)). First we fold in 1, then 2, then 3. We are processing the list from right to left, putting the initial accumulator at the far right.
  But with combine_tr we compute (((0 - 3) - 2) - 1). We are processing the list from left to right, putting the initial accumulator at the far left.
*)

(*combine_tr can be called as List.fold_left on the std lib*)
let rec fold_left f acc = function
  | [] -> acc
  | h :: t  -> fold_left f (f acc h) t


let length lst = List.fold_left (fun acc _ -> acc + 1 ) 0 lst

let rev lst = List.fold_left (fun acc x -> x :: acc ) [] lst

let map f lst = 
  List.fold_right (fun x acc -> f x :: acc) lst []

let filter f lst =
  List.fold_right (fun x acc -> if f x then x :: acc else acc) lst []


(*functionals like map and fold can also be applied into other data structures*)

type 'a tree = 
  | Leaf
  | Node of 'a * 'a tree * 'a tree


let rec map_tree f = function 
  | Leaf -> Leaf
  | Node (v, l, r) -> Node (f v, map_tree f l, map_tree f r)

let rec fold_tree f acc = function 
  | Leaf -> acc
  | Node (v, l, r) -> f v (fold_tree f acc l) (fold_tree f acc r)

let size t = fold_tree (fun _ l r -> 1 + l + r) 0 t
let depth t = fold_tree (fun _ l r -> 1 + max l r) 0 t
let preorder t = fold_tree (fun x l r -> [x] @ l @ r) [] t

(*
The technique we used to derive fold_tree works for any OCaml variant type t:

    Write a recursive fold function that takes in one argument for each constructor of t.

    That fold function matches against the constructors, calling itself recursively on any value of type t that it encounters.

    Use the appropriate argument of fold to combine the results of all recursive calls as well as all data not of type t at each constructor.

This technique constructs something called a catamorphism, aka a generalized fold operation. To learn more about catamorphisms, take a course on category theory.

*)

let rec filter_tree p = function 
  | Leaf -> Leaf
  | Node (v, l, r) -> 
    if p v then Node (v, filter_tree p l, filter_tree p r) else Leaf
