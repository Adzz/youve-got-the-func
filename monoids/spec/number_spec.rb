require "spec_helper"
require "number"

RSpec.describe Monoid do
  let(:ten)   { described_class.new(10) }
  let(:three) { described_class.new(3) }
  let(:five)  { described_class.new(5) }
  let(:zero)  { described_class.new(0) }

  it "Is Binary" do
    expect(ten.mappend(three).class).to eq described_class
  end

  it "Is Associative" do
    expect(ten.mappend(five).mappend(three)).to eq ten.mappend(five.mappend(three))
  end

  it "Has an Identity value" do
    expect(ten.mappend(zero)).to eq ten
    expect(zero.mappend(ten)).to eq ten
  end
end
