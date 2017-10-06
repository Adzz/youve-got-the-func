require "spec_helper"
require "monoid"

RSpec.describe Addition do
  let(:other)       { Addition.new(15) }
  let(:other_other) { Addition.new(300) }
  let(:identity)    { Addition.new(0) }
  subject { described_class.new(10) }

  it "Is Binary" do
    expect(subject.mappend(other)).to eq Addition.new(25)
  end

  it "Associativity" do
    expect(subject.mappend(other).mappend(other)).to eq subject.mappend(other.mappend(other))
  end

  it "Identity" do
    expect(subject.mappend(identity)).to eq subject
  end
end
