# See: https://crystal-lang.org/reference/syntax_and_semantics/operators.html

#~# ORIGINAL unary

puts "not false" if !false

#~# EXPECTED

puts "not false" if !false

#~# ORIGINAL unary

puts "not false" if not false

#~# EXPECTED

puts "not false" if !false

#~# ORIGINAL unary

puts "not !true" if not !true

#~# EXPECTED

puts "not !true" if !!true

#~# ORIGINAL unary

puts "is !!true" if !!true

#~# EXPECTED

puts "is !!true" if !!true

#~# ORIGINAL operator_and

true && puts("yeah")

#~# EXPECTED

true && puts("yeah")

#~# ORIGINAL operator_or

false || puts("yeah")

#~# EXPECTED

false || puts("yeah")

#~# ORIGINAL operator_and

true and puts("yeah")

#~# EXPECTED

true && puts("yeah")

#~# ORIGINAL operator_or

false or puts("yeah")

#~# EXPECTED

false || puts("yeah")
