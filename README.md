---
  tags: todo, tdd, directory structure, introduction
  languages: ruby
  resources: 2
---

# structured-learning

This lab guides you through setting up a conventional looking Ruby application with multiple directories. 

## A Typical Ruby Application

### `lib/`

The `lib/` directory should be where all of your application's code lives: methods, classes, etc.

We have two simple classes in the files `bar.rb` and `foo.rb`. They should live in `lib/`.

### `config/`

The `config/` directory houses code that, as you can guess, configures your app. One file that often goes in here is...

#### `environment.rb`

Think of `environment.rb` as a manifest for all of your files. It should require all of your executable code (like what's in `lib/`. In turn, other code that executes it should require `environment.rb`; it's easier and cleaner to require just this one file everything then continuously updating whenever you add a new class.

Below we'll talk about what should be requiring `environment.rb`.

To pass the tests, make an `environment.rb` file and have it require the code in `lib/`.

### `bin/`

The `bin/` directory holds files that work to execute your code. Where you code is defined should always be separate from where it's executed.

Create a file called `run.rb` which runs the `Foo` class. Be sure that it requires `environment.rb`, so that it knows about `Foo` and `Bar`.

### `spec/`

You should already be familiar with what's going on in `spec/`, but let's dive in to what's happening within this folder a bit more. File(s) that hold tests end in "_spec" (like `file_structure_spec.rb`). Note that this is requiring a file called `spec_helper.rb`, which does two things: holds configuration settings that apply to any spec file that requires it, and requires `environment.rb`, so it knows about the code that its testing.

Get the tests to pass!

### `.rspec`

`.rspec` is a top-level file that has has settings for the spec executable `rspec`. Experiment with removing the `--color` line and running `rspec`!

### `Gemfile`

The Gemfile is the manifest for all of a program's dependencies, aka, gems.

Running `bundle init` creates a new Gemfile and running `bundle install` creates a `Gemfile.lock` file which locks in gem versions for your program. If you ever need to update a gem's version so it's reflected in the lock file, run `bundle update`.

Get the tests to pass!

## Resources
* [Lean Ruby the Hard Way](http://ruby.learncodethehardway.org/) - [Exercise 46: A Project Skeleton](http://ruby.learncodethehardway.org/book/ex46.html)
* [RubyGems](http://guides.rubygems.org/) - [What is a Gem](http://guides.rubygems.org/what-is-a-gem/)
