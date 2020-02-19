It begins
=========

This exercise sheet is all about higher order functions (functions that
take functions as a parameter), the most important ones that you will
get to understand are `map, filter, foldr, foldl`, and along with them
you will sometimes have to use lambda functions. At the time of writing,
there are no exercises explicitly for practicing lambdas.

Map
---

`map` is often used in conjunction with a function that makes some
transformation on an element. Use `map` to solve the following
exercises. When a helper function is needed, you can write a function
like normal or use a lambda function.

-   Get a list of square roots, from a list of numbers.
-   Get a list of lengths, from a list of strings.
-   Add your favorite number to a list of numbers.
-   Double the numbers in a list unless they exceed some threshold.
-   Given a list, make a list of lists (each element is its own list).
-   Using `fizzbuzz` from the second exercise sheet (if you made it),
    make a list of the first few (e.g. 20) \"numbers\" in FizzBuzz.

Filter
------

Remember that `filter` keeps the elements that match the predicate,
rather than exclude them. Use `filter` to solve the following exercises.

-   Get a list of numbers below some threshold, from a list of numbers.
-   Come up with your own function that returns a bool and use it with
    `filter`.
-   Recreate quicksort.
-   Make a function that given a number finds all the positive integers
    that are a factor of it (evenly divides it).
    -   Use it to make a naïve `isPrime` function.

Fold
----

To better understand what `foldr` and `foldl` does, try expanding the
following expressions by hand, according to the pseudo definitions:

`` foldr f z [x1, x2, ..., xn] == x1 `f` (x2 `f` ... (xn `f` z)...) ``

`` foldl f z [x1, x2, ..., xn] == (...((z `f` x1) `f` x2) `f`...) `f` xn ``

-   `foldr (||) False [False, True, False]`
-   `foldl mod 1337 [1166, 86, 43]`

Now try to use `foldr` or `foldl` to solve the following exercises.

-   Make your own `sum` function.
-   Make your own `maximum` function, you may use `max`. Hint: assume
    numbers are \>= 0.
-   Make your own `reverse` function. Hint: use `flip`.
-   Make `last` using `foldl1`.

The following is an attempt to make a function `isSorted` that checks if
a list is sorted:

`isSorted ls = foldr1 (<=) ls`

but using it throws an error. Why is that? What should it do instead?
Implement it.

For an additional challenge try to implement it in one line (it need
only work for lists with at least 2 elements). Hint: One way is to at
least use a combination of `foldr, map, zip, tail` and a lambda
function. Another solution combines the functionality of the `map, zip`
and lambda, in `zipWith`.

Modules Beginning
=================

