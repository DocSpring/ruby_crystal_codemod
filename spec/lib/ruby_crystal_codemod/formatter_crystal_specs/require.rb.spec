# See: https://crystal-lang.org/reference/syntax_and_semantics/requiring_files.html

#~# ORIGINAL require

require "subfolder/double"

#~# EXPECTED

require "subfolder/double"


#~# ORIGINAL require

require 'subfolder/double'

#~# EXPECTED

require "subfolder/double"

#~# ORIGINAL require

require \
  "subfolder/double"

#~# EXPECTED

require "subfolder/double"

#~# ORIGINAL require

require \
  \
  'subfolder/double'

#~# EXPECTED

require "subfolder/double"

#~# ORIGINAL require

require(
  "subfolder/double"
)

#~# EXPECTED

require "subfolder/double"

#~# ORIGINAL require

require(

  'subfolder/double'
)

#~# EXPECTED

require "subfolder/double"

#~# ORIGINAL require

require(
  "subfolder/double"
); puts 'helllooooooooooooo'

#~# EXPECTED

require "subfolder/double"
puts "helllooooooooooooo"

#~# ORIGINAL require

require 'subfolder/double'; puts 'hello'

#~# EXPECTED

require "subfolder/double"
puts "hello"

#~# ORIGINAL require_relative

require_relative './subfolder/double'

#~# EXPECTED

require "./subfolder/double"

#~# ORIGINAL require_relative

require_relative "subfolder/double"

#~# EXPECTED

require "./subfolder/double"

#~# ORIGINAL require_relative

require_relative "../crystal_codemod_test/subfolder/double"

#~# EXPECTED

require "../crystal_codemod_test/subfolder/double"

#~# ORIGINAL require_relative

require_relative 'subfolder/triple'

#~# EXPECTED

require "./subfolder/triple"

#~# ORIGINAL require_relative

require_relative "subfolder/triple"

#~# EXPECTED

require "./subfolder/triple"

#~# ORIGINAL require_relative

require_relative \
  "subfolder/triple"

#~# EXPECTED

require "./subfolder/triple"

#~# ORIGINAL require_relative

require_relative("subfolder/triple")

#~# EXPECTED

require "./subfolder/triple"

#~# ORIGINAL require_relative

require_relative(
  "subfolder/triple"
)

#~# EXPECTED

require "./subfolder/triple"
