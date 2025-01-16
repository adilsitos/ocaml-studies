type pType = TNormal | TFire | TWater

type mon = {name : string; hp : int ; pType: pType}

let get_hp m = m.hp

let fst (a, _) = a 
let sec(_, b) = b

let thrd (_, _ , c) = c