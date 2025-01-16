(*simple variants*)
type day = Sun | Mon | Tue 

(* variants that carry data equals to algebraic data types *)
type point = float * float
type shape = 
  | Point of point
  | Circle of point * float (*center and radius*) 
  | Rect of point * point (* lower-left and upper-right corners*)

let area = function 
  | Point _ -> 0.0
  | Circle (_, r) -> Float.pi *. (r ** 2.0)
  | Rect ((x1, y1), (x2, y2)) -> 
    let w = x2 -. x1 in 
    let h = y2 -. y1 in 
    w *. h

let center = function 
    | Point p -> p 
    | Circle (p, _) -> p
    | Rect ((x1, y1), (x2, y2)) -> ((x2 +. x1) /. 2.0, (y2 +. y1) /. 2.0)

  
type string_or_int = 
  | String of string 
  | Int of int

type string_or_int_list = string_or_int list

let rec sum : string_or_int list -> int = function
  | [] -> 0
  | String s :: t -> int_of_string s + sum t
  | Int i :: t -> i + sum t
  
let lst_sum = sum [String "1"; Int 2]

(* recursive variants *)
type intlist = Nil | Cons of int * intlist

let lst3 = Cons (3, Nil)  (* similar to 3 :: [] or [3] *)
let lst123 = Cons(1, Cons(2, lst3)) (* similar to [1; 2; 3] *)

let rec sum (l : intlist) : int =
  match l with
  | Nil -> 0
  | Cons (h, t) -> h + sum t

let rec length : intlist -> int = function
  | Nil -> 0
  | Cons (_, t) -> 1 + length t

let empty : intlist -> bool = function
  | Nil -> true
  | Cons _ -> false

type node  = {value : int; next : mylist} 
and mylist = Nil | Node of node

(*Parameterized Variants*)

(*the previous intlist could be parameterized over any type *)

(*mylist here is a type constructor, but not a type*)

type 'a mylist = Nil | Cons of 'a * 'a mylist

let lst3 = Cons(3, Nil) (*[3]*)
let lst_hi = Cons("hi", Nil)

let rec length : 'a mylist -> int = function 
  | Nil -> 0
  | Cons (_, t) -> 1 + length t

let empty : 'a mylist -> bool = function 
  | Nil -> true
  | Cons _ -> false

(*
 these two functions are an exaple of a feature called parametric polymorphism
 But, as soon you place a constraint on what the type 'a might be, you give up 
 polymorphism. This happens with the sum function, which uses a ( + ) operator
with the head of the list constrains that head element must be an int

*)

let rec sum l  : int =
  match l with
  | Nil -> 0
  | Cons (h, t) -> h + sum t


(*
 polymorphic variants

 They are like variants, except:
 - You don't have to declate their type or constructors before using them
 - There is  no name for a polymorphic variant type
 - The constructor of a polymorphic variant start with a backquote character
*)

type 'a primite_list = [] | ( :: ) of 'a * 'a primite_list

let f = function 
  | 0 -> `Infinity
  | 1 -> `Finite 1
  | n -> `Finite (-n)
