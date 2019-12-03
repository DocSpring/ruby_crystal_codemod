# Ruby => Crystal Codemod

This project is a fork of [Rufo](https://github.com/ruby-formatter/rufo).

> Rufo is as an _opinionated_ ruby formatter, intended to be used via the command line as a text-editor plugin, to autoformat files on save or on demand.

The formatting rules have been modified in an attempt to produce some semi-valid Crystal code. Then you need to add some type annotations and fix any other issues manually. See the [Crystal for Rubyists](https://github.com/crystal-lang/crystal/wiki/Crystal-for-Rubyists) wiki page to learn more about the syntax differences.

> Ruby => Crystal Codemod / Rufo supports all Ruby versions >= 2.4.**5**, due to a bug in Ruby's Ripper parser.

## Next Steps:

* Once you've fixed all of the syntax and type errors, run `crystal tool format` to autoformat your code.
* Run [Ameba](https://github.com/crystal-ameba/ameba) for static code analysis (similar to RuboCop), and fix all of the errors.
  * *(Unfortunately Ameba doesn't have a --fix option yet.)*

## Installation

Install the gem with:

```
$ gem install ruby_crystal_codemod
```

## Status

- [x] Rename all file extensions from `.rb` to `.cr`
- [x] Replace single quoted strings with double quotes
- [ ] `require_relative "foo"` -> `require "./foo"`
- [ ] Translate methods / keywords / operators:
  - [ ] `include?` -> `includes?`
  - [ ] `key?` -> `has_key?`
  - [ ] `detect` -> `find`
  - [ ] `collect` -> `map`
  - [ ] `respond_to?` -> `responds_to?`
  - [ ] `length`, `count` -> `size`
  - [ ] `__dir__` -> `__DIR__`
  - [ ] `and` -> `&&`
  - [ ] `or` -> `||`
  - [ ] `foo.each(&:method)` -> `foo.each(&.method)`
  - [ ] `foo.map &:method` -> `foo.map &.method`

## Testing

So far I've just hacked together some example code in `./example_code/example.rb`.
Run `./run_rufo` to process the Ruby files `./example_code` and generate Crystal files in the same directory.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/DocSpring/ruby_crystal_codemod.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
