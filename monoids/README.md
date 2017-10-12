## Monoids

First of all check [my blog post first](http://adzz.github.io/code/2017/10/05/category-theory-for-programmers-part-1-monoids/) for a more in depth look at what a monoid is.

There are many types of monoids, and the type for a monoid is very general, meaning there are many things we could imagine and implement as monoids.

For the example I have taken multiplication of numbers as an example.

Feel free to have a go experimenting creating your own monoids.

Classic examples include concatenation of arrays, addition, merging of hashes. A good way to think about a monoid is to think `reducable` - is the operation reducing to a single value? That might be an indication that a monoid is lurking somewhere. If it is, we can look at the other monoid laws and see if they hold.
