

## Lists 
A list is a sequence of values which all have the same type. They are
implemented as a linked list. 
- cons (::) preprend a value to a list. (constant time)
- fst element is called head, the rest of the elements are called tail
- :: is right associative, meaning that -> e1 :: e2 :: e3 is equal to
    e1 :: (e2 :: e3)
- a list is not itself a type, it is a type constructor. When it receives
a type it can create a list of that type, for example an int list.

### Acessing lists
    Pattern matching

    let rec sum lst =
        match lst with 
        | [] -> 0 
        | h :: t -> h + sum t

    let length lst = 
        match lst with 
        | [] -> 0
        | _ :: t -> 1 + length t
    
    // this will append one list into another list
    // this function is also available with the @ operator
    // linear time
    let append lst1 lst2 = 
        match lst1 with 
        | [] -> lst2
        | h :: t -> h :: append t lst2

    let empty lst = 
        lst = []

## Recursive functions and proofs
Note how all the recursive functions above are similar to doing proofs by induction on the natural numbers: every natural number is either 0 or is 1 greater than some other natural number
, and so a proof by induction has a base case for 0 and an inductive case for
. Likewise, all our functions have a base case for the empty list and a recursive case for the list that has one more element than another list. This similarity is no accident. 

## (Not) mutating lists
Lists are immutable, so ocaml programmers create new list out of old lists. 

### A memory "problem"
Imagine you have a function that receives a list and increments the first element

    let inc lst = 
        match lst with 
        | [] -> []
        | h :: t -> h + 1 :: t
    
    What happens under the hood? Does the compiler creates another list with the first 
    value increased, or just share the tail list t between the old list and the new list, such that the amount of memory does not increase? The answer is the latter, 
    and this is because lists are immutable, so it is safe for the compilter to share the same memory. And since lists are implemented as a linked list, the new incremented value can just point to the the tail list.

## Pattern matching 
```
match e with
| p1 -> e1
| p2 -> e2
| ...
| pn -> en
```
Each clause pi -> e1 is called a branch or a case. 
The patterns may be:
- a variable name
- the underscore character, called the wildcard.
- The empty list [] 
- p1 :: p2 
- [p1; ...; pn]

In addition to that type-checking rule, there are two other checks the compiler does for each match expression.

First, exhaustiveness: the compiler checks to make sure that there are enough patterns to guarantee that at least one of them matches the expression e, no matter what the value of that expression is at run time. This ensures that the programmer did not forget any branches.

Second, unused branches: the compiler checks to see whether any of the branches could never be matched against because one of the previous branches is guaranteed to succeed

## Deep pattern matching 
Patterns can be nested. Doing so can allow your code to look deeply into the structure of a list. For example:

    _ :: [] matches all lists with exactly one element

    _ :: _ matches all lists with at least one element

    _ :: _ :: [] matches all lists with exactly two elements

    _ :: _ :: _ :: _ matches all lists with at least three elements

## Variants

Variant is a data type representing a value that is one of several possibilities

```
let day = Sun | Mon | Tue | Wen | Thu | Fri | Sat
let d = Tue 
```

Variants can be accessed using pattern matching 

```
    let int_of_day d = 
        match d with 
            | Sun -> 1
            | Mon -> 2
            | Tue -> 3
            | Wed -> 4
            | Thu -> 5
            | Fri -> 6
            | Sat -> 7

```

Defining a variant type
syntax: `type t = C1 | ... | Cn`

The constructor must begin with an uppercase letter

Scope:
If we have a cenario where exists and overlapping constructor names like this:

```
    type t1 = C | D
    type t2 = D | E
    let x = D
```

Which one will be refered? The last one (t2)
It is idiomatic to whenever overlapping constructor names might occur to 
prefix them with some distinguish character.

## Records 
Records is a composiste of other datatypes; they are structs 

```
type ptype = TNormal | TFire | TWater
type mon = {name : string; hp : int; ptype : ptype}

let c = {name= "Charmandar"; hp = 30; ptype = TFire};;

c.name

let a = match c with
| {name; hp;ptype} -> hp

```

to access a record you can use a dot notation (c.name) or use a pattern matching 

It is also possible to construct a new record out of an old record:

`{e with f1 = e1; ...; fn = en}`

this does not mutate the old record, rather, it constructs a new record with new values.

## Tuples
Composition of other data types, but they are not identified by names, they are
identified by position.

```
(1,2,10)
(true, "hello")
```

Acessing a tuple can also be done by pattern matching

```
match(1,2,3) with (x,y,z) -> x + y + z
```

Tuples are written using a new type constructor, the *

## Variants vs Records vs Tuples
The big difference between variants and the types we just learned (records and tuples) is that a value of a variant type is one of a set of possibilities, whereas a value of a tuple or record type provides each of a set of possibilities. Going back to our examples, a value of type day is one of Sun or Mon or etc. But a value of type mon provides each of a string and an int and ptype. Note how, in those previous two sentences, the word “or” is associated with variant types, and the word “and” is associated with tuple and record types. That’s a good clue if you’re ever trying to decide whether you want to use a variant, or a tuple or record: if you need one piece of data or another, you want a variant; if you need one piece of data and another, you want a tuple or record.

## Algebraic data types 

Records and tuples -> each-of types (cartesian product)
Variants -> one of types (disjoint union)

Exploring more about variants

// tagged union
type string_or_int = 
    | String of string
    | Int of int

Variants get us heterogeneous lists (it is not just an union)

Get the example about blue or pink ints

type blue_or_pink_int = 
    | Blue of int 
    | Pink of int 

It is possible to known where the value come from (we can 
differ if an int comes from the blue or pink variant)

Variants are also known as algebraic data types

## Advanced pattern matching
check the mons.ml file

## Type synonyms
A type synonym is a new name for an already existing type

