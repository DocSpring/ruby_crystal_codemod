class ExampleClass
  @foo : Int32 | Nil
  @bar : Int32 | Symbol
  @baz : Int32 | Nil

  property :foo, :bar

  def initialize(@foo : Int32 | Nil, @bar : Int32 | Symbol)
  end

  def baz=(val : Int32) : Int32
    @baz = val
  end

  def add(val : Int32 = 0) : Int32
    foo = @foo
    return 0 unless foo.is_a?(Int32)
    bar = @bar
    return 0 unless bar.is_a?(Int32)
    foo + bar + val + (@baz || 0)
  end

  def self.whisper(str : String) : String
    str.downcase.gsub(/o+$/, "o")
  end

  def shout(str : String) : String
    str.upcase.gsub(/O+$/, "O" * 16)
  end
end
