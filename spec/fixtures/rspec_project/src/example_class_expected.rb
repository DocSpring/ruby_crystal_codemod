class ExampleClass
  attr_accessor :foo, :bar

  sig { params(foo: Integer, bar: T.any(Integer, Symbol)).void }
  def initialize(foo, bar)
    @foo = foo
    @bar = bar
  end

  sig { params(val: Integer).returns(Integer) }
  def baz=(val)
    @baz = val
  end

  sig { params(val: Integer).returns(Integer) }
  def add(val = 0)
    @foo + @bar + val + (@baz || 0)
  end

  sig { params(str: String).returns(String) }
  def self.whisper(str)
    str.downcase.gsub(/o+$/, 'o')
  end

  sig { params(str: String).returns(String) }
  def shout(str)
    str.upcase.gsub(/O+$/, 'O' * 16)
  end
end
