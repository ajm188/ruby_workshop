# Intro to Ruby

## The Basics

### An Interpreted Language

Ruby is an interpreted language. Most likely you have only programmed in a
compiled language before (if you only know Java, this is you). A compiled
language uses a compiler to transform a source program into a target program
(compile time). The target program is then run with whatever inputs you
wanted (runtime). This is also called two-stage execution.

For an interpreted language, there is no such thing as compile time.
Interpreted languages use an interpreter (not a compiler) to evaluate each line
of source code at runtime. So if I had the following code in a file called
"hello.rb":

```ruby
# hello.rb
puts "Hello, Ruby!" # puts = "PUT String"; it prints a string to the console, followed by a newline
```

And then run:
```ruby
$ ruby hello.rb
```
I would see the string "Hello, Ruby!" printed to the console.

One thing you may have noticed: no semi-colons!

### Interactive Ruby

One big advantage of using an interpreted language is that you can run code
interactively and view the results of code you are writing as you write each
line. To do this, run: `$ irb` (irb stands for "Interactive RuBy").

You'll probably see a '>'. You are now in an interactive Ruby session!
Anything you typ will be evaluated as Ruby code once you hit Enter. Protip:
this can also be used as a free calculator. Go ahead and do some arithmetic.

```
> 1 + 2
3
> 3 * 1 - 5
-2
```

Protip: I highly recommend that you keep an irb session open and try things out
as you follow along. Everything in these notes is correct, but doing things on
your own (and also experimenting to go deeper into a concept) will probably
help you understand everything better.

## Dynamic Typing and Objects

Ruby is a dynamically-typed language. In dynamically-typed languages, you don't
need to specify the types of your variables. Variables will just take on the
type of the value you assign to them.

```ruby
a = "foo"
a.class() #=> String (.class() returns the class of an object)
```

Now I have a variable called `a`, and the type of `a` is `String`. Since
variables don't have type declarations, this also means that they aren't bound
to particular types, and so you can reassign a variable to a value of any type.

```ruby
a = 5
a.class() #=> Fixnum
```

Now `a` is a `Fixnum`, and it has the value 5.

That last line (`a.class()`) may have looked a little strange to you, since that
is equivalent to the line `5.class()`. In most languages, numbers are typically
treated as primitives, so you can't do things like call methods on them. But
here is the first important concept in Ruby: **everything is an object**.
That's right; everything. Numbers, strings, arrays, and even methods and
classes are objects, but more on that later.

### Helpful Built-ins

Out of the box, Ruby provides some pretty useful (well, mostly) methods on
types you're likely to use a lot. Here are a few:

```ruby
# Fixnum
5.even?() #=> false (Ruby method names can end in "?"; this is used to signify a boolean return value)
5.odd?() #=> true
-5.abs() #=> 5
5.to_f() #=> 5.0 (to_f means "to floating point")
5.to_s() #=> "5" (to_s means "to string")

# String
"foo".length() #=> 3
"foo".empty?() #=> false

"foo".capitalize() #=> "Foo"
"foo".upcase() #=> "FOO"
"FOO".downcase() #=> "foo"
"FoO".swapcase() #=> "fOo" (I'm having a really hard time calling this one "useful", but it's there, so)

"foo".start_with?("fo") #=> true
"foo".end_with?("f") #=> false
"foo".reverse() #=> "oof"

"10".to_i() #=> 10
"10".to_i(2) #=> 2 (covert the string (in base 2) to an integer)
```

### Documentation

