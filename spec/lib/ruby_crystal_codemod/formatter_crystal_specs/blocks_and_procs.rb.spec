# See: https://crystal-lang.org/reference/syntax_and_semantics/blocks_and_procs.html

#~# ORIGINAL block_do

method do |argument|
  argument.some_method
end

#~# EXPECTED

method do |argument|
  argument.some_method
end

#~# ORIGINAL block_curly

method { |argument| argument.some_method }

#~# EXPECTED

method { |argument| argument.some_method }

#~# ORIGINAL block_space_ampersand

method &:some_method

#~# EXPECTED

method &.some_method

#~# ORIGINAL block_paren_ampersand

method(&:some_method)

#~# EXPECTED

method(&.some_method)
