let x = 
    match not true with 
    | true -> "nopp"
    | false -> "yep"
let a = 
  match [] with
  | [] -> "emtpy" 
  | _ -> "not empty"


let b = 
  match ["taylor"; "swift"] with
  | [] -> "test"
  | h :: t -> h

(* t is not the tail, but it's actually the rest of the list*)
(* let c = 
  match ["taylor"; "swift"] with
  | [] -> "test"
  | h :: t -> t *)

let rec last_elem lst =  
  match lst with
  | [] -> "empty"
  | [a] -> a
  | h :: t -> last_elem t


let empty lst = 
  match lst with 
  | [] ->  true 
  | h :: t -> false

let empty lst = 
  match lst with 
  | [] ->  true 
  | _ -> false


let rec sum lst = 
  match lst with 
  | [] -> 0 
  | h :: t -> h + sum t


let rec length lst =
  match lst with
  | [] -> 0
  | h :: t -> 1 + length t

let rec length lst =
  match lst with
  | [] -> 0
  | _ :: t -> 1 + length t

(* example usage:
   append [1; 2; 3] [4; 5; 6] is [1;2;3;4;5;6]
  This functions is the same to use the @ operator*)
let rec append lst1 lst2 = 
  match lst1 with
  | [] -> lst2 
  | h :: t -> h :: append t lst2

(*

  :: "cons" add an element into the head of the list. constant time

  @ "append" combine two lists. linear time; it needs to go over all the elements
  of the first lis

  lists are  immutable, so to create new lists you need to create new lists out of
  old ones. 

*)

(*
Note how all the recursive functions above are similar to doing proofs by induction on the natural numbers: every natural number is either 0 or is 1 greater than some other natural number
, and so a proof by induction has a base case for 0 and an inductive case for
. Likewise, all our functions have a base case for the empty list and a recursive case for the list that has one more element than another list. This similarity is no accident. There is a deep relationship between induction and recursion; we’ll explore that relationship in more detail later in the book.
*)


(* increment the first element of a list*)

(*since lists are immutable the main idea here is to create a new list with just
  one element, in this case this is h (head of the list) and point to the later list 
  t (t is the rest of the list). This way, ocaml does not need to allocate a new memory
  for this "new" list. 
*)

let inc_first lst = 
  match lst with
  | [] -> []
  | h :: t -> h + 1 :: t

let rec sum = function
  | [] -> 0
  | h :: t -> h + sum t

let rec sum_acc acc lst = 
  match lst with
  | [] -> acc
  | h :: t -> sum_acc (h + acc) t 

let sum_tr : int list -> int = 
  sum_acc 0


(* the following function creates a list containing all values between them*)

let rec from i j l = if i > j then l else from i (j - 1) (j :: l)  

let (--) i j = from i j []

let long_list = 0 -- 1_000_000