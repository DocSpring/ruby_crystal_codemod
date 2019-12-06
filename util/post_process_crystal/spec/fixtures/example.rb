class Foo
  attr_accessor :foo

  #~# BEGIN ruby
  def initialize(foo)
    @foo = foo
  end
  #~# END ruby
  #~# BEGIN crystal
  # @foo : Int32
  # def initialize(@foo: Int32); end
  #~# END crystal
end