Protip: Ruby has great documentation for its built-in classes. If you ever want
to learn more about a particular class, a google search like "ruby <the-class>"
should point you in the right direction (you should be looking for pages from
ruby-doc.org). For example here is the
[String documentation](http://ruby-doc.org/core-2.2.0/String.html).

## Basic Syntax

Here is an overview of some of the basic syntactical structures in Ruby.

### `if`

```ruby 
if true
  puts 5
elsif false
  puts 4.5
else
  puts 4
end
```

Note the lack of parentheses around the conditions. Also note that `end`
signifies the ending of most blocks of Ruby code. Also note that `elsif` is one
word , with "else" missing teh ending "e". It's not `else if` (Java) or `elif`
(Python).

#### Truthyness

Any object can be used in the condition of an `if`. In Ruby, all objects are
"truthy" (they evaluate to true in a conditional) except for:

* `false`: a boolean (duh), and
* `nil`: a special "none" type that we'll talk about soon.

### `unless`

`unless` is a variation on `if`. It executes the first branch if the condition
is "falsey" (if anyone knows the actual spelling on that, humor me with a pull
request) and executes the "else" branch if the condition is "truthy".

```ruby
unless false
  puts 5
end
```

So the above snippet will print 5 to the console.

### Inline Modifiers

In its quest for maxmimum English-like readability, Ruby supports inline
versions of `if` and `unless`. These variations are called "inline modifiers".
You can use them like so:

```ruby
puts 5 if true
puts 5 unless true # This won't print anything
```

### Loops

There are a lot of ways to loop in Ruby. We're only going to talk about a few
for now.

#### `while`

```ruby
i = 0
while i < 5
  puts i
  i += 1
end
```

#### `until`

```ruby
i = 0
until i >= 5
  puts i
  i += 1
end
```

#### Inline Modifiers

Just like with if/unless, Ruby also allows inline while/until:

```ruby
i = 0
i += 1 while i < 10
puts i # prints out 10
i -= 1 until i < 5
puts i # prints out 4
```

#### `loop`

`loop do ...` is the Ruby way of writing an infinite loop.

```ruby
loop do
  puts "I'm in an infinite loop!"
end
```

#### `for`

`for` lets you iterate over things. There are more "Ruby" ways to do iteration,
but for now, here's `for`:

```ruby
for char in ["a", "b", "c"] # this is an array
  puts char
end
```

#### `case`

You may know this as `switch` from other languages, `case` is a powerful part
of the Ruby language.

```ruby
case "hello".length()
when 1
  puts "hello had length 1"
when 2, 3
  puts "hello had length 2 or 3"
when 7..9 # this thing is called a range. We'll talk about ranges later.
  puts "hello's length was between 7 and 9, inclusive"
when 5
  puts "hello had length 5"
else
  puts "hit the default case"
end
```

## Expressions

You may have noticed in the last section that I never used the word
"statement." This was deliberate on my part. Here is the second important
concept in Ruby: **Ruby is an expression-based language**. This means that Ruby
has no concepty of statements; everything is an expression. Also, because
expressions evaluate to values, this means that everything in Ruby (`if`s,
`while`s, assignments, etc) evaluate to a value. So the following code will
assign "odd" to `a`:

```ruby
a =
  if 5.odd?()
    "odd"
  else
    "even"
  end
```

Note that you can `if` expressions with more than one line of code in each
branch. In this case, the entire branch will evaluate to whatever the last line
of the branch evaluates to. So, this will assign 5 to `a`:

```ruby
a =
  if 5.odd?()
    "odd"
    5
  end
```

Now, what if `5.odd?()` had evaluated to false? (it wouldn't, but let's
pretend). What value would `a` have then? Well, the above `if` expression is
equivalent to the same `if` expression (I changed the conditional so that it's
actually false) with an empty else branch, like so:

```ruby
a =
  if 4.odd?()
    "odd"
    5
  else
  end
```

So the else branch does nothing. Well, Ruby has a value for that, and it's
called `nil` (explained more in the next section). So `if` expressions with no
else branch have an implicit else branch, which will evaluate to `nil`.

You can do the same thing with `case` expressions. The following code will
print "foo".

```ruby
puts case "hello".length()
when 5
  "foo"
else
  "bar"
end
```

What's going on here? The `case` expression matches on the first `when` clause,
which evaluates to the string "foo", so the whole `case` expression evaluates
to "foo". Then, the value of the `case` expression (which is "foo") is passed
to `puts`, so the whole snippet prints out "foo".

## Ruby Types

Ruby introduces some special types that you may not have seen before. Ruby also
uses some different approaches to types that you may already be familiar with.
I'll introduce them briefly here.

### `nil`

`nil` is the universal "none" or "no value" type in Ruby. Any object can have
the value `nil`, and you can check if an object is `nil` either by asking it:

```ruby
5.nil?() #=> false
nil.nil?() #=> true
```

or by taking advantage of the fact that `nil` is "falsey" (evaluates to false
in a conditional):

```ruby
if nil
  puts "This will never be printed because nil is falsey"
end
```

### Symbols

```ruby
sym = :a_symbol # symbols begin with a colon, followed by the name
sym2 = :a_different_symbol
```

Symbols can be a bit tricky to understand. Are they strings? Are they
contstants? Well, the answer is "both, kind of, and also more."

When a symbol literal appears in your code, Ruby creates a new symbol object,
*but only if a symbol by that name has not already been created*. Otherwise, it
just reuses the other symbol. In this way , symbols can be thought of as
memory-efficient strings.

```ruby
a = :a_symbol
b = :a_symbol # a and b point to the same object in memory
c = "a string"
d = "a string" # c and d don't
```

Since symbols provide unique names to thing you want to represent in your code,
and since you don't need to declare them before use (just go ahead and conjure
one up), symbol can also be thought of as a waya to create on-the-fly enums.

