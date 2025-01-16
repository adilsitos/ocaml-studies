let d = [("test", 1); ("val", 2)]

let insert k v lst = (k, v) :: lst

let rec lookup k = function
  | [] -> None
  | (k', v') :: t -> if k = k' then Some v' else lookup k t