module MyStack = struct 
  type 'a stack = 
    | Empty 
    | Entry of 'a * 'a stack
  
  let empty = Empty
  
  let push x s = 
    Entry (x, s)
  
  let peek = function 
    | Empty -> failwith "Empty"
    | Entry (x, _) -> x
  
    let pop = function
    | Empty -> failwith "Empty"
    | Entry (_, s) -> s
end 

module ListStack = struct 
  type 'a stack = 'a list

  let empty = []

  let push x s = 
    x :: s

  let peek = function 
    | [] -> failwith "Empty"
    | x :: _ -> x

  let pop = function
  | [] -> failwith "Empty"
  | _ :: s -> s
end

let s = MyStack.empty

(* s is unchanged*)
let s' = MyStack.push 1 s


let lst = ListStack.peek (ListStack.push 42 ListStack.empty)

let lst' = ListStack.(peek (push 42 empty))

let lst2 = ListStack.(empty |> push 42 |> peek)

let w = 
    let open ListStack in 
    empty |> push 42 |> peek
