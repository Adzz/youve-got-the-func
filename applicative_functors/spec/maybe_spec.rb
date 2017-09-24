require 'spec_helper'

RSpec.describe Maybe do
  let(:identity)  { ->(x) { x } }
  let(:add_ten) { ->(x) { x + 10 } }

  context "FUNCTOR" do
    context "The first functor law" do
      it "fmaping identity will return the same maybe" do
        maybe = Maybe.new("String")
        expect(maybe.fmap(identity)).to eq Maybe.new("String")
     end
    end

    context "As a mapp-able container it..." do
      let(:nothing) { Maybe.new(nil) }

      it "maps a function over the contained value applying it correctly" do
        expect(Maybe.new(10).fmap(add_ten)).to eq Maybe.new(20)
      end

      it "wont blow up if we map over a nothing" do
        expect(nothing.fmap(add_ten)).to eq nothing
      end

      it "hitting a nil in a chain of functions wont blow up" do
        stumbling_block = -> (_x) { nil }
        expect(Maybe.new(10).fmap(add_ten).fmap(stumbling_block)).to eq nothing
        expect(Maybe.new(10).fmap(stumbling_block).fmap(add_ten)).to eq nothing
      end
    end


    context "follows the second functor law" do
      it "composed functions are equal to successive non composed functions" do
        plus_four = ->(x) { x + 4 }
        plus_four_add_ten = -> (x) { x + 4 + 10 }

        maybe          = Maybe.new(10).fmap(plus_four).fmap(add_ten)
        composed_maybe = Maybe.new(10).fmap(plus_four_add_ten)
        expect(maybe).to eq composed_maybe
      end
    end

    context "BONUS ROUND" do
      let(:addition) { ->(x, y) { x + y  } }

      it "functions are partially applied" do
        expect(Maybe.new(10).fmap(addition).value.call(10)).to eq 20
      end

      it "....and composed!" do
        divide_by_ten = -> (x) { x / 10 }
        expect(Maybe.new(100).fmap(addition).fmap(divide_by_ten).value.call(10)).to eq 101
      end
    end
  end

  context "APPLICATIVES" do
    it ""
  end
end
