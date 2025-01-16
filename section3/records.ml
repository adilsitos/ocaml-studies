type ptype = TNormal | TFire | TWater
type mon = {name: string; hp: int; ptype: ptype}

let c = {name= "Charmandar"; hp = 30; ptype = TFire};;

c.name

let a = match c with
| {name; hp;ptype} -> hp