```ruby
lights = :on
lights = :off
# Using symbols to represent the status of the lights is a lot more readable than using booleans
lights = true
lights = false
```

Because of how easily symbols can be used to, well, symbolically represent
concepts in code, and due to their name-based uniqueness, symbols are often
used as the keys in hashes, a data structure we'll see in a little bit.

### Ranges

You already saw a range in the previous section. Ranges are a convenient way
to, as the name suggests, specify a range of values. You can define ranges on
any type of value that has some sort of ordering defined on it. For example
(`to_a` turns a range into an array, which you can use to see all of the values
in the range):

```ruby
(1..5).to_a #=> [1, 2, 3, 4, 5]
("car".."cat").to_a #=> ["car", "cas", "cat"] (this enumerates the strings in lexicographical order)
("cat".."car").to_a #=> [] (empty, because the start of the range comes after the end of the range)
(1.."foo") #=> ArgumentError (Fixnums and Strings can't really be compared with each other)
```

It is easy to check if a value falls within a range:

```ruby
(1..5).include?(4) #=> true
(1..5).include?(0) #=> false
# You can also use the .cover?() method
(1..1000).cover?(999) #=> true
```

Protip: `include?` is implemented to enumerate the values in the range, while
`cover?` just does comparisons on the start and end values, so `cover?` can be
significantly faster.

### Strings

There is no such thing as a "char" type in Ruby; everything is a String object.
This means that you can put strings in eithr single or double quotes, with some
exceptions. For the remainder of these notes, I will be using single-quoted
strings wherever possible (this is preferred by the Ruby style guide, and it
lets me type marginally faster). You do need double quotes if:
  * You want a single quote in your string without needing to escape it.
  * You want special characters (newlines, tabs, etc).
  * You need to do string interpolation.

#### What is String Interpolation?

Probably the best way to explain string interpolation is to give an example:

```ruby
a = 42
"The answer to life, the universe, and everything in it is #{a}"
```

The `#{...}` bit is the actual string interpolation. In string interpolation,
the contents of the curly braces are evaluated as Ruby code. Then the result of
calling `to_s` ("to string") on that is what gets put into the string in place
of the `#{...}`.

## Arrays

Arrays represent ordered collections of objects. The important thing to note
here is that I did not say "objects of a specific type." In Ruby, arrays can
have elements of multiple types, regardless of the degree of disparity between
the types:

```ruby
arr = [1, 'foo', :open, [:a_sub_array], nil, true]
```

I'm not sure why you would ever need an array like the one above, but the point
is that you can, and that's kind of cool. Perhaps a more reasonable, but still
trivial, example could be:

