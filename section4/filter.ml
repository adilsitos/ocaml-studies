(*problem: get only the even numbers from a list*)

let even n = n mod 2 = 0

let odd n = n mod 2 <> 0

let rec evens = function 
  | [] -> []
  | h :: t -> if even h then h :: evens t else evens t

let lst1 = evens [1; 2; 3; 4]

let rec filter p = function  
  | [] -> []
  | h :: t -> if p h then h :: filter p t else filter p t

let evens = filter even
let odds = filter odd

(*tail recursion approach*)

let rec filter_tr_aux p acc = function 
  | [] -> acc
  | h :: t -> if p h then filter_tr_aux p (h::acc) t else filter_tr_aux p acc t

let filter_tr p= 
  filter_tr_aux p [] 

(*The previous one outputs the list in a reverse order*)
let rec filter_tr_aux p acc = function 
  | [] -> List.rev acc (*built in traversal*)
  | h :: t -> if p h then filter_tr_aux p (h::acc) t else filter_tr_aux p acc t
  