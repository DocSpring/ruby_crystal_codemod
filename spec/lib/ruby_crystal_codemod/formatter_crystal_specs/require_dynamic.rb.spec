# See: https://crystal-lang.org/reference/syntax_and_semantics/requiring_files.html

#~# ORIGINAL require_dynamic_expand_path_file

require File.expand_path('../formatter_spec', File.dirname(__FILE__))

#~# EXPECTED

require "spec/lib/ruby_crystal_codemod/formatter_spec"

#~# ORIGINAL require_dynamic_expand_path_dir

require File.expand_path('../formatter_spec', __dir__)

#~# EXPECTED

require "spec/lib/ruby_crystal_codemod/formatter_spec"

#~# ORIGINAL require_dynamic_join_dir

require File.join(__dir__, '../formatter_spec')

#~# EXPECTED

require "spec/lib/ruby_crystal_codemod/formatter_spec"


#~# ORIGINAL require_dynamic_space_plus_parens

require File.expand_path(
  '../formatter_spec',
  File.dirname(
    __FILE__
  )
)

#~# EXPECTED

require "spec/lib/ruby_crystal_codemod/formatter_spec"

#~# ORIGINAL require_dynamic

require(
  File.expand_path(
  '../formatter_spec',
    File.dirname(
      __FILE__
    )
  )
)

#~# EXPECTED

require "spec/lib/ruby_crystal_codemod/formatter_spec"

#~# ORIGINAL require_dynamic

require(File.expand_path(
'../formatter_spec',
  File.dirname(
    __FILE__
  )
))

#~# EXPECTED

require "spec/lib/ruby_crystal_codemod/formatter_spec"


#~# ORIGINAL require_dynamic

require f

#~# EXPECTED

require f

#~# ERRORS

"WARNING: require statements can only use strings in Crystal."

#~# ORIGINAL require_dynamic

require File.expand_path("../doesntexist", File.dirname(__FILE__))

#~# EXPECTED

require File.expand_path("../doesntexist", File.dirname(__FILE__))

#~# ERRORS

"WARNING: require statements can only use strings in Crystal"
/ERROR: Could not find .*spec\/lib\/ruby_crystal_codemod\/doesntexist.rb!/
"Please fix this require statement manually."

#~# ORIGINAL require_dynamic_dir_glob

require Dir.glob(File.join(__dir__, '../*.rb'))

#~# EXPECTED

require Dir.glob(File.join(__DIR__, "../*.rb"))

#~# ERRORS

"Evaluated path was not a string! Please fix this require statement manually."

#~# ORIGINAL require_dynamic_dir_glob_block

Dir.glob(File.join(__dir__, '../*.rb')).each do |f|
  require f
end

#~# EXPECTED

Dir.glob(File.join(__DIR__, "../*.rb")).each do |f|
  require f
end

#~# ERRORS

"WARNING: require statements can only use strings in Crystal."
"require args do not start with 'File.', so not attempting to evaluate the code."


#~# ORIGINAL require_dynamic_interpolation

asdf = "doesntexist"
require "#{asdf}"

#~# EXPECTED

asdf = "doesntexist"
require "#{asdf}"

#~# ERRORS

"String interpolation is not supported for Crystal require statements!"
