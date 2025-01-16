
let rec repeat f n x = 
  match n with
| 0 -> x 
| _ -> repeat f (n-1) (f x) 

let rec repeat' f n x = 
  if n = 0 then x else repeat f (n-1) (f x)

let rec fold_left f acc lst = match lst with
| [] -> acc
| h :: t -> fold_left f (f acc h) t

let rec fold_right f lst acc = match lst with
| [] -> acc
| h :: t -> f h (fold_right f t acc) 

let product_left lst = fold_left ( *. ) 1. lst   

let product_right lst = fold_right ( *. ) lst 1.

(*terse product*)

let terse_product_left = List.fold_left ( *. ) 1.0
let terse_product_right = ListLabels.fold_right ~f:( *. ) ~init:1.0


(*sum cube odd*)

let odd n = n mod 2 <> 0

let rec (--) i j = if i > j then [] else i :: i+1 -- j

let sum_cube_odd n = 
  0 -- n
  |> List.filter odd 
  |> List.fold_left ( + ) 0 


let rec exists_rec p = function 
  | [] -> false 
  | h :: t -> p h || exists_rec p t 

let apply p x = p x

let exists_fold p lst = List.fold_left (fun acc elt -> acc || p elt) false lst

let exists_lib = List.exists 


let rec account_balance b lst = match lst with
| [] -> b
| h :: t -> account_balance (b -. h) t

let fold_left_account_balance b lst = List.fold_left (fun acc elt -> acc -. elt) b lst 

let fold_right_account_balance b lst = List.fold_right (fun elt acc -> acc -. elt ) lst b 

let uncurried_nth (lst, n) = List.nth lst n

let curry f x y = f (x,y)

let curried_nth x y = curry uncurried_nth x y

let uncurried_append (x, y) = List.append x y

let uncurried_compare (x,y)  = Char.compare x y

let uncurried_max (x, y) = Stdlib.max x y

let apply_map f g lst = List.map (f @@ g) lst 



(*Find those elements of a list of strings whose length is strictly greater than 3.*)
let length_bigg_3 lst = List.filter (fun el -> String.length el > 3) lst 

let add_1 lst = List.map (fun el -> el + 1) lst

let join_with strs sep = match strs with 
  | [] -> ""
  | h :: t ->  List.fold_left (fun combined s -> combined ^ sep ^ s) h t

let keys2 lst =
  List.fold_left
    (fun acc (k, _) -> if List.exists ((=) k) acc then acc else k::acc)
    []
    lst

(*the List.rev_map is to get the keys, since it gets the first element (which in 
this case is a key)*)
let keys3 lst = lst |> List.rev_map fst |> List.sort_uniq Stdlib.compare 

let is_valid_matrix mat = match mat with
| [] -> false 
| r :: rows -> 
  let m = List.length r in 
  m > 0 && List.for_all (fun r' -> m = List.length r') rows  

let add_row_vectors lst1 lst2 = 
  if List.length lst1 <> List.length lst2 then [] else 
    List.map2 (fun el1 el2 -> el1 + el2) lst1 lst2 

let matrix_add mat1 mat2 = List.map2 add_row_vectors mat1 mat2   

  

let transpose matrix = 
  let rec transpose_aux acc matrix = 
    match matrix with
    | [] :: _ -> List.rev acc
    | _ -> 
      let column = List.map List.hd matrix in 
      let rest = List.map List.tl matrix in 
      transpose_aux (column :: acc) rest
    in transpose_aux [] matrix
  
let dot = List.fold_left2 (fun acc el1 el2 -> (el1 * el2) + acc) 0


let matrix_multiplication m1 m2 = List.map (fun row -> List.map (dot row) (transpose m2)) m1