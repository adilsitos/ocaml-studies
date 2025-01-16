## Introduction

### Why immutability is a good thing?

In computer programs we usually think that a function will always return the same result, but this is not true in real life. If you think about mathematics, a function 
f(x) = y will always return the same result, and it is possible to change any value of 
y for f(x). But in mutable languages this isn't true, because the value of f(x) can change over time, so y will have a result at time t, and another result at time t'. 

## How to learn a new language? 
5 key components

- semantics 
- syntax
- idioms
- libraries
- tools 

## What is a pure function? 
a pure function is a function that always return the same result.

#### Ocaml apply functions instead of call it

### Every OCaml function takes exactly one argument.
A function like:
    fun x y -> e
    is a syntatic sugar gor 
    fun x -> (fun y -> e)

This is only possible because functions are values. 

Funtions are first class citizens

## Polymorphic functions
The identity function:
    let id x = x;;

This id function can be applied to several types of values, it is a polymorphic function. It is possible  to give a more restrictive type to a polymorphic function, for example:

let id_int (x: int) : int = x;;


## Labeled function
To create a function that support labeled arguments to functions we need to 
define the function with a `~name` argument, like this:

let f ~name1:arg1 ~name2:arg2 = arg1 + arg2;;

and call it like this:

f ~name2:3 ~name1:4

It is also possible to set a default value to an argument

let f ?name:(arg1=8) arg2 = arg1 + arg2;;

and call it like this: 

f 7

## Partial applications
It is possible to partially apply a function, because of the property
that every function takes exactly one argument. So it is possible to define a function 
like: 
    let add x y = x + y;;
and partially apply it;
    let add2 = add 2;;
so add2 can be called like this:
    add2 5;;


## creating a new infix
let ( ^^ ) x y = max x y

and now 2 ^^ 3 evaluates to -> 3 

## Createa a topic about tail recursion, with several examples.

## Pipeline operator
It does a reverse application, it receives a value and then applies a function on that 
value. It is defined by this operator |>

5 |> inc |> square;;


## physicial equality
e1 == e2 tests for physical equality of e1 and e2. On mutable types such as references, arrays, byte sequences, records with mutable fields and objects with mutable instance variables, e1 == e2 is true if and only if physical modification of e1 also affects e2. 