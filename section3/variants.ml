
(* a variant is like a enum in c *)

(* The individual names are called constructors. In this case they are: Sun, Mon, Tue ...*)
type day = Sun | Mon | Tue | Wen | Thu | Fri | Sat
let d = Tue


type primary_color = Red | Green | Blue

let r = Red

type point = float * float

(*variants that carry data*)
type shape =  
  | Point of point
  | Circle of point * float (*center and radius*)
  | Rect of point * point (*lower-left and upper-right corners *)


let area = function 
  | Point _ -> 0.0
  | Circle (_, r) -> Float.pi *. (r ** 2.0)
  | Rect ((x1, y1), (x2,y2)) -> 
    let w = x2 -. x1 in
    let h = y2 -. y1 in 
    w *. h

let center = function 
    | Point p -> p
    | Circle (p, _) -> p
    | Rect ((x1,y1), (x2, y2)) -> ((x2+.x1)/.2.0, (y2+.y1) /.2.0) 

type string_or_int = 
    | String of string
    | Int of int

type string_or_int_list = string_or_int list

let rec sum = function 
  | [] -> 0
  | String s :: t -> int_of_string s + sum t
  | Int i :: t -> i + sum t

let lst_sum = sum [String "1"; Int 2]