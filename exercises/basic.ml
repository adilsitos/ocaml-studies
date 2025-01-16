(* power of n  *)
let rec toNth v n count p = if count > n then p else toNth v n (count +. 1.) (v *. p);;

(* fibonnaci rec *)
let rec fib n = if n = 1 || n = 2 then 1 else fib(n - 1) + fib (n - 2)

(* fibonacci fast *)
let rec fib_fast_aux n count sum prev = if count >= n then sum else fib_fast_aux n (count + 1) (prev + sum) sum

let fib_fast n = fib_fast_aux n 2 1 1

(* valid day and month *)

let fun_date d m = match m with
| "Feb" -> 1 <= d && d <= 28 
| "Apr" | "Jun" | "Sep" | "Nov" -> 1 <= d && d <= 30 
| "Jan" | "Mar" | "May" | "Jul" | "Aug" | "Oct" | "Dec" -> 1 <= d && d <= 31
| _ -> false;;