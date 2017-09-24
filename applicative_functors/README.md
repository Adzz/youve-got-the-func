### Applicative Functors!

As we saw from implementing an `fmap` function for our functor(s), we can now apply functions to values wrapped in our contexts. In the case of our `maybe` functor, we can apply a function to a vlaue if it exists, and not break anything if it doesn't exist.

Things got a little tricky when we started trying to partially apply functions. Here's a scenario:

```ruby
Maybe.new(50).fmap(divide).fmap(plus_four)
```

This chain of `fmap`s will leave us with a `Maybe` that contains a function awaiting a final parameter. But how can we apply that final value?

Right now we can only access it by exposing the `Maybe`'s internals like so:

```ruby
Maybe.new(50).fmap(divide).fmap(plus_four).value.call(6)
```

Yuck. We'll lose all the value of having placed it in the `Maybe` context if we do this!

What we really want to do is to be able to take this wrapped function and apply it to a wrapped value.

That is what an applicative is.

Just like functors, applicatives have laws. They look like this:

1. Applying a wrapped identity function to a wrapped value should return the wrapped value unchanged
2. Applying a wrapped function to a wrapped value is the same as applying an unwrapped function to an unwrapped value, and then wrapping it.
3. Wrapped functions still compose as we would expect.
4. This one takes some explaining, the best way to show it is by example:

```ruby
Maybe.new(10).apply(Maybe.new(add_ten)) == Maybe.new(add_ten).apply(Maybe.new(->(func){ func.call(10)}))
```

### Excercise

Head to the `spec` folder and have a look at the tests. I've written tests to guide you towards an applicative functor implementation of a Maybe type. Un `x` the tests one at a time to step towards the solution.

