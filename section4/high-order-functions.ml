let twice f x = f (f x)
let double x = x * 2 

let square x = x * x

let quad x = twice double x

(*pipeline*)

let pipeline x f = f x 
let (|>) = pipeline
let x = 5 |> double

(* compose *)
let compose f g x = f (g x)

let square_than_double = compose double square
let x = square_than_double 2

(*both *)

let both f g x = (f x, g x)
let ds = both double square
let p  = ds 3


(*cond*)
let cond p f g x = 
  if p x then f x else g x