# typed: ignore

class ExampleClass
  attr_accessor :foo, :bar, :qux

  def initialize(foo, bar, qux)
    @foo = foo
    @bar = bar
    @qux = qux
  end

  def baz=(val)
    @baz = val
  end

  def add(val = 0)
    @foo + @bar + @qux + val + (@baz || 0)
  end

  def self.whisper(str)
    str.downcase.gsub(/o+$/, 'o')
  end

  def shout(str)
    str.upcase.gsub(/O+$/, 'O' * 16)
  end
end
