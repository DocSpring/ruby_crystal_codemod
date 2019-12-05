#~# ORIGINAL

 foo  and  bar

#~# EXPECTED

foo && bar

#~# ORIGINAL

 foo  or  bar

#~# EXPECTED

foo || bar

#~# ORIGINAL

 not  foo

#~# EXPECTED

!foo

#~# ORIGINAL

!x

#~# EXPECTED

!x


#~# ORIGINAL not_paren_x

not(x)

#~# EXPECTED

!(x)

#~# ORIGINAL not_space_paren_x

not (x)

#~# EXPECTED

!(x)

#~# ORIGINAL not_space_x

not x

#~# EXPECTED

!x

#~# ORIGINAL

not((a, b = 1, 2))

#~# EXPECTED

!((a, b = 1, 2))
