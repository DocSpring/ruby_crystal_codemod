require File.expand_path('./subfolder/nested_require', File.dirname(__FILE__))

require(
  File.expand_path('./subfolder/nested_require', File.dirname(__FILE__))
)

require \
  File.expand_path('example', __dir__)

require \
  File.expand_path('subfolder/triple', __dir__); puts 'hello'


require(
  "test"
); puts 'hello'

require 'test"\''; puts 'hello'

require 'test"\''
require "test'"
require("test")

require_relative 'test"'
require_relative "test"
require_relative("test")