If you haven\'t already, start reducing the amount of parentheses you
use, by instead using function composition and application (the \'.\'
and \'\$\').

Usage
-----

Make a function that checks whether a string contains all the letters of
the English alphabet. Import `Data.Char` to get the function
`toLower :: Char -> Char`. For the string
`"The quick brown fox jumps over the lazy dog"` it should return `True`.

Make yet another version of quicksort using `partition` from
`Data.List`.

Make a `length` function using a fold.

Make an `elem` function using a `map` and a fold. Remake it using `any`.

Use `takeWhile` to find out how many numbers that squared are less than
some threshold.

Use `find` and `elemIndices` to find a string with, for example more
than 5 e\'s, in a list of strings.

(Dis-)Qualified
---------------

Complete the previous exercise in a file if you haven\'t already.

-   Write your own `partition` function, and make sure it is not being
    imported from `Data.List`.
-   Import `find` and `elemIndices` explicitly.
    -   Make the imports qualified and update your program accordingly.

Define your own
---------------

Export some of your cool new functions as a module. Note: you should use
the same name for your file as your module, e.g. you export a module
`MyFuncs`, that file should be named `MyFuncs.hs`.

Import and use your functions in another file. If you named your files
correctly, you should be able to do something like `import MyFuncs`.

Your own types
==============

It\'s time to start making your own types, here are some ideas for some
types you can make, but you are welcome to try something else if you
want. Remember to go read in LYH if you forgot something.

Shapes
------

Go through the shapes example in LYH.

A shape is either a cirle or a rectangle.

-   Circles are defined by x and y coordinates and a radius.
-   Rectangles are defined by their upper left corner and lower right
    corner.
-   Optional: Update so points are represented by their own class.
-   Make functions that calculate the surface area of a shape.
-   Make functions that move the shapes around.
-   Come up with other things to do with shapes.

Students
--------

A student has: name, exam number, list of enrolled courses, list of
grades.

-   Make the value constructor.
-   Make functions that can add or remove courses from the enrolled
    list.
-   Make a function to add a grade.
    -   Optional: Only allow grading for courses already enrolled.

### Persons

Rather than students directly, make a class for persons.

A person has a name, gender and age.

-   Make gender a type similar to `Bool`, choose whatever genders you
    like.
-   Replace name with person in student, and update the program
    accordingly.
-   Make some functions for persons, e.g. greetings based on name,
    gender and/or age.
-   Update the constructors for students and persons with record syntax
-   Come up with more functions to use on students and/or persons. E.g.:
    -   Given a list of persons, return a list of persons with voting
        rights.
    -   Given a list of students, return a list of students with at
        least some average grade.
        -   Make courses into a type as well, where courses have a name
            and a weight. Update the average to take the weight into
            account.

Trees
-----

A tree is a recursive datastructure. A tree can either be the empty tree
`Nil` (or `EmptyTree` from LYH), or be a `Node` and have a key and two
sub-trees (it is a binary tree). To make it a binary search tree,
everything in the left sub-tree must have a key smaller or equal to the
key in the current node, and everything in the right sub-tree must be
strictly larger (this is different from LYH, where duplicates are
removed).

-   Make the value constructors.
-   Make a function that takes a value and a tree, and inserts a node
    with the value as key into the tree.
-   Make a function that takes a value and a tree, and returns whether
    that value is the key of a node in the tree.
-   Make a function `takeT` that takes a value `h` (height) and a tree,
    and returns the first `h` layers of the tree.
-   Make a function `repeatT` that takes a value, and creates an
    infinite tree where the value is the key of every node.
-   Make a function `replicateT` that takes two values `k` and `h`, and
    creates a tree with `h` layers where all nodes have `k` as key.

We can make fold for trees like so:

``` {.haskell}
data Tree a = Nil | Node a (Tree a) (Tree a)

foldT _ z Nil = z
foldT f z (Node k l r) = f k (foldT f z l) (foldT f z r)
```

-   Write the type signature for `foldT`. Try to understand why the
    function was defined this way.
-   Define `f` such that `sizeT = foldT f 0` returns the number of nodes
    in the tree.
-   Define `f` such that `sumT = foldT f 0` returns the number of nodes
    in the tree.
-   Define `f` such that `heightT = foldT f 0` returns the number of
    nodes in the tree.
-   Define `f` such that `flattenT = foldT f []` returns the number of
    nodes in the tree.

Playing games
=============

Here are some suggestions for games you can make, more or less with what
you know at this point.

1D Lights out
-------------

Lights out is a game where you want to \"turn off\" all the lights, but
when you toggle one light, you also toggle the neighbouring lights.

A simple version of this works in just one dimension, and could be
represented with a list of `Bool`.

You can implement it however you want, but I think of it something like
this:

    ghci> Lights [False,True,False]
    Lights [False,True,False]
    ghci> toggle (Lights [False,True,False]) 3
    Lights [False,False,True]

Tic-tac-toe
-----------

Tic-tac-toe is a bit larger of a project. I recommend looking up
`Data.Array`, as a help to representing the board.

Once you are far enough I also recommend making a custom implementation
of `show`, rather than just deriving it.

In my implementation I had the player pieces as a type with three
possible values, where one was a \"dummy\" piece if no piece was at that
spot. It could also be implemented with `Maybe` instead.

Your own typeclass
==================

Try to make your own typeclass, if you need inspiration you can try to
make a `CharLike`, `Game` or `PlayerSet` typeclass.

CharLike
--------

Instances of `CharLike` should be convertible into a `Char`, e.g. if
`Bool` is an instance, then `True` could be converted into `'T'` and
`False` into `'F'`.

Make some instances of `CharLike`. As a start make `Char` an instance.

Add a function `similar` to the typeclass, that should see if the
character representation of two `CharLike` things is the same.

Game
----

A very simple `Game` typeclass might look something like this:

    class Game g where
      isEnd :: g -> bool

To make the typeclass more useful you should probably add more
functions, e.g. `move` or `getPlayers`. Note that you may have to
restructure your previous game(s) if you want it/them to fulfill the
requirements of your new typeclass.

PlayerSet
---------

A `PlayerSet` typeclass may look like this.

    class PlayerSet s where
      players :: s a -> [a]

Some instances could be `PlayerList`, `PlayerTuple` and `SinglePlayer`,
that you must define before you can define the instances.

Functors
========

Try to make some instances of the `Functor` typeclass. Here are some
suggestions:

-   `MyMaybe`, where you make your own implementation of `Maybe` and
    then make it an instance of `Functor`.
-   `Tree`, following the example in book, both for making the tree and
    making it an instance of `Functor`.
-   `Box`, a dummy type that simply holds a single value of \"unknown\"
    type.
-   `PlayerList`, `PlayerTuple` or `SinglePlayer` from the previous
    exercise.

Now use `fmap` with a function that changes the type of what you
implemented. For example, if you have `MyMaybe True`, that has type
`MyMaybe Bool`, use `fmap` with a function so it changes its type into
`MyMaybe Char`.
