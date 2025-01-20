let rec product lst = 
  match lst with
  | [] -> 1
  | h :: t -> h * product t  

let rec concat_str lst = 
  match lst with
  | [] -> ""
  | h :: t -> h ^ concat_str t


let check_fst_elem lst = 
  match lst with
  | h -> if h = "bigred" then true else false

let rec two_or_four_aux lst size = 
  match lst with
    | [] -> size
    | h :: t -> two_or_four_aux t (size + 1)
  
let two_or_four lst =
  let size = two_or_four_aux lst 0
in 
size = 2 || size = 4 


let two_first_elem_equal lst = 
  match lst with
  | [] -> false
  | h :: h2 :: t -> h = h2 
  | _ -> false

let lst = [1; 3; 4; 5];;

List.length(lst)

let get_fifth lst =
  if List.length lst < 5 then 0 else List.nth lst 4

let sort_list_rev lst =
  List.rev (List.sort Stdlib.compare lst)

let last_elem lst = 
  List.nth lst ((List.length lst) - 1)   

let is_zero a = if a = 0 then true else false

let any_zeros lst = 
  List.exists is_zero lst 

let rec take_aux n idx lst lst_aux = 
  match lst with 
  | [] -> []
  | h :: t -> if idx = n - 1 then lst_aux else take_aux n (idx + 1) t (h :: lst_aux)    

let take n lst = 
  take_aux n 0 lst [] |> List.rev

let rec drop_aux n idx lst lst_aux = 
  match lst with
  | [] -> []
  | h :: t -> if idx > n - 1 then take_aux n (idx + 1) t (h :: lst_aux) else take_aux n (idx+1) t lst_aux

let drop n lst = 
    drop_aux n 0 lst [] |> List.rev

let rec drop_opt n lst = 
  if n = 0 then lst else match lst with
  | [] -> []
  | _ :: t -> drop_opt (n - 1) t
  

let rec is_dec = function
  | [] | [_] -> true 
  | h1 :: (h2 :: t2 as t) -> h1 >= h2 && is_dec t 

let rec is_inc_dec = function 
  | [] | [_] -> true
  | h1 :: (h2 :: t2 as t) as lst -> if h1 <= h2 then is_inc_dec t else is_dec lst   

let is_unimodal lst =
  is_inc_dec lst

(*
  powerset: create all subesets that are inside a set
  so, in the set: [1; 2; 3] all possible sets are
  [[1;2;3]; [1;2]; [2;3]; [1;3]; []]
*)

let rec powerset lst =
  match lst with
  | [] -> [ [] ]
  | h :: t -> let p = powerset t in 
  List.map (List.cons h) p @ p

let rec print_int_list = function 
  | [] -> ()
  | h :: t -> print_endline (string_of_int h); print_int_list t 
let print_int_list' lst = 
  List.iter (fun x -> print_endline (string_of_int x)) lst

type student = {first_name : string; last_name : string; gpa : float}

let get_full_name student = 
  student.first_name, student.last_name

let new_student first_name last_name gpa =
  {first_name; last_name; gpa}

type poketype = Normal | Fire | Water

type pokemon = {name: string; hp: int; ptype: poketype}

let charizard = {name ="charizard"; hp = 78;  ptype = Fire }

let safe_hd lst = 
  match lst with
  | [] -> None 
  | h :: t -> Some h

let safe_tl lst = 
  match lst with
  | [] -> None
  | _ :: t -> Some t

let rec max_hp poke_lst  = 
  match poke_lst with
  | [] -> None
  | poke1 :: t -> begin 
    match max_hp t with
    | None -> Some poke1
    | Some poke2 -> Some (if poke1.hp >= poke2.hp then poke1 else poke2)
  end 

type date = int * int * int

let validate_date date =
  let (_, m, d) = date in
   match m with
| 2 -> 1 <= d && d <= 28 
| 4 | 6 | 9 | 11 -> 1 <= d && d <= 30 
| 1 | 3 | 5 | 7 | 8 | 10 | 12 -> 1 <= d && d <= 31
| _ -> false;;
 
(*TODO: refactor to raise an exception on the validation step*)
let is_before date1 date2 = 
  let valid1 = validate_date date1 in
  let valid2 = validate_date date2
in 
  if not valid1 || not valid2 then false else  
    let (y1, m1, d1) = date1 in
    let (y2, m2, d2) = date2 in 
    y1 < y2 || y1 == y2 && m1 < m2 || y1 == y2 && m1 < m2 && d1 < d2 

   
let rec earliest lst = 
  match lst with
  | [] -> None
  | date1 :: t -> begin 
    match earliest t with
    | None -> Some date1
    | Some date2 -> Some(if is_before date1 date2 then date1 else date2) 
  end



let insert k v lst = (k, v) :: lst

let rec lookup k v lst = 
  match lst with
  | [] -> None
  | (k', v') :: t -> if k' = k then Some v' else lookup k v t 


type quad = I | II | III | IV
type sign = Neg | Zero | Pos 

let sign (x: int) : sign =
  if x < 0 then Neg 
  else if x > 0 then Pos else Zero 

let quadrant : int*int -> quad option = fun (x,y) ->
  match sign x, sign y with
    | Pos, Pos -> Some I
    | Neg, Pos -> Some II
    | Neg, Neg -> Some III
    | Pos, Neg -> Some IV
    | _ -> None

let quadrant_when : int * int -> quad option = function 
  | x, y  when x > 0 && y > 0 -> Some I
  | x, y when x < 0 && y > 0 -> Some II 
  | x, y when x < 0 && y < 0 -> Some III
  | x, y when x > 0 && y < 0  -> Some IV
  | _ -> None

type 'a tree = 
  | Leaf 
  | Node of 'a * 'a tree * 'a tree

let rec depth tree = 
  match tree with
  | Leaf -> 0
  | Node(_, left, right) -> 1 + max (depth left) (depth right)  

let rec shape tree1 tree2 = 
  match tree1, tree2 with
  | Leaf, Leaf -> true
  | Node(_, left1, right1), Node(_, left2, right2) -> (shape left1 left2) && (shape right1 right2)    
  | _ -> false

  
let rec list_max_safe x = function
  | [] -> x
  | h :: t -> list_max_safe (Stdlib.max x h) t


let list_max_exn lst = 
  match lst with
  | [] -> failwith "list_max"
  | h :: t -> list_max_safe h t

let list_max_string lst = 
  try string_of_int (list_max_exn lst) with 
  | Failure _ -> "emtpy"


type tree = 
  | Leaf
  | Node of int * tree * tree

type binary_val = 
  | Empty 
  | NotBST
  | BST

  let rec get_min tree min_value = 
    match tree with
    | Leaf -> min_value
    | Node(value, left, right) -> 
      let new_min = min value min_value in 
      min (get_min left new_min) (get_min right new_min)
    
  let rec get_max tree max_value = 
    match tree with
    | Leaf -> max_value
    | Node(value, left, right) -> 
      let new_max = max value max_value in 
      max (get_max left new_max) (get_max right new_max)

  let bst_helper tree = 
    match tree with
    | Leaf -> Empty 
    | Node(value, left, right) -> 
      let left_max = get_max left min_int in 
      let right_min = get_min right max_int in 
      if left_max > value || right_min < value then
        NotBST
      else 
        BST
    
    let is_bst tree = 
      let res = bst_helper tree in 
      match res with
      | Empty -> false 
      | NotBST -> false
      | BST -> true