```ruby
arr = [[1, :odd], [2, :even], [3, :odd]]
```

Regardless, arrays have a lot of useful built-in methods that allow you to
treat them like a variety of classical data structures:

### Stack

```ruby
arr = [1, 2]
arr.push(3) #=> [1, 2, 3]
arr #=> [1, 2, 3]
arr.pop() #=> 3
arr #=> [1, 2]
```

### Queue

```ruby
arr = [1, 2, 3]
arr.shift() #=> 1
arr #=> [2, 3]
arr.unshift(5) #=> [5, 2, 3]
# shift/unshift gives you a LIFO (last in first out) queue. This is identical
# to a stack. To get a FIFO queue, use shift with push.
```

### Set

```ruby
[1, 2, 3] & [3, 4, 5] #=> [3] (set intersection)
[1, 2, 3] | [3, 4, 5] #=> [1, 2, 3, 4, 5] (set union)
arr = [1, 2, 3]
arr |= [3, 4, 5] #=> [1, 2, 3, 4, 5] (set union and assignment in one step!)
arr #=> [1, 2, 3, 4, 5]
```

### Matrix

```ruby
[[1, 2], [3, 4], [5, 6]].transpose #=> [[1, 3, 5], [2, 4, 6]]
```

## Hashes

Hashes are Ruby's hash table type (think Maps in Java). Hashes map a set of
keys to a set of values:

```ruby
hash = { :key => :value } # the '=>' is called is 'hash rocket' (yes, I'm serious)
```

Syntactically, you access the values of a hash the same way you access the
values of an array, except you use the key as the 'index':

```ruby
hash = { :key => :value }
hash[:key] #=> :value
```

You can have your keys be objects of any type, but symbols are most commonly
used:

```ruby
hash = { :key => :value, 'key' => 1 }
```

You can also add key-value mappings, simply by assigning to the new key:
```ruby
hash = {} # an empty hash
hash[:new_key] = :new_value # This will overwrite hash[:new_key] if it already had a value
```

Since symbols are so commonly used as keys, there is a shorthand you can use to
write hashes, provided the key is a symbol. This was borrowed from JSON. The
following hash definitions are equivalent:

```ruby
hash = { key: :value }
hash = { :key => :value }
```

## Each

Now that we know about some collections (arrays, hashes and ranges), let's
iterate over them the Ruby way. For this, we used the `each` method. Here's an
example:

```ruby
[1, 2, 3, 4].each do |number|
  puts number
end
```

Wat. What just happened? That `do |number| ... end` thing is called a block.
You can also write blocks like this:

```ruby
[1, 2, 3, 4].each { |number| puts number }
```

Standard Ruby style dictates that multi-line blocks should be written in the
`do ... end` style, while single-line blocks should be written with `{ ... }`.

### How Do Blocks Work?

I'm going to give a short answer for now; I'll cover blocks in a later session.
For now, it will be sufficient to think that the `each` method "yields" each
element of the collection as an argument to the block (the list of names
between the pipe ("|") characters), and the block is evaluated once per
iteration.

### Enumerables

Any enumerable type supports the `each` method, meaning that you can iterate
over ranges and hashes:

```ruby
(1..5).each { |number| puts number }
{ foo: 1, bar: 2 }.each { |key, value| puts "#{key} => #{value}" }
```

## Methods

Ruby methods are defined using the `def` keyword. Their definition ends with
the (can you guess?) `end` keyword. Here's a method that returns the factorial
of its argument:

```ruby
def factorial(n)
  if n == 0
    1
  else
    n * factorial(n - 1)
  end
end
```

> Hang on; you said this method returns a value? Why is there no `return`?
> \- *You, probably*

If you recall from earlier, everything in Ruby is an expression, and multi-line
expressions evaluate to the value of the their last line. So, when the method
is called, the last to be evaluated is either `1` or `n * factorial(n - 1)`, so
the method will return one of those values, depending on how the `if` condition
evaluates. You can explicitly `return` if you want to, though it's usually not
necessary. Explicit `return`s are usually used to return early for exceptional
conditions. These are also called "guard clauses". For example, we may want to
return early from our factorial method if the argument is less than 0, as this
will result in inifinite recursion:

