(*generics in go or maybe monad in haskell. It is a maybe type
  We need to be prepared for everything??

  option is a type constructor, like a list. Given a type, it produces a new type
  but it is not itself a type. 
*)

let extract o = 
  match o with
  | Some i -> string_of_int i
  | None -> ""

let rec list_max = function 
  | [] -> None;
  | h :: t -> begin
    match list_max t with
    | None -> Some h
    | Some m -> Some (max h m)
  end