Lagrange is a companion Rails app for [Project Euler](http://projecteuler.net/), designed to make it easier to run, time, iterate, organize, and improve your solutions.

Getting Started
---------------

    > git clone git://github.com/jamesdabbs/lagrange.git
    > cd lagrange
    > bundle
    > rake setup  # will walk you through any user customization
    > foreman start
    
Using Lagrange
--------------

While foreman is active, Lagrange will watch your `solutions` directory for changes and check those changes automatically. Each solution file should be named `<problem #>.<extension>` and should implement a `solution` method which returns your final answer. See the included examples for reference.

You may also re-compute all of your existing solutions by running `rake solutions:check`.

### Adding Languages

Lagrange currently supports solutions in Ruby and C. To add support for a new language, you should add an entry in `app/values/language.rb/` and a `Solution` subclass in `app/models/solution/`. Your subclass should define the `attach_code` method. See `Solution::C` and `Solution::Ruby` for examples.

### To-do
- Site UI (re-compute, re-check links, color code by time, style)
- Submit / fetch answers from PE
- Add Haskell support, make languages more pluggable
