(*
  steps to bubble sort
  - move the biggest element to n 
  - move the next biggest element to n-1
  - continue

*)


let rec sort lst = 
  let sorted = function
  |  h1 :: h2 :: t when h1 > h2 ->
    h2 :: sort (h1 :: t)
  | h1 :: t -> sort t
  | t -> t

  in 

  if  lst = sorted lst then
    lst
  else 
    sort (sorted lst)
