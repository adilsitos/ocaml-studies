type ptype = TNormal | TFire | TWater 

type peff = ENormal | ENotVery | ESuper 


let mult_of_eff = function 
  | ENormal -> 1.
  | ENotVery -> 0.5
  | ESuper -> 2.0

let eff = function 
  | (TFire, TFire) | (TWater, TWater) | (TFire, TWater) -> ENotVery
  | (TWater, TFire) -> ESuper
  | _ -> ENormal

type mon = {
  name: string;
  hp : int;
  ptype: ptype;
  dmg: float;
}

let charmander = {
  name= "charmander";
  hp = 39;
  ptype = TFire;
  dmg = 10.;
}

let squirtle = {
  name= "squirtle";
  hp = 39;
  ptype = TWater;
  dmg = 10.;
}

(*monster 1 (m1) attacks monster 2 (m2)*)
let calc_dmg m1 m2 = 
    let mult = eff (m1.ptype, m2.ptype) 
  in
    m1.dmg *. mult_of_eff mult

