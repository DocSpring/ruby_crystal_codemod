# See: https://crystal-lang.org/reference/syntax_and_semantics/requiring_files.html

#~# ORIGINAL require_dynamic

require File.expand_path('../formatter_spec', File.dirname(__FILE__))

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