```ruby
def factorial(n)
  return if n < 0
  if n == 0
    1
  else
    n * factorial(n - 1)
  end
end
```

Note that you can define a method of the same name as many times as you like;
the behaviour of the `factorial` method will be whatever the most recent
definition of the method was.

Of course, this method can be written much more succintly using a helpful
`zero?` method, which is defined on the Fixnum class, and the ternary operator:

```ruby
def factorial(n)
  n.zero?() ? 1 : n * factorial(n - 1)
end
```

### Calling Methods

Up to this point in the notes, I have always been calling methods with
parentheses, just like in other programming languages. Guess what? *This is
optional in Ruby* (mostly). Ruby allows calling methods without parentheses
(even for methods that take arguments) to help make code more readable. As a
result, you should omit parentheses from method calls wherever it makes your
code more readable.

Also note that although you can also define methods without parentheses around
their formal parameter lists (something you may see on StackOverflow or
elsewhere on the internet), this is considered poor style, and so you really
shouldn't.

```ruby
factorial(5) #=> 120
factorial 5 #=> 120
factorial factorial 3 #=> 720 (parens aren't required here; the arguments bind to the right)
```

### Optional Arguments

Above, I stated that redefining a method simply changes the behavior of the
method to the new definition. This means that things like method overloading
from Java and C++ are out. How then, do we handle methods that share most of
their behavior, but take different numbers of arguments? Enter optional
arguments.

A method can be defined with some (or all) of its arguments to be optional. For
an optional argument, if a value is passed in for that argument, the passed-in
value will be used. Otherwise, the argument takes on some default value which
you specify when you define the method.

Consider a method to return a substring of a string. This method should
definitely take at least two arguments:
* the string itself
* the index the substring should start from

Optionally, we'd like to be able to take a third argument specifying the length
of the substring. By default, this should be the length of the string minus the
starting index (do you see why?). You might be inclined to write something like
this:

```ruby
def substring(string, start_index, length = nil)
  length = string.length - start_index if length.nil?
  # substring magic ...
end
```

But, Ruby is actually more powerful than this. When a method is called, the
parameters passed to the method are evaluated in order from left to right in
the argument list. This means that you can define default values for arguments
in terms of arguments that appear earlier in the argument list, so our
substring method actually looks like:

```ruby
def substring(string, start_index, length = string.length - start_index)
  string[start_index, length]
end
```

