#~# ORIGINAL properties_attr_accessor

class Foo
  attr_accessor :foo
end

#~# EXPECTED

class Foo
  property :foo
end

#~# ORIGINAL properties_attr_accessor

class Foo
  attr_accessor :foo, :bar
end

#~# EXPECTED

class Foo
  property :foo, :bar
end

#~# ORIGINAL properties_attr_reader

class Foo
  attr_reader :foo
end

#~# EXPECTED

class Foo
  getter :foo
end

#~# ORIGINAL properties_attr_reader

class Foo
  attr_reader :foo, :bar
end

#~# EXPECTED

class Foo
  getter :foo, :bar
end

#~# ORIGINAL properties_attr_writer

class Foo
  attr_writer :foo
end

#~# EXPECTED

class Foo
  setter :foo
end

#~# ORIGINAL properties_attr_writer

class Foo
  attr_writer :foo, :bar
end

#~# EXPECTED

class Foo
  setter :foo, :bar
end
