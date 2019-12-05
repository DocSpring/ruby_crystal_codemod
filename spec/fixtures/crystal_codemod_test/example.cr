
require "./subfolder/double"
require "./subfolder/double"
require "subfolder/double"
require "subfolder/double"
require "subfolder/double"
puts "helllooooooooooooo"
require "subfolder/double"
puts "hello"
require "../crystal_codemod_test/subfolder/double"
require "./subfolder/triple"
require "./subfolder/triple"
require "./subfolder/triple"
require "./subfolder/triple"
require "./subfolder/triple"

def fuel_for(mass)
  puts "Calculating fuel for mass: #{mass}"
  fuel = (mass.to_i / 3).floor.to_i - 2
  return 0 if fuel <= 0
  fuel + fuel_for(fuel)
end

puts File.read(File.join(__DIR__, "input")).lines.sum { |mass| fuel_for(mass) }

puts "2 x 2: #{double(2)}"
puts "2 x 2 x 2: #{triple(2)}"

include NestedRequire
nested_require_works?
include ParentRequire
require_parent_file_works?

arr = %w[apple orange pear pineapple]
puts arr.includes?("apple") ? "got apple" : "don't got apple"

hash = { foo: 123, bar: 345, baz: 456 }
puts hash.has_key? :foo ? "got foo" : "don't got foo"

has_pear = arr.find do |el|
  el == "pear"
end
puts has_pear ? "has a pear" : "not has a pear"

has_pear = arr.find { |el| el == "pear" }
puts has_pear ? "has a pear" : "not has a pear"

puts arr.map { |el| "#{el.upcase}!" }.join(", ")
upcased = arr.map do |el|
  "#{el.upcase}!"
end
puts upcased.join(", ")

if arr.responds_to?(:map)
  puts "arr responds to map"
end

puts "array size: "
puts arr.size
puts arr.size
puts arr.size

puts "not false" if !false
puts "not false" if !false
puts "not !true" if !!true
puts "is !!true" if !!true

arr.size > 2 && arr.size < 10 && puts "arr size is between 2 and 10"

(arr.size < 2 || arr.size > 100_000) || puts "arr size is between 2 and 10"
(arr.size > 2 || arr.size > 100_000) || puts "should not be called"

# puts arr.each(&:upcase)
# puts arr.map(&:downcase).join('|')
