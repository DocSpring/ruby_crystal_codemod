require 'spec_helper'

describe ExampleClass do
  it 'should add @foo and @bar' do
    instance = ExampleClass.new(2, 3)
    expect(instance.add).to eq 5
  end

  it 'should add @foo and @bar and val' do
    instance = ExampleClass.new(2, 3)
    expect(instance.add(5)).to eq 10
  end

  it 'should add @foo and @bar and val and @baz' do
    instance = ExampleClass.new(2, 3)
    instance.baz = 10
    expect(instance.add(5)).to eq 20
  end

  it 'returns the correct value for ExampleClass.whisper' do
    expect(ExampleClass.whisper("HELLOOOOOOOOOOOOOOOO")).to eq "hello"
  end

  it 'returns the correct value for ExampleClass#shout' do
    instance = ExampleClass.new(nil, :random_unused_symbol)
    expect(instance.shout("hello")).to eq "HELLOOOOOOOOOOOOOOOO"
  end
end
