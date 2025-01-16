let curry f x y = f (x, y)
let uncurry f (x, y) = f x y

let add x y = x + y 

let add_five = add 5 
let add' t = fst t + snd t

let uncurried_add = uncurry add
let curried_add = curry add'