That pseudo-array-like syntax is called slicing. In the above case, it returns
`length` characters from `string` starting from `start_index`. There are a few
different forms of slicing, and you can also slice arrays (strings can be
thought of as arrays of characters). There is some good
[documentation](http://ruby-doc.org//core-2.2.0/String.html#method-i-slice) on
all the different ways you can slice.

We can now call our method using two or three arguments:

```ruby
substring 'hello', 1 #=> 'ello'
substring 'hello', 1, 2 #=> 'el'
```

## Classes

Classes are the way to create abstractions about data and behavior in Ruby (and
any Object-Oriented language for that matter, but Ruby is super OO).

Classes are defined with the `class` keyword. Class definitions end with `end`
(of course). Class names should be capitalized (technically, they are
constants, but we'll talk about that another time), and CamelCased. I suppose
I should also mention at this point that variable and method names in Ruby
should always be snake_cased. If you are really gung-ho about camel casing,
[here's a study](http://www.researchgate.net/profile/Bonita_Sharif/publication/224159770_An_Eye_Tracking_Study_on_camelCase_and_under_score_Identifier_Styles/links/00b49534cc03bab22b000000.pdf)
you can read about the two styles. Either way, Ruby uses snake casing, so get
over it.

Here's an example; the canonical 'Greeter' class:
```ruby
class Greeter
  # This is the constructor. When you create a new instance of your class, this
  # is the code that will be executed.
  def initialize(name)
    # Instance variables begin with the '@' character, and can be referenced in
    # any instance method of the class.
    @name = name
  end

  # An instance method.
  def greet
    # The @name instance variable is accessible here, because this is an
    # instance method.
    puts "Hello, #{@name}"
  end
end
```

Now that we have defined the `Greeter` class, we can create new `Greeter`
objects by calling the `new` method:

```ruby
my_greeter = Greeter.new('Andrew')
```

The `new` method creates a new object of the given type and returns the
newly-created object.  `new` passes along any arguments passed to it to the
`initialize` method internally.

Now that we have a `Greeter` object, we can invoke any of its instance methods.
In this case, we'll invoke the `greet` method:

```ruby
my_greeter.greet # will print 'Hello, Andrew' to the console
```

### Getters and Setters

Objects contain data. Sometimes we want to access this data. If we were writing
in a language like Java, we would need to write a getter and setter for all of
these attributes. This is a lot of wasted typing. Luckily, Ruby provides some
really helpful class macros to cut down on this relatively useless code:
* `attr_reader` - defines getters
* `attr_writer` - defines setters
* `attr_accessor` - defines both getters and setters

Here's how to use them:

```ruby
class Person
  attr_reader :first_name, :last_name
  attr_accessor :nickname
end
```

The above form is much more preferred to the more verbose form (below), both
because it provides the same functionality in less space, and also because it
communicates the intent of the code much more clearly and concisely.

```ruby
class DumbJavaPerson
  def first_name
    @first_name
  end

  def last_name
    @last_name
  end

  def nickname
    @nickname
  end

  # Even though you should probably never write your own setters by hand, it's
  # worth noting that this is what they actually look like. Ruby allows you to
  # call a setter with a space between the attribute name and the '=' for
  # readability, so when you say object.attribute = 5, you're really calling
  # the "attribute=" method defined on "object" and passing it the argument 5.
  def nickname=(new_nickname)
    @nickname = new_nickname
  end
end
```

### Inheritance

Ruby also has inheritance, which is signified by the '<' character:

```ruby
class Student < Person
end
```

Now, all of the methods defined in `Person` are available to `Student` objects:

```ruby
Student.new.first_name #=> nil, but only because @first_name hasn't been given a value yet
Student.new.nickname = 'Andrew' #=> 'Andrew'
```

#### Overriding Methods

You can, of course, 'override' methods by redefining them in the subclass. If
you need to reference the parent's behavior, just call `super`. Protip: if you
call `super` with no arguments (and no parentheses), it will pass along any
arguments that were passed in to the parent implementation of the method:

```ruby
class Student < Person
  def nickname=(new_nickname)
    super # implicitly passes 'val' to super
    puts "nickname was changed to #{val}"
  end
end
```

## Your Turn!

Probably the best way to learn a new language is to actually write stuff in it.
So, I have a task for you:

In [grades.csv](grades.csv), you'll find my grades from last semester. Clearly,
I had a rough time in Calc I. I need to know what my GPA was, and I want you to
write a Ruby program to calculate my GPA for me. To do this, we need a library
that Ruby provides for parsing CSV files. If you look in
[gpa_calc.rb](gpa_calc.rb), you'll find some skeleton code I've left to get you
started. It loads in the CSV module (more on modules later), gets the name of
the file from the command line arguments, and makes the correct call to the CSV
module to load the data. Your code should go where the `TODO` comments are.

### REPL-Driven Development

If you are confused about how to interact with the data that the CSV library
gives you, pop open an irb session and play around with the result of the CSV
call in there. This should help you figure out how you want to handle and do
calculations on the data. In fact, this style of development has become so
popular that it has earned the name "REPL-Driven Development" (irb is a REPL,
which stands for "read, evaluate, print loop"). This isn't really relevant to
anything else we're talking about, but I'm just going to leave this information
here. Do whatever you will with it.

Solutions can be found in the 'solutions' branch of this repository.
