# typed: true

require 'spec_helper'

RSpec.describe ExampleClass do
  it 'should add @foo and @bar' do
    instance = ExampleClass.new(2, 3, 4)
    expect(instance.add).to eq 5
  end

  it 'should add @foo and @bar and val' do
    instance = ExampleClass.new(2, 3, 4)
    expect(instance.add(5)).to eq 10
  end

  it 'should add @foo and @bar and val and @baz' do
    instance = ExampleClass.new(2, 3, 4)
    instance.baz = 10
    expect(instance.add(5)).to eq 20
  end

  it 'returns the correct value for ExampleClass.whisper' do
    expect(ExampleClass.whisper("HELLOOOOOOOOOOOOOOOO")).to eq "hello"
  end

  it 'returns the correct value for ExampleClass#shout' do
    # This call makes foo nilable, and adds Symbol to the bar types
    instance = ExampleClass.new(nil, :random_unused_symbol, 4)
    expect(instance.shout("hello")).to eq "HELLOOOOOOOOOOOOOOOO"
  end
end
