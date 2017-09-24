### Functors

What are containers, and why are they useful?

Containers wrap our values (...and functions...) - wrap the things they contain in a computational context. This context is super handy.

Here are some containers that we already use everyday:

1. List
2. Array
3. Hash
4. Tuple
6. String
7. Class
8. Struct
9. Integer
8. Function

All of these can be seen as decorating the thing they contain in some kind of context. When we represent a number as a string, we give it all of the methods a string has. When we represent it as an Integer, it has a different context, meaning we can do different things with it.

We can clearly see the value in these containers; without some sort of computational context, we wouldn't be able to do anything!

But it's not good enough to just put values inside lists, or hashes... We still want to be able to do things to those values, once they are inside that context.


So let's take an array. How would we operate on a value in an array?

We'd use a `map` function:

```["this","is","cool"].map(&:upcase)```

The map function takes each value one at a time and applies the function we supply to it. Crucially, we are returned a new array of values at the end. That is to say when we are returned the operated-on-values, they are still in their computational context - the array.

This is awesome.

Contexts like Arrays that implement a way for functions to be mapped over their contained values are known as FUNCTORS.


Functors have some laws that should hold for all of them. They are MAPPABLE containers for which:

1. If we map the id function over a functor, the functor that we get back should be the same as the original functor.

2. Composing two functions and then mapping the resulting function over a functor should be the same as first mapping one function over the functor and then mapping the other one.


Wait what is the id function? This:

```
def identity(x)
  x
end
```

I know right?!* Seems kind of obvious that we would get back the same array if the function we map over the array literally does nothing to the values inside it. The idea here is that the only thing that can change the values inside the array is the function that we map over it with.


The second law also seems sort of obvious:

`[1,2,3,4].map {|x| x + 1}.map{|y| y * 10 } == [1,2,3,4].map {|x| (x + 1) * 10}`

So with that, let's have a crack at implementing our own.


### Excercise 1

Head to the functor folder and have a look at the tests. I've written tests to guide you towards a functor implementation of a Maybe type. Un `x` the tests one at a time to step towards the solution.













*The idea here is that it simply lifts the value up to the function context. In a sense, we could say it wraps the value in a function context... Remember how we said functions were containers...?

Interestingly string isn't a functor - maybe we could make it one?
