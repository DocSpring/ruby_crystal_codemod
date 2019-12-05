
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
