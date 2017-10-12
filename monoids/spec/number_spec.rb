require "spec_helper"
require "number"

RSpec.describe Number do
  let(:ten)   { Number.new(10) }
  let(:three) { Number.new(3) }
  let(:five)  { Number.new(5) }
  let(:identity_value)  { Number.new(1) }

  it "Is Binary" do
    expect(ten.multiply(three).class).to eq Number
  end

  it "Is Associative" do
    expect(ten.multiply(five).multiply(three)).to eq ten.multiply(five.multiply(three))
  end

  it "Has an Identity value" do
    expect(ten.multiply(identity_value)).to eq ten
    expect(identity_value.multiply(ten)).to eq ten
  end
end
