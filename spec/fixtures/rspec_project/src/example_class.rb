class ExampleClass
  attr_accessor :foo, :bar

  def initialize(foo, bar)
    @foo = foo
    @bar = bar
  end

  def baz=(val)
    @baz = val
  end

  def add(val = 0)
    @foo + @bar + val + (@baz || 0)
  end

  def self.whisper(str)
    str.downcase.gsub(/o+$/, 'o')
  end

  def shout(str)
    str.upcase.gsub(/O+$/, 'O' * 16)
  end
end