```
    type point = float * float
    type vector = float list
    type matrix = float list list
```

Anywhere float * float is used can be exchanged by point, and vice-versa
Type synonyms are useful because they let us give descriptive names to complex types.

## Options 
Options can be think as a closed box. Maybe there is something inside, or maybe not. 
We don't known until we open the box. If there is something inside the box, we can use 
it. 

here it is how to create a value that has something inside: Some 42
And here is the box withou a value: None

for any type t is is possible to write `t option` as a type. But `option` alone is not 
a type. Values of type `t option` might contain a value of type `t`, or they might 
contain nothing. 

It is possible to pattern match an option. Here is a funtion that extracts an int 
from an option and converts it to a string:

```

    let extract o =
        match o with 
        | Some i -> string_of_int i 
        | None -> ""

```


The example of function that receives a list of elements and check which is the 
max value is a good one to understand about options. 

```

    let rec list_max = function 
    | [] -> ????
    | h :: t -> max h (list_max t)

```

If the list is empty, what should be returned? This problem can be solved 
using options!!!

```

    let rec list_max = function 
        | [] -> None
        | h :: t -> begin 
            match list_max t with 
                | None -> Some h
                | Some m -> Some (max h m)

        end

```

## Association lists

An easy way to implement a map. 
It is made of a list of pairs (it just uses two types: lists and pairs xD)

```
    let insert k v lst = (k, v) :: lst

    let rec lookup k = function 
        | [] -> None
        | (k', v) :: t -> if k = k' then Some v else lookup k t 

```

The lookup runtime is O(n) and the insert is O(1)

Association lists are a very easy and useful implementation for small dictionaries

## Algebraic data types 

Variants are far more powerful than just enumerating a set of constants

Variant types are sometimes called tagged unions. Every value of the type is from the set of values that is the union of all values from the underlying types that the constructor carries. For example, with the shape type, every value is tagged with either Point or Circle or Rect and carries a value from:

    the set of all point values, unioned with

    the set of all point * float values, unioned with

    the set of all point * point values.

Another name for these variant types is an algebraic data type. “Algebra” here refers to the fact that variant types contain both sum and product types.


Variants thus provide a type-safe way of doing something that might before have seemed impossible. (check the file variants.ml, there exists an example of the sum of a list that can contain string and int)

Do not use catch-all cases against variants, it can lead to bugs. It is always better
to make the patterns against the values that exist inside the variant

```

type color = Blue | Red 

let string_of_color = function 
    | Blue -> "blue"
    | _ -> "red" <---- DO NOT DO THIS!!!
``` 


### Recursive Variants 
Variants type may mention their own name inside their own body. Like the following 
example: 

```

type intlist = Nil | Cons of int * intlist

let lst3 = Cons(3, Nil)
let lst123  = Cons(1, Cons(2, lst3))

```

The Cons constructor carry a value that contains an intlist.
Types may be mutually recursive if you use the `and` keyword

```

type node = {value: int;  next: mylist} 
and mylist = Nil | Node of node

```

Any such mutual recursion must involve at least one variant or record type that 
the recursion "goes through"

Record types may also be recursive:

```

type node = {value: int; next: node}

```

### Parametrized Variants 

Variant types may be parametrized on other types. Eg., the intlist 
can generalized to privide lists over any type

```

type 'a mylist = Nil | Cons of 'a * 'a mylist

let lst3 = Cons(3, Nil)
let lst_hi = Cons("hi", Nil)

```

here the my list is a type constructor, not a type. Type constructors are 
like funtions, but they map types to types instead of values to values. 

Some functions that can be created over `'a mylist`

```

let rec length = function 
    | Nil -> 0
    | Cons (_, t) -> 1 + length t

let empty = function 
    | Nil -> true
    | Cons _ -> false // here we could use a wildcard (_) but this can break the code
                      // so I decided to map the cons pattern to false.
```

These functions are an example of a feature called parametric polymorphism. 
The function doesn't care about the type `'a`
But if you place a constraint on what type `'a` is, some polymorphism is gone.

For example:

```
    let rec sum = function 
        | Nil -> 0
        | Cons (h, t) -> h + sum t // the + operator expects an int, so the compiler
```

It is also possible to have multiple type parameters for a parametrized type

```
type ('a, 'b) pair = {first: 'a; second: 'b}
let x = {first=1; second="hi"}

```


### Polymorphic variants
They are like variants, except:
    - It is not necessary to declare their type or constructors before using them
    - There is no name (can also be called as anonymous variants)
    - It starts with a backquote character

Example:

```
    let f = function
        | 0 -> `Infinity
        | 1 -> `Finite 1
        | n -> `Finite (-n)

```


### Built-in Variants

a list is defined as a variant:

```
    type 'a list = [] | ( :: ) of 'a * 'a list
```

an option is also defined as a parameterized variant:

```
    type 'a option = None | Some of 'a
```

## Exceptions
To create an exception, use the same syntax for creating a variant value
To raise an exception -> `raise e` 

to catch exceptions ->

```
    try e with 
    | p1 -> e1
    | pn -> en
```

if e raises an exception, it will match against all provided patterns. If not, it 
will just return e 

The language specification does not stipulate what order the components of pairs should be evaluated in, so in the case of `(raise A, raise B)` the ocaml compilter evaluates from right to left, so B will be raise first. 

In general if there are both exception and non-exception patterns, evaluation proceeds as follows: try evaluating e. If it produces an exception packet, use the exception patterns from the original match expression to handle that packet. If it doesn’t produce an exception packet but instead produces a non-exception value, use the non-exception patterns from the original match expression to match that value.

```
try 
  match e with
    | p1 -> e1
    | p3 -> e3
with
  | p2 -> e2
  | p4 -> e4
```