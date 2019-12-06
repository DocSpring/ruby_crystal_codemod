$:.unshift __dir__

require_relative './subfolder/double'
require_relative "./subfolder/double"
require \
  "subfolder/double"
require(
  "subfolder/double"
)
require(
  "subfolder/double"
); puts 'helllooooooooooooo'
require 'subfolder/double'; puts 'hello'
require_relative "../crystal_codemod_test/subfolder/double"
require_relative 'subfolder/triple'
require_relative "subfolder/triple"
require_relative \
  "subfolder/triple"
require_relative("subfolder/triple")
require_relative(
  "subfolder/triple"
)

def fuel_for(mass)
  puts "Calculating fuel for mass: #{mass}"
  fuel = (mass.to_i / 3).floor.to_i - 2
  return 0 if fuel <= 0
  fuel + fuel_for(fuel)
end

puts File.read(File.join(__dir__, 'input')).lines.sum { |mass| fuel_for(mass) }

puts "2 x 2: #{double(2)}"
puts "2 x 2 x 2: #{triple(2)}"

include NestedRequire
nested_require_works?
include ParentRequire
require_parent_file_works?


arr = %w[apple orange pear pineapple]
puts arr.include?('apple') ? 'got apple' : "don't got apple"

hash = { foo: 123, bar: 345, baz: 456 }
puts hash.key? :foo ? "got foo" : "don't got foo"

has_pear = arr.detect do |el|
  el == 'pear'
end
puts has_pear ? "has a pear" : "not has a pear"

has_pear = arr.detect { |el| el == 'pear' }
puts has_pear ? "has a pear" : "not has a pear"

puts arr.collect {|el| "#{el.upcase}!" }.join(", ")
upcased = arr.collect do |el|
  "#{el.upcase}!"
end
puts upcased.join(", ")

if arr.respond_to?(:map)
  puts "arr responds to map"
end

puts "array size: "
puts arr.length
puts arr.count
puts arr.size

puts "not false" if !false
puts "not false" if not false
puts "not !true" if not !true
puts "is !!true" if !!true

arr.size > 2 and arr.size < 10 and puts "arr size is between 2 and 10"

(arr.size < 2 or arr.size > 100_000) or puts "arr size is between 2 and 10"
(arr.size > 2 or arr.size > 100_000) or puts "should not be called"

puts arr.map(&:downcase).join('|')
upcase = arr.map &:upcase
puts upcase.join(' ')
up_reverse = arr.map(&:upcase).map &:reverse
puts up_reverse.to_s

class Foo
  attr_accessor :foo
  attr_writer :bar
  attr_reader :baz

  #~# BEGIN ruby
  def initialize(foo, bar, baz)
    @foo = foo
    @bar = bar
    @baz = baz
  end
  #~# END ruby
  #~# BEGIN crystal
  # @foo : Int32
  # @bar : Int32
  # @baz : Int32
  # def initialize(@foo: Int32, @bar : Int32, @baz : Int32)
  # end
  #~# END crystal

  def bar
    @bar
  end

  def baz=(val)
    @baz = val
  end
end

foo = Foo.new(1, 100, 1000)
puts "foo: #{foo.foo}"
puts "bar: #{foo.bar}"
puts "baz: #{foo.baz}"
foo.foo *= 2
puts "foo: #{foo.foo}"
foo.bar *= 2
puts "bar: #{foo.bar}"
foo.baz *= 2
puts "baz: #{foo.baz}"
